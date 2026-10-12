# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal dotfiles repository for James Hanlon. Contains shell configs, editor configs, terminal multiplexer config, and a `Makefile` that symlinks dotfiles into `$HOME` and builds terminal tools from source.

## Installation

Run from `$HOME/dotfiles/`:
```bash
make
```

`make help` lists the targets. The split that matters: `install` symlinks
configs and needs no network access, `deps` fetches the things the configs
expect to find in `$HOME`, and `build` compiles tools into `$PREFIX` (default
`$HOME/.local`). The default target is `install deps vim-plugins`.

Every target is named after the file it produces — a downloaded script, a
cloned directory, a binary under `$PREFIX/bin` — so repeating it is a no-op and
deleting that file is what redoes it. There are no stamp files, and nothing is
keyed to this checkout, so `make build PREFIX=...` is not confused by an
earlier build into a different prefix.

`build` links against the distro's libevent and ncurses rather than building
them. For machines whose packages are too old or absent,
`notes/building-libraries.md` covers building those by hand, and
`TMUX_CONFIGURE_FLAGS`/`VIM_CONFIGURE_FLAGS` pass the resulting flags through.

## Testing

```bash
bash test-setup.sh
```

Also available as `make test`. Runs `make install deps` twice against a
temporary `$HOME` to check the expected symlinks and downloads appear and that
a second run is idempotent, then checks that a pre-existing regular file is
backed up rather than clobbered. `vim-plugins` and `build` are left out: they
need vim and a toolchain.

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
- **Makefile** — Installs the configs and builds the terminal tools. The `DOTFILES` variable is the list of managed files; `make print-DOTFILES` reports it, which is how `test-setup.sh` avoids restating it.

## Architecture

Configs live under `config/` and are symlinked with a leading dot, e.g.
`config/vimrc` → `~/.vimrc`. Paths with a directory component keep their
structure, so `config/claude/settings.json` → `~/.claude/settings.json`. The
list of managed files is the `DOTFILES` variable in the `Makefile`; VS Code and
`bashrc` are handled separately because their destinations do not follow that
pattern.

The `notes/` directory contains standalone reference markdown files (not
installed, just for reference).

## Platform Notes

- The Ubuntu/Debian and Homebrew package lists live in `README.md`; keep them
  there rather than duplicating them here.
- macOS uses oh-my-zsh; see README for the install command.
- Of the modern CLI tools in those lists, only `fzf` is wired into the configs
  (zsh, bash, tmux and vim). The rest — `bat`, `eza`, `fd`, `ripgrep` — are
  installed for interactive use and are not referenced by any config.
