"{{{ ====================== Commands ======================
command! -nargs=0 Clean   :set nonu nolist foldcolumn=0
command! -nargs=0 Unclean :set nu list foldcolumn=1
command! -nargs=0 Envim   :e ~/.config/nvim/init.vim
command! -nargs=0 Evim    :e ~/.vimrc
"}}}
"{{{ ====================== Functions ======================
"{{{ VisualSelection
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
"}}}
"{{{ SwitchSpellLang
let g:myLang = 0
let g:myLangList = ['de_de', 'pt_br', 'en']
function! SwitchSpellLang()
  "loop through languages
  let &l:spelllang = g:myLangList[g:myLang] | setlocal spell
  echomsg 'language:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction
"}}}
"}}}
"{{{ ====================== Mappings ======================
" Leader {{{
let mapleader = 'ç'
set tm=2000 " time to leader became ç
" }}}
" tabs {{{
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
" }}}
" spell checking {{{
nmap <leader>ss :setlocal spell!<cr>
nmap <leader>sc :call SwitchSpellLang()<CR>
" }}}
" Best edit {{{
vnoremap <silent> * :call VisualSelection('f')<CR> " * searches current selection foword
nmap <leader><space> :%s/\s\+$<cr>                 " remove extra white space
" }}}
" Smart way to move between windows {{{
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" }}}
" F* {{{
set pastetoggle=<F2>           " Change between insert and Paste
nnoremap <F3> :GundoToggle<CR> " toggle graphic undo tree
map <F4> :VimFilerExplorer<CR> " Toggle File Explorer
" }}}
" {{{ Plugins
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR> " Toggle Hard mode
" ultisnips {{{
let g:UltiSnipsExpandTrigger = "<c-y>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"}}}
" [NV] deoplete {{{
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#mappings#manual_complete()
inoremap <silent><expr> <S-TAB>
  \ pumvisible() ? "\<C-p>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#mappings#manual_complete()
  function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
"}}}
"}}}
" {{{ Accept habits
cnoreabbrev Q q
cnoreabbrev WQ wq
cnoreabbrev Wq q
noremap <leader>p @
" }}}
"}}}
"{{{ ===================== Plugins ==========================
call plug#begin('~/.local/share/nvim/plugged')
" [NV] Others {{{
Plug 'AndrewRadev/splitjoin.vim'              " split and join expressions
Plug 'Konfekt/FastFold'                       " speed up folds by updating
Plug 'Lokaltog/vim-easymotion'                " move following leters
Plug 'Shougo/denite.nvim'                     " search/display info (file, buf)
Plug 'Shougo/deol.nvim'                       " [NV] terminal
Plug 'Shougo/deoplete.nvim'                   " [NV] auto-completition
Plug 'Shougo/echodoc.vim'                     " Signatures in command line
" Plug 'Shougo/neocomplete.vim'                 " [V] auto-completition
Plug 'Shougo/unite.vim'                       " search/display info (file, buf)
Plug 'Shougo/vimfiler.vim'                    " tree of files
Plug 'Shougo/vimproc.vim', {'do' : 'make'}    " Interactive command execution
" Plug 'Shougo/vimshell.vim'                    " [V] shell
Plug 'SirVer/ultisnips'                       " use snippets
Plug 'dhruvasagar/vim-table-mode'             " create and edit tables
Plug 'honza/vim-snippets'                     " more snippets
Plug 'jiangmiao/auto-pairs'                   " add pairs automaticaly
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                       " fuzzy finder on vim
Plug 'justmao945/vim-clang'                   " clang completition
Plug 'kana/vim-operator-user'                 " user operators
Plug 'kana/vim-textobj-entire'                " new object
Plug 'kana/vim-textobj-function'              " new object
Plug 'kana/vim-textobj-indent'                " new object
Plug 'kana/vim-textobj-line'                  " new object
Plug 'kana/vim-textobj-user'                  " new object
Plug 'rhysd/vim-grammarous'                   " grammar checking
Plug 'scrooloose/syntastic'                   " syntax Highlight
Plug 'seagoj/last-position.vim'               " save cursor position
Plug 'sjl/gundo.vim'                          " undo tree
Plug 'tpope/vim-capslock'                     " software caps lock
Plug 'tpope/vim-commentary'                   " comment in and out
Plug 'tpope/vim-fugitive'                     " work with git
Plug 'blindFS/vim-taskwarrior'                " interface for taskwarrior
Plug 'tpope/vim-repeat'                       " extend use of .
" Plug 'tpope/vim-sleuth'                       " set indentation for files
Plug 'tpope/vim-speeddating'                  " fast way of change date
Plug 'tpope/vim-surround'                     " new object surrond
Plug 'tpope/vim-tbone'                        " commands for tmux on vim
Plug 'tpope/vim-unimpaired'                   " complementary pairs of mappings
Plug 'vim-airline/vim-airline'                " new mode line
Plug 'vim-airline/vim-airline-themes'         " themes for airline
Plug 'vim-scripts/ZoomWin'                    " make pane full screen
Plug 'vimwiki/vimwiki'                        " make files in a personal wiki
Plug 'wikitopian/hardmode'                    " make vim harder
" Plug 'wincent/terminus'                       " [V] integration with terminal
" }}}
" [NV] Nyaovim {{{
Plug 'rhysd/nyaovim-popup-tooltip'    " Image popup tooltip
Plug 'rhysd/nyaovim-markdown-preview' " preview markdown files
Plug 'rhysd/nyaovim-mini-browser'     " browser for nyaovim
" }}}
""{{{ Colors
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'sickill/vim-monokai'
Plug 'tpope/vim-vividchalk'
""}}}
"{{{ Haskell
Plug 'Twinside/vim-haskellFold'                " fold for haskell
Plug 'Twinside/vim-hoogle'                     " search on hoogle
Plug 'dag/vim2hs'                              " lots of help with haskell
Plug 'eagletmt/ghcmod-vim', {'do' : 'cabal install ghc-mode'} " type checker
Plug 'eagletmt/neco-ghc'                       " Omni completition
Plug 'mpickering/hlint-refactor-vim'           " use hlint
"}}}
" {{{ Other lenguages and file types
Plug 'LumenAstralis/lilypond-vim'             " for lilypond files
Plug 'codegram/vim-todo'                      " for todo files
Plug 'lervag/vimtex'                          " for edit latex
Plug 'rust-lang/rust.vim'                     " for rust
Plug 'PotatoesMaster/i3-vim-syntax'           " for i3 config
" }}}
call plug#end()
"}}}
"{{{ ====================== Settings ======================
set nocompatible   " be iMproved
syntax enable      " Enable syntax highlighting
syntax on
" ----------------- Sets -----------------  {{{
"{{{ indentation
set ai               " Auto indent
set si               " Smart indent
set expandtab        " Replace tabs with spaces
set shiftround       " always indent by multiple of shiftwidth
set shiftwidth=4
set softtabstop=4
"}}}
"{{{ numbers
set number            " Line number
set ruler            " Always show current position
set numberwidth=2
set number
set relativenumber " Show numbers relative to the current line
"}}}
"{{{ search
set hlsearch      " Highlight search results
set incsearch     " Makes search act like search in modern browsers
"}}}
"{{{ line and column
set cursorline         " Highlight cursor line
set colorcolumn=+1     " Highlight textwith column
if has('linebreak')
  set linebreak        " wrap long lines at characters in 'breakat'
  let &showbreak='⤷ '  " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif
