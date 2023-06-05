# Tmux keys

## Keys

`Ctrl+a` then...

Panes

- `z` Toggle zoom current pane.
- `{` Move pane left.
- `}` Move pane right.
- `>` Pane options menu.
- `[` Copy mode

Windows

- `<` Window options menu.

Config

- `r` reload configuration.

## Commands

- `:resize-pane -R 4` Resize pane four to the right.
- `:resize-pane -L 4` Resize pane four to the left.
- `:resize-pane -D 4` Resize pane four up.
- `:resize-pane -U 4` Resize pane four down.
- `:swap-windows -s 0 -s 3` Swap windows 0 and 3.
- `:select-layout even-vertical` Even vertical splits.
- `:select-layout even-horizontal` Even horizontal splits.

## Other

- `reset` to fix terminal UI issues (eg not displaying typed command).

## References

https://tmuxcheatsheet.com/
https://github.com/thewtex/tmux-mem-cpu-load
