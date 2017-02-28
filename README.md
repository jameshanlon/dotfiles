# Dotfiles

## Setup

Starting from scratch:
```
$ sudo apt-get install git vim vim-gtk
$ ssh-keygen -t rsa -b 4096 -C "email..."
$ cd dotfiles
$ bash setup.sh
```

Mount a VirtualBox shared folder:
```
$ mkdir ~/VBoxShare
$ sudo mount -t vboxsf -o rw,uid=1000,gid=1000 VBoxShare ~/VBoxShare
```

## Vim keys

CtrlP

`Ctrl+p` search, then:
- `Ctrl+f` Switch mode
- `Ctrl+r` Regex mode
- `Ctrl+v` Open in vertical split

Buffers

`Ctrl+b`    New buffer
`Ctrl+b`d   Delete buffer
`Ctrl+a`    Previous buffer
`Ctrl+s`    Next buffer
`Ctrl+d`    Last recently used buffer
`:ls`       List open buffers

NERDTree

`Ctrl+n`    Toggle
`Ctrl+f`    Find

Ctags

`Ctrl+[`    Follow tag
`Ctrl+t`    Back

Commands

`:DeleteTrailingWhitespace`
`:Untab`
