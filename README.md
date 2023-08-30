# Dotfiles

## Starting from scratch

Install programs and generate SSH key (Ubuntu 22.04):
```
$ sudo apt-get install git vim cmake clang-14 python3-dev
$ ssh-keygen -t rsa -b 4096 -C "email@domain.com"
```

Clone and install dotfiles:
```
$ git clone git@github.com:jameshanlon/dotfiles.git
$ cd dotfiles
$ bash setup.sh
```
Remember to:

- Update the email address in `.gitconfig` if necessary.
- Copy the `bashrc` or parts of it.

## OSX

Install Homebrew and useful packages:
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew install wget fd ripgrep ncdu
```

iTerm2:
Settings > Profiles > Keys: Left option key: Meta (for Bash).

## Git

Setup git:
```
$ git config --global user.name "James Hanlon"
$ git config --global user.email "mail@jameswhanlon.com"
```

## Oh-my-ZSH

Setup oh-my-zsh (https://ohmyz.sh/#install):
```
$ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

## Fd

Install [fd](https://github.com/sharkdp/fd), eg:
```
$ sudo apt-get install fd-find
```
Or from a [binary release](https://github.com/sharkdp/fd/releases).

## Ripgrep

Install [ripgrep](https://github.com/BurntSushi/ripgrep), eg:
```
$ sudo apt-get install ripgrep
```
Or from a [binary release](https://github.com/BurntSushi/ripgrep/releases).

## Tmux

Handy program for system load:
https://github.com/thewtex/tmux-mem-cpu-load

OSX:
```
$ brew install tmux-mem-cpu-load
```

Build from source:
```
$ git clone https://github.com/thewtex/tmux-mem-cpu-load.git
$ cd tmux-mem-cpu-load; mkdir build; cd build; cmake ..; make
```

Install plugins (in a session):
```
prefix + I
```

## Ctags

```
$ sudo apt-get install universal-ctags
```

## YouCompleteMe

http://ycm-core.github.io/YouCompleteMe/

Installed as a plugin with a post-build hook, but to run the build:
```
$ cd ~/.vim/plugged/YouCompleteMe
$ python3 install.py --all
```
For C/C++, add ``-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`` when configuring.

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
