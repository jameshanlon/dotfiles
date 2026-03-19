#!/bin/bash
set -e

usage() {
  cat <<EOF
Usage: bash setup.sh [OPTIONS]

Install dotfiles by symlinking configs into \$HOME and setting up tools.

Options:
  -h, --help    Show this help message and exit

Environment variables:
  SKIP_BUILD=1  Skip building vim, tmux-mem-cpu-load, and vim plugin install

What it does:
  - Symlinks dotfiles from ~/dotfiles/config/ to ~/.<file>
  - Backs up existing dotfiles with a .old.<timestamp> suffix
  - Copies bashrc to ~/.bashrc (not symlinked)
  - Symlinks VS Code settings
  - Downloads git-prompt, git-completion, Vim-Plug, fzf
  - Clones and builds tmux-mem-cpu-load and vim from source
  - Installs Tmux Plugin Manager (tpm)
EOF
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 0
fi

DIR="$HOME/dotfiles"
CONFIG="$DIR/config"
DOTFILES="\
  aspell.en.prepl \
  aspell.en.pws \
  claude/settings.json \
  gitconfig \
  gvimrc \
  ssh-agent.bash \
  tmux.conf \
  vimrc \
  zshrc \
  "

if ! [ "$PWD" = "$HOME/dotfiles" ]; then
  echo "Expecting dotfiles in $HOME"
  exit 1
fi

echo "Installing in $HOME"
echo "Changing to $DIR"
cd "$DIR"

for f in $DOTFILES; do
  echo "==== dotfile: $f ===="
  p="$HOME/.$f"
  # Make directories if required
  mkdir -p "$HOME/.$(dirname "${f}")"
  # Make a copy of a dotfile, otherwise delete it
  if [ -f "$p" ] && ! [ -L "$p" ]; then
    echo "Backing up existing dotfile '~/.$f'"
    date=$(date +"%Y%m%d%H%M%S")
    mv "$p" "$p.old.$date"
  else
    rm -f "$p"
  fi
  # Make symlink
  echo "Creating symlink to '.$f' in ~/"
  ln -s "$CONFIG/$f" "$HOME/.$f"
done

# VS Code settings (path differs by OS)
if [[ "$OSTYPE" == "darwin"* ]]; then
  VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
else
  VSCODE_SETTINGS_DIR="$HOME/.config/Code/User"
fi
mkdir -p "$VSCODE_SETTINGS_DIR"
if [ -f "$VSCODE_SETTINGS_DIR/settings.json" ] && ! [ -L "$VSCODE_SETTINGS_DIR/settings.json" ]; then
  date=$(date +"%Y%m%d%H%M%S")
  mv "$VSCODE_SETTINGS_DIR/settings.json" "$VSCODE_SETTINGS_DIR/settings.json.old.$date"
else
  rm -f "$VSCODE_SETTINGS_DIR/settings.json"
fi
ln -s "$CONFIG/vscode/settings.json" "$VSCODE_SETTINGS_DIR/settings.json"

# bashrc is copied (not symlinked) - back up any existing one first
if [ -f "$HOME/.bashrc" ]; then
  cp "$HOME/.bashrc" "$HOME/.bashrc-original"
fi
cp "$CONFIG/bashrc" "$HOME/.bashrc"

# Git prompt
curl -fso ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# Git completion
curl -fso ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ "${SKIP_BUILD:-0}" != "1" ]; then
  vim -c "PlugInstall|qall"
fi

# fzf
if [ ! -d ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi
~/.fzf/install --all

# Tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Tmux mem-cpu-load
if [ ! -d ~/.tmux-mem-cpu-load ]; then
  git clone https://github.com/thewtex/tmux-mem-cpu-load.git ~/.tmux-mem-cpu-load
fi
if [ "${SKIP_BUILD:-0}" != "1" ]; then
  mkdir -p ~/.tmux-mem-cpu-load/build
  (cd ~/.tmux-mem-cpu-load/build; \
    cmake ..; \
    make)
fi

# vim
if [ ! -d ~/vim-src ]; then
  git clone --depth 1 https://github.com/vim/vim.git ~/vim-src
fi
if [ "${SKIP_BUILD:-0}" != "1" ]; then
  (cd ~/vim-src/src; \
    ./configure --prefix="$HOME/vim" --with-features=huge --enable-python3interp; \
    make && make install)
fi
