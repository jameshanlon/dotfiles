# Dotfiles

## Starting from scratch

Install programs and generate SSH key:
```
$ sudo apt-get install git vim vim-gtk
$ ssh-keygen -t rsa -b 4096 -C "email@domain.com"
```
Clone and install dotfiles:
```
$ git clone git@github.com:jameshanlon/dotfiles.git
$ cd dotfiles
$ bash setup.sh
```
Install Vim plugins:
```
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ vim -c ":PlugInstall"
```
Install ssh-ident (https://github.com/ccontavalli/ssh-ident):
```
$ mkdir -p ~/bin; wget -O ~/bin/ssh goo.gl/MoJuKB; chmod 0755 ~/bin/ssh
$ echo 'export PATH=~/bin:$PATH' >> ~/.bashrc
```

## Other stuff

Mount a VirtualBox shared folder:
```
$ mkdir ~/VBoxShare
$ sudo mount -t vboxsf -o rw,uid=1000,gid=1000 VBoxShare ~/VBoxShare
```
```
