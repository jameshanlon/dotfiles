# Dotfiles

## Setup

Starting from scratch:
```
$ sudo apt-get install git vim vim-gtk
$ ssh-keygen -t rsa -b 4096 -C "email..."
$ cd dotfiles
$ bash setup.sh
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ vim -c ":PlugInstall"
```

Mount a VirtualBox shared folder:
```
$ mkdir ~/VBoxShare
$ sudo mount -t vboxsf -o rw,uid=1000,gid=1000 VBoxShare ~/VBoxShare
```

Run ssh-agent:
```
$ eval `ssh-agent`
$ ssh-add
...
```
