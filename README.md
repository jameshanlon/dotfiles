Starting from scratch:

cd dotfiles
bash setup.sh

Copy bashrc to .bashrc or include in existing bashrc.

wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
mv git-prompt.sh .gitprompt.sh

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

cd ~/.vim/bundle/powerline-fonts
./install.sh
