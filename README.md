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

Install the [prerequisites](#prerequisites), then clone and install dotfiles
and standard setup:
```
$ git clone git@github.com:jameshanlon/dotfiles.git
$ cd dotfiles
$ make
```

Installing the configs and building tools from source are separate steps:

| Command | Does |
|---------|------|
| `make` | `install` and `deps`, then installs vim plugins |
| `make install` | Symlinks configs into `~/`, no network access |
| `make deps` | Fetches git-prompt, git-completion, Vim-Plug, fzf and tpm |
| `make build` | Builds tmux, vim and tmux-mem-cpu-load into `$PREFIX` |
| `make test` | Runs `install` and `deps` against a temporary `$HOME` |
| `make clean` | Removes build trees; `distclean` also drops downloads |

`make help` lists every target.

Every step targets the file it produces, so repeating it does nothing and
deleting that file is what redoes it: `rm ~/.git-prompt.sh && make deps`
refetches the prompt, and `rm ~/.local/bin/vim && make vim` rebuilds vim.
Individual tools can be built on their own, e.g. `make vim`.

`make build` builds at `nproc` width unless given an explicit `-j`.

`PREFIX` defaults to `~/.local`:
```
$ make build PREFIX=/opt/tools
```

Extra configure flags can be passed through, which is how to link against
libraries built by hand:
```
$ make vim VIM_CONFIGURE_FLAGS='--with-tlib=ncursesw LIBS=-ltinfo'
```

## Prerequisites

`make install` and `make deps` need only `git`, `curl` and `make`.

`vim-plugins` (part of the default target) builds YouCompleteMe, and
`make build` compiles tmux, vim and tmux-mem-cpu-load. Both need:

- `cmake`, a C and C++ compiler (e.g. `gcc`, `g++`)
- `pkg-config`, and the `libevent` and `ncurses` development headers
- `bison` and `flex`
- `python3-dev`, for vim's Python 3 support

On Ubuntu/Debian:
```
$ sudo apt-get install build-essential cmake pkg-config python3-dev \
    libevent-dev libncurses-dev bison flex
```

On OSX:
```
$ brew install cmake pkg-config libevent ncurses bison flex
```

The fuller package lists below include these. Where a distro has no suitable
libevent or ncurses, see
[notes/building-libraries.md](notes/building-libraries.md) for building them
from source.

## What it does

`make install`:

- Symlinks dotfiles into `~/` (backing up any existing files)
- Copies `config/bashrc` to `~/.bashrc`, saving any existing one as
  `~/.bashrc-original`
- Symlinks VS Code settings into the platform's user settings directory

`make deps`:

- Downloads git-prompt and git-completion scripts
- Installs [Vim-Plug](https://github.com/junegunn/vim-plug) (`make` then runs
  `:PlugInstall`)
- Clones and installs [fzf](https://github.com/junegunn/fzf)
- Clones [tmux plugin manager (tpm)](https://github.com/tmux-plugins/tpm)

`make build`:

- Builds tmux
- Builds vim from source with Python 3 support
- Builds [tmux-mem-cpu-load](https://github.com/thewtex/tmux-mem-cpu-load)

## Files managed

All config files live in `config/` and are symlinked into `~/` by `make install`.

| File | Description |
|------|-------------|
| `config/aspell.en.prepl` | Aspell personal replacements |
| `config/aspell.en.pws` | Aspell personal word list |
| `config/bashrc` | Bash config (copied, not symlinked) |
| `config/claude/CLAUDE.md` | Claude Code global rules |
| `config/claude/settings.json` | Claude Code settings |
| `config/gitconfig` | Git configuration |
| `config/gvimrc` | GVim configuration |
| `config/shrc` | Aliases and environment shared by bash and zsh |
| `config/ssh-agent.bash` | Auto-loading SSH agent script |
| `config/tmux.conf` | Tmux configuration |
| `config/vimrc` | Vim configuration |
| `config/vscode/settings.json` | VS Code settings |
| `config/zshrc` | Zsh/oh-my-zsh configuration |

## Post-install steps

- **Tmux plugins**: Open tmux and press `prefix + I` (Ctrl-a + I) to install
  plugins via tpm.

## Ubuntu/Debian

Useful packages:
```
$ sudo apt-get update
$ sudo apt-get install \
    git vim cmake clang-21 python3-dev fd-find ripgrep build-essential m4 \
    gcc g++ clangd clang-format ninja-build python3-venv python3-pip tree \
    libssl-dev libevent-dev libncurses-dev pkg-config bison flex
```

## OSX

Install Homebrew and useful packages:
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew install wget fd ripgrep eza ncdu cmake vim tmux htop freerdp clang-format ninja fzf ghostty libevent ncurses pkg-config bison flex
```

Setup oh-my-zsh (https://ohmyz.sh/#install):
```
$ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

## Tools 

- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
