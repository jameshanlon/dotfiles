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
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/powerline-fonts'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'kien/ctrlp.vim'

call vundle#end()         " required
filetype plugin indent on " required
"filetype plugin on " Or, ignore plugin indent changes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
map <C-b> :NERDTreeFromBookmark
map <C-f> :NERDTreeFind<cr>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Airline
let g:airline_powerline_fonts = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 0
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Ctags
" Look up recursively for a tag file
set tags=./tags;/
" Ctrl+\ open def in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Ctrl+] open def in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Misc options
colorscheme default
syntax on
set encoding=utf-8
set backspace=indent,eol,start
set textwidth=79
set laststatus=2 " Always show the status line
set wildmenu     " Enchanced command-line completion
set ruler        " Display position in rhs of status bar
set showmode
set showmatch    " Show matching parentheses
set pastetoggle=<F2>
set nowrap

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
" Always search forward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Colours
set t_Co=256     " Enable 256-colour mode

" Highlight trailing whitespace
hi Search cterm=NONE ctermfg=grey ctermbg=blue
hi SpellBad ctermfg=None ctermbg=DarkRed
highlight LongLine ctermbg=red guibg=red
highlight WhitespaceEOL ctermbg=red guibg=red
au BufRead,BufNewFile * syntax match LongLine /\%>80v.\+/
au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
au InsertLeave * syntax match WhitespaceEOL /\s\+$/

" Highlight lines <80 characters
" set colorcolumn=81

" Spell check with tex files
let g:tex_flavor = "latex"
let g:tex_comment_nospell= 1

" Buffers
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden
" To open a new empty buffer
nmap <leader>T :enew<cr>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Close the current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>

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

augroup filetype
  au! BufRead,BufNewFile *.xc set filetype=xc
augroup END

augroup filetype
  au! BufRead,BufNewFile *.sire set filetype=sire
augroup END
