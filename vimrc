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

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Misc options
set encoding=utf-8
set backspace=indent,eol,start
set textwidth=79
set laststatus=2  " Always show the status line
set wildmenu      " Enchanced command-line completion
set ruler         " Display position
set showmode      " Show current mode
set showmatch     " Show matching brackets
set showcmd       " Show command
set nowrap
set noerrorbells
set modeline
set nojoinspaces  " No double spaces after punctuation
set nostartofline " Do not jump to first character with page commands.
set pastetoggle=<F2>

" Tabs
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Indentation
set noautoindent
"set autoindent
"set smartindent

" Search
set hlsearch     " Highlight search phrases
set incsearch    " Highlight as you type
set noswapfile
" Always search forward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Splits
set splitbelow
set splitright

" Colours
set t_Co=256     " Enable 256-colour mode
" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Path/file expansion in colon-mode
set wildmode=list:longest
set wildchar=<TAB>

" Scrolling.
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Tell Vim which characters to show for expanded TABs, trailing whitespace,
" and end-of-lines.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Set command history length.
if &history < 1000
  set history=1000
endif

" Reselect visual block after indent.
vnoremap < <gv
vnoremap > >gv

"" Highlight trailing whitespace
"hi Search cterm=NONE ctermfg=grey ctermbg=blue
"hi SpellBad ctermfg=None ctermbg=DarkRed
"highlight LongLine ctermbg=red guibg=red
"highlight WhitespaceEOL ctermbg=red guibg=red
"au BufRead,BufNewFile * syntax match LongLine /\%>80v.\+/
"au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
"au InsertLeave * syntax match WhitespaceEOL /\s\+$/

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
  au! BufRead,BufNewFile *.sire set filetype=sire
augroup END