"}}}
"{{{ mouse and cursor
set mouse=a                     " enable mouse
set mousemodel=popup            " right button open pupup menu
set scrolloff=10                " Keep cursor centered
set sidescrolloff=3             " scrolloff for columns
set showmatch                   " Show matching brackets when text indicator is over them
"}}}
"{{{ play nice
set backspace=indent,start,eol  " Backspace deletes like most programs in insert mode
set textwidth=77
set viminfo^=%                  " Remember info about open buffers on close
set formatoptions+=j            " remove comment leader when joining comment lines
"}}}
"{{{ files (save, read, ...)
set autoread      " Set to auto read when a file is changed from the outside
set autowrite     " Automatically :write before running commands
set backup
set writebackup
" Where save backup
set backupdir=~/Documents/vim_files/backup
set backupdir+=~/Documents/vim_files
set backupdir+=.
" Where place swap files
set directory=~/Documents/vim_files/swap
set directory+=~/Documents/vim_files
set directory+=.
" Place for undo files
if has('persistent_undo')
    set undodir=~/Documents/vim_files/undo
    set undodir=~/Documents/vim_files
    set undodir+=.
    set undofile                      " use undo files
endif
" don't create root-owned files
if exists('$SUDO_USER')
    if has('persistent_undo')
        set noundofile
    endif
    set noswapfile
    set nobackup
    set nowritebackup
endif
"}}}
"{{{ spell and language
set complete+=kspell " Extends dictionary
set encoding=utf8    " Set utf8 as standard encoding
"}}}
"{{{ history
set history=7000
"}}}
"{{{ folds
if has('folding')
    augroup vimrcFold
      " fold vimrc itself by categories
      autocmd!
      autocmd FileType vim,zsh,conf set foldmethod=marker | set foldlevel=0
    augroup END
    set foldmethod=indent
    set foldlevelstart=99   " start unfolded
    set foldcolumn=1
    set foldlevel=1
    if has('windows')
        set fillchars=vert:┃
    endif
endif
"}}}
" file types {{{
let g:tex_flavor = "latex"
" }}}
"{{{ others
set noshowmode       " remove insert from command line
set virtualedit=block " better block selection
set ffs=unix,dos,mac " Use Unix as the standard file type
set laststatus=2     " Always display the status line
set lazyredraw       " Don't redraw while executing macros (good performance)
set list listchars=tab:»·,trail:-,extends:>,precedes:<,eol:¬,nbsp:·
set omnifunc=syntaxcomplete#Complete " omnicompletition
set showcmd          " Show current commands
if has('wildmenu')
  set wildmenu       " show options as list when switching buffers etc
endif
set wildmode=longest:full,full " shell-like autocomplete to unambiguous portion
filetype plugin on   " allow file types plugins to run when opening file
"}}}
" {{{ [NV] nvim specific
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" }}}
"}}}
" ----------------- Plugins --------------- {{{
" Enable/disable on startup {{{
let g:echodoc_enable_at_startup = 1
let g:deoplete#enable_at_startup = 1
let g:acp_enableAtStartup = 0
" }}}
" airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'
let g:airline#extensions#capslock#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
"}}}
" [NV] deoplete {{{
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" }}}
" [NV] ultisnips {{{
let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
let g:UltiSnipsSnippetDirectories=["UltiSnips","vim-snippets"]
let g:UltiSnipsEditSplit="context"
" }}}
" vim2hs {{{
let g:haskell_conceal = 0 " disable all prity haskell symbols
" let g:haskell_conceal_wide = 1 " enable all prity haskell symbols
" }}}
" Others {{{
let g:table_mode_corner="|"            " Table modeline
let g:instant_markdown_autostart = 0   " instant don't open browser on startup
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'} " vimwiki markdown support
" }}}
"}}}
"{{{ color
color monokai
color molokai
set t_ut=
hi CursorLine   cterm=NONE ctermbg=black ctermfg=gray guibg=black guifg=gray
"}}}
"}}}
