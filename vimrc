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
map <C-b> :NERDTreeFromBookmark
map <C-f> :NERDTreeFind<cr>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Airline
let g:airline_powerline_fonts = 1

" Ctags
" Look up recursively for a tag file
set tags=./tags;/
" Ctrl+\ open def in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Ctrl+] open def in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '$HOME/.ycm.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_vim_data = ['&filetype']
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_enable_diagnostic_signs = 0

" Colours
set t_Co=256     " Enable 256-colour mode

" Misc options
syntax on
set encoding=utf-8
set backspace=indent,eol,start
set textwidth=79
set laststatus=2 " Always show the status line
set wildmenu     " Enchanced command-line completion
set ruler        " Display position in rhs of status bar
set showmode
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

" Tab mappings
" See `:h hidden` for more details
set hidden
" To open a new empty buffer
nmap <leader>T :enew<cr>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
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
  au! BufRead,BufNewFile *.xc     set filetype=xc
augroup END
