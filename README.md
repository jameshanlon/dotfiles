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

Clone and install dotfiles and standard setup:
```
$ git clone git@github.com:jameshanlon/dotfiles.git
$ cd dotfiles
$ bash setup.sh
```
Copy the `bashrc`/`zshrc` or parts of it.

## Ubuntu/Debian

Useful packages:
```
$ sudo apt-get update
$ sudo apt-get install git vim cmake clang-14 python3-dev fd-find ripgrep g++ clangd clang-format ninja-build python3-venv python3-pip tree bat
```

## OSX

Install Homebrew and useful packages:
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew install wget fd ripgrep eza ncdu cmake vim tmux htop freerdp clang-format ninja fzf ghosttty
```

Setup oh-my-zsh (https://ohmyz.sh/#install):
```
$ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

## Vim

```
git clone --depth 1 https://github.com/vim/vim.git
cd vim/src
./configure --prefix=/opt/vim --with-features=huge --enable-python3interp
make -j32
make install
```

## Tools 

- [bat](https://github.com/sharkdp/bat)
- [delta](https://github.com/dandavison/delta)
- [eza](https://github.com/eza-community/eza)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
