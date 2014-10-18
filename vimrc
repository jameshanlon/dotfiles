"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " be iMproved, required
filetype off     " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/vimshell.vim'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/powerline-fonts'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()         " required
filetype plugin indent on " required
"filetype plugin on " Or, ignore plugin indent changes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Airline
let g:airline_powerline_fonts = 1

" Misc options
syntax on
set t_Co=256     " Enable 256-colour mode
set backspace=indent,eol,start
set wildmenu     " Enchanced command-line completion
set laststatus=2 " Always show the status line
set ruler        " Display position in rhs of status bar
set showmode
set encoding=utf8
set textwidth=79
set showmatch    " Show matching parentheses

" Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Indentation
set autoindent
set smartindent

" Search
set hlsearch     " Highlight search phrases
set incsearch    " Highlight as you type
set noswapfile

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Highlight lines <80 characters
set colorcolumn=81

" Spell check with tex files
let g:tex_flavor = "latex"
let g:tex_comment_nospell= 1

" Tab mappings
map Oc :tabnext<CR>
map Od :tabprevious<CR>
map ^[O5C :tabnext<CR>
map ^[O5D :tabprevious<CR>
map ^[[1;5C :tabnext<CR>
map ^[[1;5D :tabprevious<CR>
map ^[[D :tabprevious<CR>
map ^[[C :tabnext<CR>

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//

" Convert all tab characters to two spaces
command! Untab :%s/\t/  /g

" In Makefiles, don't expand tabs to spaces
autocmd FileType make set noexpandtab

" Syntax files
augroup filetype
  au! BufRead,BufNewFile *Makefile* set filetype=make
augroup END

augroup filetype
  au! BufRead,BufNewFile *.ll set filetype=llvm
augroup END

augroup filetype
  au! BufRead,BufNewFile *.td set filetype=tablegen
augroup END

augroup filetype
  au! BufRead,BufNewFile *.rst set filetype=rest
augroup END
