#!/bin/bash
set -e

DIR=$HOME/dotfiles
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

if ! [ $PWD = $HOME/dotfiles ]; then
  echo "Expecting dotfiles in $HOME"
  exit 1
fi

echo "Installing in $HOME"
echo "Changing to $DIR"
cd $DIR

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
  ln -s "$DIR/$f" "$HOME/.$f"
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
ln -s "$DIR/vscode/settings.json" "$VSCODE_SETTINGS_DIR/settings.json"

if test -f "$HOME/.bashrc"; then
  cp ~/.bashrc ~/.bashrc-original
  cp bashrc ~/.bashrc
fi

# Git prompt
curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# Git completion
curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c "PlugInstall|qall"

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Tmux mem-cpu-load
git clone https://github.com/thewtex/tmux-mem-cpu-load.git ~/.tmux-mem-cpu-load
mkdir ~/.tmux-mem-cpu-load/build
(cd ~/.tmux-mem-cpu-load/build; \
  cmake ..; \
  make && make install)

# vim
git clone --depth 1 https://github.com/vim/vim.git ~/vim-src
(cd ~/vim-src/src; \
  ./configure --prefix=$HOME/vim/install --with-features=huge --enable-python3interp; \
  make && make install)

## Install ssh-ident (https://github.com/ccontavalli/ssh-ident):
#mkdir -p ~/bin; wget -O ~/bin/ssh goo.gl/MoJuKB; chmod 0755 ~/bin/ssh
#echo 'export PATH=~/bin:$PATH' >> ~/.bashrc
