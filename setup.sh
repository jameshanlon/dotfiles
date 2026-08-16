#!/bin/bash
set -euo pipefail

# Report where a failure happened, since the script is long and partly network
# and build bound.
trap 'echo "setup.sh: failed at line $LINENO: $BASH_COMMAND" >&2' ERR

usage() {
  cat <<EOF
Usage: bash setup.sh [OPTIONS]

Install dotfiles by symlinking configs into \$HOME and setting up tools.

Options:
  -h, --help    Show this help message and exit

Environment variables:
  SKIP_BUILD=1  Skip vim plugin install and building tools via build-tools.sh

What it does:
  - Symlinks dotfiles from config/ to ~/.<file>
  - Backs up existing dotfiles with a .old.<timestamp> suffix
  - Copies bashrc to ~/.bashrc (not symlinked)
  - Symlinks VS Code settings
  - Symlinks the backlog plugin to ~/.claude/skills/
  - Downloads git-prompt, git-completion, Vim-Plug, fzf
  - Installs Tmux Plugin Manager (tpm)
  - Builds tools from source via build-tools.sh (ninja, bison, flex,
    ncurses, libevent, tmux, tmux-mem-cpu-load, vim)
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$DIR/config"
DOTFILES="\
  aspell.en.prepl \
  aspell.en.pws \
  claude/CLAUDE.md \
  claude/settings.json \
  gitconfig \
  gvimrc \
  shrc \
  ssh-agent.bash \
  tmux.conf \
  vimrc \
  zshrc \
  "

echo "Installing in $HOME"
echo "Changing to $DIR"
# build-tools.sh puts its build and download directories under $PWD
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

# Claude Code plugins auto-load from ~/.claude/skills/ as <name>@skills-dir
CLAUDE_SKILLS="$HOME/.claude/skills"
mkdir -p "$CLAUDE_SKILLS"
if [ -d "$CLAUDE_SKILLS/backlog" ] && ! [ -L "$CLAUDE_SKILLS/backlog" ]; then
  echo "Backing up existing '$CLAUDE_SKILLS/backlog'"
  date=$(date +"%Y%m%d%H%M%S")
  mv "$CLAUDE_SKILLS/backlog" "$CLAUDE_SKILLS/backlog.old.$date"
fi
ln -sfn "$DIR/backlog" "$CLAUDE_SKILLS/backlog"

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

# Build tools from source (ninja, bison, flex, ncurses, libevent, tmux,
# tmux-mem-cpu-load, vim) via build-tools.sh.
if [ "${SKIP_BUILD:-0}" != "1" ]; then
  bash "$DIR/build-tools.sh"
fi
