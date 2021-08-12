call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'terryma/vim-multiple-cursors'
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
set backupdir-=.
set backupdir^=~/tmp " Redirect backups

" Tabs
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
" Opening tabs
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>
" Switching
nnoremap H gT
nnoremap L gt

" Macros
:nnoremap <Space> @q

" Indentation
set noautoindent
"set autoindent
"set smartindent

" Search
set hlsearch  " Highlight search phrases
set incsearch " Highlight as you type
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
set t_Co=256 " Enable 256-colour mode
" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif
colorscheme delek

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

" Use sensible search highlight colours.
hi Search cterm=NONE ctermfg=grey ctermbg=blue

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Change directory to that of current file.
command! RebaseCwd :cd %:p:h

" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//

" Convert all tab characters to two spaces
command! Untab :%s/\t/  /g

" Some RCS helpers.
command! Checkout :!xpInfraRcs co %
command! Checkin  :!xpInfraRcs ci -m . %

" In Makefiles, don't expand tabs to spaces
autocmd FileType make set noexpandtab

" fzf
nmap <C-p> :Files<CR>
nmap <C-o> :Buffers<CR>

" Nerdtree
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-f> :NERDTreeFind<CR>

" Buffers
"set hidden
"nmap <C-b>  :enew<CR>           " New buffer
"nmap <C-b>d :bp <BAR> bd #<CR>  " Close current buffer and move to previous one
"nmap <C-s>  :bnext<CR>          " Next buffer
"nmap <C-a>  :bprevious<CR>      " Previous buffer
"nmap <C-d>  <C-6><CR>           " Go to last used buffer

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

"augroup filetype
"  au! BufRead,BufNewFile *.rst set filetype=rest
"augroup END

"augroup filetype
"  au! BufRead,BufNewFile *.sire set filetype=sire
"augroup END
