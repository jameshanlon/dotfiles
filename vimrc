call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'bling/vim-airline'
Plug 'Lokaltog/powerline-fonts'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'nachumk/systemverilog.vim'
Plug 'vim-scripts/rcs.vim'
call plug#end()

" Ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_by_filename = 1

" Nerdtree
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-f> :NERDTreeFind<CR>

" Buffers
set hidden
nmap <C-b>  :enew<CR>           " New buffer
nmap <C-b>d :bp <BAR> bd #<CR>  " Close current buffer and move to previous one
nmap <C-s>  :bnext<CR>          " Next buffer
nmap <C-a>  :bprevious<CR>      " Previous buffer
nmap <C-d>  <C-6><CR>           " Go to last used buffer

" Buffergator
let g:buffergator_viewport_split_policy='n' " Open in current viewport
nmap <C-o> :BuffergatorOpen<CR>

" Airline
let g:airline_powerline_fonts = 1

" Ctags
set tags=./tags;/                                           " Look up recursively for a tag file
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " Ctrl+\ open def in new tab
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>      " Ctrl+] open def in a vertical split

" Misc options
syntax on
set encoding=utf-8
set backspace=indent,eol,start
set textwidth=79
set laststatus=2 " Always show the status line
set wildmenu     " Enchanced command-line completion
set ruler        " Display position
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
" Colours
set t_Co=256     " Enable 256-colour mode

" Always search forward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Reselect visual block after indent.
vnoremap < <gv
vnoremap > >gv

" Highlight trailing whitespace
hi Search cterm=NONE ctermfg=grey ctermbg=blue
hi SpellBad ctermfg=None ctermbg=DarkRed
highlight LongLine ctermbg=red guibg=red
highlight WhitespaceEOL ctermbg=red guibg=red
au BufRead,BufNewFile * syntax match LongLine /\%>80v.\+/
au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
au InsertLeave * syntax match WhitespaceEOL /\s\+$/

" Highlight lines <80 characters
"let &colorcolumn=join(range(81,999),",")
"highlight ColorColumn ctermbg=230 guibg=#DDDDDD

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
