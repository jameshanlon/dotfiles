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
$ sudo apt-get install git vim cmake clang-14 python3-dev fd-find ripgrep g++ clangd ninja-build python3-venv python3-pip tree exa bat
```

## OSX

Install Homebrew and useful packages:
```
# Setup Homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install packages
$ brew install wget fd ripgrep eza ncdu cmake vim tmux htop freerdp clang-format ninja fzf ghosttty
# Setup oh-my-zsh (https://ohmyz.sh/#install)
$ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

## Tools 

| Tool | Description |
| ---- | ----------- |
| [fd](https://github.com/sharkdp/fd) | [binary release](https://github.com/sharkdp/fd/releases) |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | + [binary release](https://github.com/BurntSushi/ripgrep/releases) |
| [eza](https://github.com/eza-community/eza) | |
| [bat](https://github.com/sharkdp/bat) | [binary release](https://github.com/sharkdp/bat/releases) |
| [delta](https://github.com/dandavison/delta) | [binary release](https://github.com/dandavison/delta/releases) |

