#!/bin/bash
set -e

DIR=~/dotfiles
DOTFILES="\
  vimrc \
  gvimrc \
  ctags \
  ycm.py"

echo "Installing in $HOME"
echo "Changing to $DIR"
cd $DIR

for f in $DOTFILES; do
  # Make a copy of a dotfile, otherwise delete it
  if ! [ -h "$HOME/.$f" ]; then
    echo "Backing up existing dotfile '~/.$f'"
    date=$(date +"%Y%m%d%H%M%S")
    mv $HOME/.$f $HOME/.$f.old.$date
  else
    rm $HOME/.$f
  fi
  # Make symlink
  echo "Creating symlink to '$f' in ~/"
  ln -s $DIR/$f $HOME/.$f
done

