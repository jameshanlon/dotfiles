# Vim keys

- `:e **/<name>` Open file with <name> from any directory.

## NERDTree

- `Ctrl+n`    Toggle
- `Ctrl+f`    Find

## Ctags

- `Ctrl+[`    Follow tag
- `Ctrl+t`    Back

## Commands

- `:DeleteTrailingWhitespace`
- `:Untab`

## Movement

- `gg` top of file
- `G`  bottom of file
- `H`  top of screen
- `M`  middle of screen
- `L`  bottom of screen
- `f"` move to next `"`
- `z.` line to middle
- `zz` line to top
- `zb` line to bottom
- `$`  end of line
- `0`  beginning of line
- `e`  beginning of next word
- `b`  end of previous word
- `E`  beginning of next word, skip ws
- `(`/`)`  next/previous sentence
- `{`/`}`  next/previous paragraph
- `gt` goto file (curson on valid path)

## Editing

- `i`/`a` insert before/after cursor
- `o`/`O` open new line below/above cursor
- `ci"`   change text in `"..."`
- `ci<`   change text in `<...>`
- `ciw`   change whole word under cursor
- `cw`    change word from cursor
- `D`     delete until end of line
- `A`     append to end of line

## Splits

- ``Ctrl+w _`` maximise height of current split
- ``Ctrl+w |`` maximise width of current split
- ``Ctrl+w =`` equalise size of splits
- ``Ctrl+w R`` swap top/bottom or left/right split
- ``Ctrl+w T`` move current window into a new tab

## g

- `:g/pattern/d`         Delete all lines matching a pattern.
- `:g!/pattern/d`        Delete all lines not matching a pattern.
- `:g/^\s*$/d`           e.g. delete all blank lines.
- `:g/pattern/t$`        Copy all lines matching a pattern to end of the file.
- `:g/pattern/m$`        Move all lines matching a pattern to end of the file.
- `:g/pattern/normal @q` Run a macro on matching lines.
- `:g/^/m0`              Revese a file.

## s

- `:%s/pattern/replacement/g`
- `:%s//replacement/g` Replace text last searched for.

Note:
- `%` means use the whole buffer.
- `g` means substitute every match on line, not just the first.

- Replace visual selection: `s` replacement <Esc>

## Macros

- Record: `q<letter> ... <commands> ... q`
- Replay: `<repeats>@<letter>`
- `@@` plays the last used macro.

E.g.
```
qd
...
q
10@q
```

## CtrlP

`Ctrl+p` search, then:
- `Ctrl+f` Switch mode
- `Ctrl+r` Regex mode
- `Ctrl+v` Open in vertical split

## Buffers

- `Ctrl+b`    New buffer
- `Ctrl+b`d   Delete buffer
- `Ctrl+a`    Previous buffer
- `Ctrl+s`    Next buffer
- `Ctrl+d`    Last recently used buffer

## Buffergator

`Ctrl+o`, then:
- `Ctrl+V` Open buffer in vertical split
- `Ctrl+S` Open buffer in horizontal split
- `Ctrl+T` Open buffer in new tab
- `gb`     Switch between most-recently used buffers
- `cs`     Cycle between sorts
- `cs`     Cycle between displays
- `r`      Refresh
- `d`      Delete a buffer
- `q`      Quit
