# Dotfiles

## Starting from scratch

Generate SSH key:
```
$ ssh-keygen -t ed25519 -C "mail@jameswhanlon.com"
$ ssh-copy-id <host>
```
Git config:
```
$ git config --global user.name "James Hanlon"
$ git config --global user.email "mail@jameswhanlon.com"
```

Clone and install dotfiles:
```
$ git clone git@github.com:jameshanlon/dotfiles.git
$ cd dotfiles
$ bash setup.sh
```
Copy the `bashrc` or parts of it.

## Ubuntu 22.04

```
$ sudo apt-get install git vim cmake clang-14 python3-dev fd-find ripgrep g++ clangd ninja-build python3-venv python3-pip tree exa bat
```

## OSX

Install Homebrew and useful packages:
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew install wget fd ripgrep eza ncdu cmake vim tmux htop freerdp clang-format ninja fzf ghosttty
```

## Fd

Replacement for `find`.

Install [fd](https://github.com/sharkdp/fd) from a [binary release](https://github.com/sharkdp/fd/releases).

## Ripgrep

Replacement for `grep`.

Install [ripgrep](https://github.com/BurntSushi/ripgrep) from a [binary release](https://github.com/BurntSushi/ripgrep/releases).

## Eza

Replacement for `ls`.

[Github](https://github.com/eza-community/eza).

## Bat

Replacement for `cat`.

Install [bat](https://github.com/sharkdp/bat) from a [binary release](https://github.com/sharkdp/bat/releases) or via `apt install bat`.

## Delta

Improved `git diff`.

Install [delta](https://github.com/dandavison/delta) from a
[binary release](https://github.com/dandavison/delta/releases).
For Ubuntu/Debian download the `.deb` and run `dpkg -i file.deb`.

## Tmux

Handy program for system load:
https://github.com/thewtex/tmux-mem-cpu-load

## YouCompleteMe

http://ycm-core.github.io/YouCompleteMe

Installed as a plugin with a post-build hook, but to run the build:
```
$ cd ~/.vim/plugged/YouCompleteMe
$ python3 install.py --clangd-completer
```
For C/C++, add ``-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`` when configuring.

## Oh-my-ZSH

Setup oh-my-zsh (https://ohmyz.sh/#install):
```
$ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

## Inconsolata

Install Inconsolata font from [Google Fonts](https://fonts.google.com/specimen/Inconsolata):
```
mkdir ~/.fonts
# Move .ttf file there
```

## VirtualBox

Mount a VirtualBox shared folder:
```
$ mkdir ~/VBoxShare
$ sudo mount -t vboxsf -o rw,uid=1000,gid=1000 VBoxShare ~/VBoxShare
```
