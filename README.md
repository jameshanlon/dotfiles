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

## Git

Setup git:
```
git config --global user.name "James Hanlon"
git config --global user.email "mail@jameswhanlon.com"
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

## Inconsolata

Install Inconsolata font from [Google Fonts](https://fonts.google.com/specimen/Inconsolata):
```
mkdir ~/.fonts
# Move .ttf file there
```
