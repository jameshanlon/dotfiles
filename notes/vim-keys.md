# Vim keys

## General

- `:DeleteTrailingWhitespace`
- `:Untab`
- `:RebaseCwd`
- `Ctrl+p` - Search files
- `Ctrl+o` - Search buffers

## Git

- `:Commits` or `<Leader>gl`
- `:BCommits` or `<Leader>ga`
- `:Git blame` or `<Leader>gb`
- `:Gstatus` or `<Leader>gs`
- `:Glog` or `<Leader>gl`
- `:Gdiff` or `<Leader>gd`

## NERDTree

- `Ctrl+f`    Find
- `m` on a file to modify (rename, delete etc)

## YouCompleteMe

- `yfw` - Find symbol in workspace
- `yfd` - Find symbol in document
- `<leader>yfc` Force compile
- `<leader>gic` Go to include
- `<leader>gdc` Go to declaration
- `<leader>gdf` Go to definition (or `;d`)
- `<leader>gip` Go to imprecise
- `<leader>grf` Go to references (or `;r`)
- `<leader>grr` Refactor rename
- `<leader>f` Fix it

## Splits

- ``Ctrl+w _`` maximise height of current split
- ``Ctrl+w |`` maximise width of current split
- ``Ctrl+w =`` equalise size of splits
- ``Ctrl+w R`` swap top/bottom or left/right split
- ``Ctrl+w T`` move current window into a new tab

## Tabs

- `Ctrl+t` Open new tab
- `H` Select left tab
- `L` Select right tab
- `t0` Select tab 0
- `t1 Select tab 1
- Etc

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

Go to file (with cursor on valid path):
- `gt` In buffer
- `Ctrl+W`, `f` In split
- `Ctrl+W`, `gf` In tab

## Editing

- `i`/`a` insert before/after cursor
- `o`/`O` open new line below/above cursor
- `ci"`   change text in `"..."`
- `ci<`   change text in `<...>`
- `ciw`   change whole word under cursor
- `cw`    change word from cursor
- `D`     delete until end of line
- `A`     append to end of line

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

## Ctags

https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
  
- `Ctrl+[`    Follow tag
- `Ctrl+t`    Back

## Terminal

- `:vert term`
- `Ctrl+W`, `Ctrl+W` or `Ctrl+W, `p` - Move to previous pane.
- `Ctrl+W`, `N` - Normal mode
- `Ctrl+W`, " " - Paste
- `<Leader>t` - New terminal pane
- `<Leader>T` - New terminal tab

## Misc commands

- `:e **/<name>` Open file with <name> from any directory.

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
