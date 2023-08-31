#!/bin/bash
set -e

DIR=$HOME/dotfiles
DOTFILES="\
  aspell.en.prepl \
  aspell.en.pws \
  gitconfig \
  gvimrc \
  tmux.conf \
  vimrc \
  zshrc \
  "

if ! [ $PWD = $HOME/dotfiles ]; then
  echo "Expecting doftiles in $HOME"
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
  if [ -f $p ] && ! [ -L $p ]; then
    echo "Backing up existing dotfile '~/.$f'"
    date=$(date +"%Y%m%d%H%M%S")
    mv $p $p.old.$date
  else
    rm -f $p
  fi
  # Make symlink
  echo "Creating symlink to '.$f' in ~/"
  ln -s $DIR/$f $HOME/.$f
done

if test -f "~/.bashrc"; then
  cp ~/.bashrc ~/.bashrc-original
  cp bashrc ~/.bashrc
fi

# Git prompt
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
mv git-prompt.sh ~/.git-prompt.sh

# Git completion
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
mv git-completion.bash ~/.git-completion.bash

# Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c ":PlugInstall"

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## Install ssh-ident (https://github.com/ccontavalli/ssh-ident):
#mkdir -p ~/bin; wget -O ~/bin/ssh goo.gl/MoJuKB; chmod 0755 ~/bin/ssh
#echo 'export PATH=~/bin:$PATH' >> ~/.bashrc
