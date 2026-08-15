# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal dotfiles repository for James Hanlon. Contains shell configs, editor configs, terminal multiplexer config, and a setup script that symlinks dotfiles into `$HOME`.

## Installation

Run from `$HOME/dotfiles/`:
```bash
bash setup.sh
```

`setup.sh` symlinks each config into `$HOME`, backing up any existing regular
file with a timestamp suffix (`.old.<timestamp>`). It also downloads
git-prompt, git-completion, Vim-Plug and fzf, clones the Tmux Plugin Manager
(tpm), and runs `build-tools.sh`.

Set `SKIP_BUILD=1` to skip `:PlugInstall` and `build-tools.sh`, which is how
`test-setup.sh` exercises the script.

`build-tools.sh` builds ninja, bison, flex, ncurses, libevent, tmux,
tmux-mem-cpu-load and vim from source, installing into `$PREFIX` (default
`$HOME/.local`).

## Testing

```bash
bash test-setup.sh
```

Runs `setup.sh` twice against a temporary `$HOME` to check the expected
symlinks and downloads appear and that a second run is idempotent. It runs with
`SKIP_BUILD=1`, so the checks for build outputs (`.tmux-mem-cpu-load`,
`vim-src`) fail by design.

## Key Files

- **config/zshrc** — Primary shell config (Zsh with oh-my-zsh). Sets `PATH`, the theme and fzf integration.
- **config/bashrc** — Bash equivalent, plus the git-aware prompt and history settings. Copied to `~/.bashrc` rather than symlinked; any existing file is saved as `~/.bashrc-original`.
- **config/shrc** — Aliases and environment shared by both shells, sourced from `zshrc` and `bashrc`.
- **config/vimrc** — Vim config using Vim-Plug for plugins. LSP support via YouCompleteMe + clangd, git via fugitive, fuzzy find via fzf.vim.
- **config/tmux.conf** — Tmux config with tpm plugins and tmux-mem-cpu-load in the status bar.
- **config/gitconfig** — Git user identity, colours, and merge/diff settings.
- **config/claude/settings.json** — Claude Code settings (symlinked to `~/.claude/settings.json`).
- **config/claude/CLAUDE.md** — Global Claude Code rules applied across all projects (symlinked to `~/.claude/CLAUDE.md`).
- **config/vscode/settings.json** — VS Code settings, symlinked to the platform-specific user settings directory.
- **backlog/** — Claude Code plugin for a per-repo task backlog. Symlinked to `~/.claude/skills/backlog`, from where it auto-loads as `backlog@skills-dir` in every session.

## Architecture

Configs live under `config/` and are symlinked with a leading dot, e.g.
`config/vimrc` → `~/.vimrc`. Paths with a directory component keep their
structure, so `config/claude/settings.json` → `~/.claude/settings.json`. The
list of managed files is the `DOTFILES` variable in `setup.sh`; VS Code and
`bashrc` are handled separately because their destinations do not follow that
pattern.

`backlog/` is a Claude Code plugin rather than a config file, so it is symlinked
as a whole directory into `~/.claude/skills/`, which is where Claude Code
auto-loads plugins from.

The `notes/` directory contains standalone reference markdown files (not
installed, just for reference).

## Platform Notes

- **Ubuntu/Debian packages**: `git vim cmake clang-14 python3-dev fd-find ripgrep g++ clangd clang-format ninja-build python3-venv python3-pip tree bat`
- **macOS (Homebrew)**: `wget fd ripgrep eza ncdu cmake vim tmux htop freerdp clang-format ninja fzf ghosttty`
- macOS uses oh-my-zsh; see README for install command.
- Modern CLI tools referenced throughout configs: `bat` (cat replacement), `delta` (git diff pager), `eza` (ls replacement), `fd` (find replacement), `ripgrep` (grep replacement), `fzf` (fuzzy finder).
