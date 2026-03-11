# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal dotfiles repository for James Hanlon. Contains shell configs, editor configs, terminal multiplexer config, and a setup script that symlinks dotfiles into `$HOME`.

## Installation

Run from `$HOME/dotfiles/`:
```bash
bash setup.sh
```

The script symlinks each dotfile from `~/dotfiles/<file>` to `~/.<file>`. Existing files are backed up with a timestamp suffix (`.old.<timestamp>`). It also downloads and installs: git-prompt, git-completion, Vim-Plug, fzf, Tmux Plugin Manager (tpm), tmux-mem-cpu-load (built with cmake), and Vim from source.

## Key Files

- **zshrc** — Primary shell config (Zsh with oh-my-zsh). Defines aliases, PATH, fzf integration, and shell prompt.
- **bashrc** — Bash equivalent, not symlinked by `setup.sh` (copied manually if `~/.bashrc` exists).
- **vimrc** — Vim config using Vim-Plug for plugins. LSP support via YouCompleteMe + clangd, git via fugitive, fuzzy find via fzf.vim.
- **tmux.conf** — Tmux config with tpm plugins and tmux-mem-cpu-load in the status bar.
- **gitconfig** — Git user identity, delta as pager, and common aliases.
- **claude/settings.json** — Claude Code IDE settings (symlinked to `~/.claude/settings.json`).

## Architecture

All dotfiles live at the root of the repo and are symlinked with a leading dot (e.g., `vimrc` → `~/.vimrc`). The `claude/` subdirectory is handled as `claude/settings.json` → `~/.claude/settings.json`.

The `notes/` directory contains standalone reference markdown files (not installed, just for reference).

## Platform Notes

- **Ubuntu/Debian packages**: `git vim cmake clang-14 python3-dev fd-find ripgrep g++ clangd clang-format ninja-build python3-venv python3-pip tree bat`
- **macOS (Homebrew)**: `wget fd ripgrep eza ncdu cmake vim tmux htop freerdp clang-format ninja fzf ghosttty`
- macOS uses oh-my-zsh; see README for install command.
- Modern CLI tools referenced throughout configs: `bat` (cat replacement), `delta` (git diff pager), `eza` (ls replacement), `fd` (find replacement), `ripgrep` (grep replacement), `fzf` (fuzzy finder).
