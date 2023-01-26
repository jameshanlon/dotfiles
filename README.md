# Dotfiles

## Starting from scratch

Install programs and generate SSH key:
```
$ sudo apt-get install git vim vim-gtk
$ ssh-keygen -t rsa -b 4096 -C "email@domain.com"
```

Clone and install dotfiles:
```
$ git clone git@github.com:jameshanlon/dotfiles.git
$ cd dotfiles
$ bash setup.sh
```

## OSX

Install Homebrew and packages:
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew install wget
$ brew install fd
```

## Git

Setup git:
```
git config --global user.name "James Hanlon"
git config --global user.email "mail@jameswhanlon.com"
```

## Oh-my-ZSH

Setup oh-my-zsh (https://ohmyz.sh/#install):
```
$ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

## VirtualBox

Mount a VirtualBox shared folder:
```
$ mkdir ~/VBoxShare
$ sudo mount -t vboxsf -o rw,uid=1000,gid=1000 VBoxShare ~/VBoxShare
```

## Fd

Install [fd](https://github.com/sharkdp/fd), eg:
```
sudo apt-get install fd-find
```
or from a [binary release](https://github.com/sharkdp/fd/releases).

## Pet

Install [pet](https://github.com/knqyf263/pet)
from a [binary release](https://github.com/knqyf263/pet/releases).

Key bindings that can be added to bashrc:
```
# Pet
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}
function pet-select() {
  BUFFER=$(pet search --query "$READLINE_LINE")
  READLINE_LINE=$BUFFER
  READLINE_POINT=${#BUFFER}
}
bind -x '"\C-p": pet-select'
```

## Inconsolata

Install Inconsolata font from [Google Fonts](https://fonts.google.com/specimen/Inconsolata):
```
mkdir ~/.fonts
# Move .ttf file there
```
