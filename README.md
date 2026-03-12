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

## Prerequisites

`setup.sh` builds vim from source and tmux-mem-cpu-load, so the following
are needed before running it:

- `git`, `curl`, `cmake`, `make`, a C++ compiler (e.g. `g++`)

These are covered by the Ubuntu/Debian and OSX package lists below.

## What `setup.sh` does

- Symlinks dotfiles into `~/` (backing up any existing files)
- Downloads git-prompt and git-completion scripts
- Installs [Vim-Plug](https://github.com/junegunn/vim-plug) and runs `:PlugInstall`
- Clones and installs [fzf](https://github.com/junegunn/fzf)
- Clones [tmux plugin manager (tpm)](https://github.com/tmux-plugins/tpm)
- Builds [tmux-mem-cpu-load](https://github.com/thewtex/tmux-mem-cpu-load)
- Builds vim from source with Python 3 support

## Files managed

All config files live in `config/` and are symlinked into `~/` by `setup.sh`.

| File | Description |
|------|-------------|
| `config/aspell.en.prepl` | Aspell personal replacements |
| `config/aspell.en.pws` | Aspell personal word list |
| `config/bashrc` | Bash config (copied, not symlinked) |
| `config/claude/settings.json` | Claude Code settings |
| `config/gitconfig` | Git configuration |
| `config/gvimrc` | GVim configuration |
| `config/ssh-agent.bash` | Auto-loading SSH agent script |
| `config/tmux.conf` | Tmux configuration |
| `config/vimrc` | Vim configuration |
| `config/vscode/settings.json` | VS Code settings |
| `config/zshrc` | Zsh/oh-my-zsh configuration |

## Post-install steps

- **bashrc**: Must be copied manually (`cp bashrc ~/.bashrc`), it is not
  symlinked by `setup.sh`.
- **Tmux plugins**: Open tmux and press `prefix + I` (Ctrl-a + I) to install
  plugins via tpm.
- **tmux-mem-cpu-load**: The zshrc adds `~/.tmux-mem-cpu-load/build` to `PATH`.

## Ubuntu/Debian

Useful packages:
```
$ sudo apt-get update
$ sudo apt-get install git vim cmake clang-14 python3-dev fd-find ripgrep g++ clangd clang-format ninja-build python3-venv python3-pip tree
```

## OSX

Install Homebrew and useful packages:
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew install wget fd ripgrep ncdu cmake vim tmux htop freerdp clang-format ninja fzf ghosttty
```

Setup oh-my-zsh (https://ohmyz.sh/#install):
```
$ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

## Tools 

- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
