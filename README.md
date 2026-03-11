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

`setup.sh` creates symlinks in `$HOME` for: shell configs (zshrc), editor
configs (vimrc, gvimrc), tmux config, gitconfig, aspell dictionaries, and
Claude/VS Code settings. It also installs git-prompt, git-completion, Vim-Plug
(and plugins), fzf, tmux plugin manager, tmux-mem-cpu-load, and builds Vim
from source with Python 3 support.

VS Code settings are symlinked to the correct OS path:
- Linux: `~/.config/Code/User/settings.json`
- macOS: `~/Library/Application Support/Code/User/settings.json`

Copy the `bashrc` or parts of it manually (not symlinked).

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

## Tools

- [bat](https://github.com/sharkdp/bat)
- [delta](https://github.com/dandavison/delta)
- [eza](https://github.com/eza-community/eza)
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
