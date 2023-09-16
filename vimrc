" #######################
" ### General options ###
" #######################

set nocompatible
set encoding=utf-8
set fileencodings=utf-8
scriptencoding utf-8
set backspace=indent,eol,start
set textwidth=79
set laststatus=2  " Always show the status line
set wildmenu      " Enchanced command-line completion
set wildmode=list:longest " Path/file expansion in colon-mode
set wildchar=<TAB>
set ruler         " Display position
set showmode      " Show current mode
set showmatch     " Show matching brackets
set showcmd       " Show command
set nowrap
set noerrorbells
set modeline
set nojoinspaces  " No double spaces after punctuation
set nostartofline " Do not jump to first character with page commands.
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noautoindent
set hlsearch  " Highlight search phrases
set incsearch " Highlight as you type
set splitbelow
set splitright
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" ###############
" ### Colours ###
" ###############

" Enable 256-colour mode
set t_Co=256

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

colorscheme delek

" #################
" ### Scrolling ###
" #################

if !&scrolloff
  set scrolloff=1
endif

if !&sidescrolloff
  set sidescrolloff=5
endif

set display+=lastline

" Set command history length.
if &history < 1000
  set history=1000
endif

" #########################
" ### Visual selections ###
" #########################

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" ##################
" ### Highlights ###
" ##################

" Use sensible search highlight colours
hi Search cterm=NONE ctermfg=grey ctermbg=blue

" Show trailing spaces in red
autocmd VimEnter * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd WinEnter * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufRead  * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax   * syntax match ExtraWhitespace excludenl /\s\+$/ display containedin=ALL

" Tell Vim which characters to show for expanded TABs, trailing whitespace and end-of-lines.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" ##############
" ### Syntax ###
" ##############

if has('autocmd')
  filetype plugin on
  filetype indent on
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Makefiles
augroup filetype
  au! BufRead,BufNewFile *Makefile* set filetype=make
augroup END

" LLVM
augroup filetype
  au! BufRead,BufNewFile *.ll set filetype=llvm
augroup END

" Tablegen
augroup filetype
  au! BufRead,BufNewFile *.td set filetype=tablegen
augroup END

" In Makefiles, don't expand tabs to spaces
autocmd FileType make set noexpandtab

" ############
" ### Tabs ###
" ############

" Opening tabs
nmap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" Switching between tabs
nmap H  :tabprev<CR>
nmap L  :tabnext<CR>
nmap t1 :tabnext 1<CR>
nmap t2 :tabnext 2<CR>
nmap t3 :tabnext 3<CR>
nmap t4 :tabnext 4<CR>
nmap t5 :tabnext 5<CR>
nmap t6 :tabnext 6<CR>
nmap t7 :tabnext 7<CR>
nmap t8 :tabnext 8<CR>
nmap t9 :tabnext 9<CR>

" ##############
" ### Macros ###
" ##############

nmap <Space> @q

" ##############
" ### Search ###
" ##############

" Always search forward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nmap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" ####################
" ### clang-format ###
" ####################

map <C-K> :py3f /home/jamie/llvm-project-llvmorg-16.0.0/install/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:py3f /home/jamie/llvm-project-llvmorg-16.0.0/install/share/clang/clang-format.py<cr>

" ############
" ### Plug ###
" ############

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'preservim/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-surround'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py --clangd-completer' }
call plug#end()

" ################
" ### Commands ###
" ################

" Change directory to that of current file.
command! RebaseCwd :cd %:p:h

" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//

" Convert all tab characters to two spaces
command! Untab :%s/\t/  /g

" ###########
" ### fzf ###
" ###########

nmap <C-p> :Files<CR>
nmap <C-o> :Buffers<CR>

" ################
" ### Nerdtree ###
" ################

nmap <C-n> :NERDTreeToggle<CR>
nmap <C-f> :NERDTreeFind<CR>

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ##########################
" ### Git / Vim Fugitive ###
" ##########################

nmap <silent> <leader>gl :Commits<CR>
nmap <silent> <leader>ga :BCommits<CR>
nmap <silent> <leader>gs :Git<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>gb :Git blame<CR>
nmap <silent> <leader>gL :Glog<CR>

" #####################
" ### YouCompleteMe ###
" #####################

nmap yfw <Plug>(YCMFindSymbolInWorkspace)
nmap yfd <Plug>(YCMFindSymbolInDocument)
nmap ;d          :rightbelow vertical YcmCompleter GoToDefinition<CR>
nmap ;r          :YcmCompleter GoToReferences<CR>
nmap <leader>yfc :YcmForceCompileAndDiagnostics<CR>
nmap <leader>gic :rightbelow vertical YcmCompleter GoToInclude<CR>
nmap <leader>gdc :rightbelow vertical YcmCompleter GoToDeclaration<CR>
nmap <leader>gdf :rightbelow vertical YcmCompleter GoToDefinition<CR>
nmap <leader>gip :rightbelow vertical YcmCompleter GoToImprecise<CR>
nmap <leader>grr :rightbelow vertical YcmCompleter RefactorRename
nmap <leader>grf :YcmCompleter GoToReferences<CR>
nmap <leader>f   :YcmCompleter FixIt<CR>

" ##################
" ### Easy align ###
" ##################

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
