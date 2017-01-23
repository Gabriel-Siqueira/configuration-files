"{{{ ====================== Commands ======================

command! -nargs=0 Clean :set nonu nolist foldcolun=0
command! -nargs=0 Unclean :set nu list foldcolun=1

"}}}

"{{{ ====================== functions ======================

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

function! SwitchColorSchemes()
    if g:colors_name == 'molokai'
         colorscheme monokai
    elseif g:colors_name == 'monokai'
         colorscheme desert
    elseif g:colors_name == 'desert'
        colorscheme vividchalk
    elseif g:colors_name == 'vividchalk'
        colorscheme solarized
        let g:solarized_termcolors=256
    elseif g:colors_name == 'solarized'
        colorscheme monokai
        colorscheme molokai
    endif
    echomsg 'color:' g:colors_name
endfunction

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

"{{{ ====================== mappings ======================

" Leader
let mapleader = 'ç'
set tm=2000 " time to leader became ç

" NerdTree Ctrl n
map <C-n> :NERDTreeToggle<CR>

" Move a line of text using leader+[jk]
nmap <leader>j mz:m+<cr>`z
nmap <leader>k mz:m-2<cr>`z
vmap <leader>j m'>+<cr>`<my`>mzgv`yo`z
vmap <leader>k :m'<-2<cr>`>my`<mzgv`yo`z

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Toggle and untoggle spell checking
nmap <leader>ss :setlocal spell!<cr>
nmap <leader>sc :call SwitchSpellLang()<CR>

" Visual mode pressing * or # searches for the current selection
" vnoremap <silent> * :call VisualSelection('f')<CR>
" vnoremap <silent> # :call VisualSelection('b')<CR>

" Create new line and stay in normal mode
nmap <Leader>o o<ESC>k
nmap <Leader>O O<ESC>j

" Change color scheme
map <F6> :call SwitchColorSchemes()<CR>
" Change between insert and Paste
set pastetoggle=<F2>
" toggle graphic undo tree
nnoremap <F5> :GundoToggle<CR>

" remove extra white space
nmap <leader><space> :%s/\s\+$<cr>

" Prompt for command with vimux
nmap <Leader>p :VimuxPromptCommand<CR>

" Toggle Hard mode
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" ultisnips and neocomplete {{{

let g:UltiSnipsExpandTrigger = "<c-y>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
" For smart TAB completion.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

"}}}

" {{{ Accept habits 
" Q also quits
cnoreabbrev Q q
cnoreabbrev WQ wq
cnoreabbrev Wq q
" }}}

"}}}

"{{{ ===================== Plugins ==========================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Plug 'Shougo/neosnippet.vim'                 " snippets
" Plug 'Valloric/YouCompleteMe'                 " auto-completition
Plug 'Konfekt/FastFold'                       " speed up folds by updating
Plug 'Lokaltog/vim-easymotion'                " move following leters
Plug 'LumenAstralis/lilypond-vim'             " recognize lilypond files
Plug 'Shougo/neocomplete.vim'                 " auto-completition
Plug 'Shougo/unite.vim'                       " search/display info (file, buf)
Plug 'Shougo/vimproc.vim', {'do' : 'make'}    " Interactive command execution
Plug 'SirVer/ultisnips'                       " use snippets
Plug 'benmills/vimux'                         " use tmux with vim
Plug 'ctrlpvim/ctrlp.vim'                     " finder (fuzzy file, tag, etc)
Plug 'dhruvasagar/vim-table-mode'             " create and edit tables
" Plug 'ervandew/supertab'                      " tab for complete
Plug 'gmarik/Vundle.vim'                      " manage plugins
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
Plug 'lervag/vimtex'                          " for edit latex
Plug 'rhysd/vim-grammarous'                   " grammar checking
Plug 'ryanoasis/vim-devicons'                 " icons
Plug 'scrooloose/nerdtree'                    " tree of files
Plug 'scrooloose/syntastic'                   " syntax Highlight
Plug 'sjl/gundo.vim'                          " undo tree
Plug 'suan/vim-instant-markdown'              " see markdown files on browser
Plug 'tpope/vim-commentary'                   " comment in and out
Plug 'tpope/vim-fugitive'                     " work with git
Plug 'tpope/vim-repeat'                       " extend use of .
Plug 'tpope/vim-surround'                     " new object surrond
Plug 'vim-airline/vim-airline'                " new mode line
Plug 'vim-airline/vim-airline-themes'         " themes for airline
Plug 'vim-scripts/ZoomWin'                    " make pane full screen
Plug 'vimwiki/vimwiki'                        " make files in a personal wiki
Plug 'wikitopian/hardmode'                    " make vim harder

""{{{ Colors
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'sickill/vim-monokai'
Plug 'tpope/vim-vividchalk'
""}}}

"{{{ Haskell
" Plug 'enomsg/vim-haskellConcealPlus'         " prity haskell symbols
Plug 'Twinside/vim-haskellFold'                " fold for haskell
Plug 'Twinside/vim-hoogle'                     " search on hoogle
Plug 'dag/vim2hs'                              " lots of help with haskell
Plug 'eagletmt/ghcmod-vim', {'do' : 'cabal install ghc-mode'} " type checker
Plug 'eagletmt/neco-ghc'                       " Omni completition
Plug 'mpickering/hlint-refactor-vim'           " use hlint
" Plug 'neovimhaskell/haskell-vim'
"}}}

" {{{ Other lenguages
Plug 'rust-lang/rust.vim'                     " for rust
" }}}

call plug#end()

"}}}

"{{{ ====================== settings ======================

set nocompatible   " be iMproved
syntax enable      " Enable syntax highlighting
syntax on

" ----------------- Sets -----------------  {{{

"{{{ indentation
set ai               " Auto indent
set si               " Smart indent
set tabstop=4        " 1 tab == 2 spaces
set shiftwidth=4     " Number of spaces to use for each step of (auto)indent
set expandtab        " Replace tabs with spaces
set shiftround       " always indent by multiple of shiftwidth
"}}}

"{{{ numbers
set number            " Line number
set ruler            " Always show current position
set numberwidth=2
set relativenumber " Show numbers relative to the current line
"}}}

"{{{ search
set hlsearch      " Highlight search results
set incsearch     " Makes search act like search in modern browsers
"}}}

"{{{ line and column
set cursorline    " Highlight cursor line
set colorcolumn=+1    " Make it obvious where textwith are
if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
  let &showbreak='⤷ '                 " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif
"}}}

"{{{ play nice
set backspace=indent,start,eol  " Backspace deletes like most programs in insert mode
set mouse=a                     " enable mouse
set scrolloff=10                " Keep cursor centered
set sidescrolloff=3             " scrolloff for columns
set showmatch                   " Show matching brackets when text indicator is over them
set textwidth=77
set viminfo^=%                  " Remember info about open buffers on close
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j          " remove comment leader when joining comment lines
endif
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
set encoding=utf8 " Set utf8 as standard encoding
"}}}

"{{{ history
set history=7000
"}}}

"{{{ Folds
if has('folding')
    augroup vimrcFold
      " fold vimrc itself by categories
      autocmd!
      autocmd FileType vim set foldmethod=marker
      autocmd FileType vim set foldlevel=0
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

"{{{ Gui
set guioptions-=T     " don't show toolbar
set guioptions-=m     " don't show menubar
set guifont=Unispace
set guicursor+=a:blinkon0
"}}}

"{{{ Others
set ffs=unix,dos,mac  " Use Unix as the standard file type
set laststatus=2  " Always display the status line
set lazyredraw    " Don't redraw while executing macros (good performance)
set list listchars=tab:»·,trail:-,extends:>,precedes:<,eol:¬,nbsp:·
set omnifunc=syntaxcomplete#Complete " omnicompletition
set showcmd          " Show current commands
if has('wildmenu')
  set wildmenu                        " show options as list when switching buffers etc
endif
set wildmode=longest:full,full        " shell-like autocomplete to unambiguous portion
filetype plugin on                " allow file types plugins to run when opening file
"}}}

"}}}

" ----------------- Plugins --------------- {{{

" Table modeline {{{
let g:table_mode_corner="|"
"}}}

" Neocomplete {{{

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Shell like behavior(not recommended).
set completeopt+=longest
let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"}}}

" airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'
"}}}

" ultisnips {{{
let g:UltiSnipsSnippetsDir='~/.vim/mysnippets'
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets","vim-snippets"]
" }}}

" vim2hs {{{
let g:haskell_conceal = 0 " disable all prity haskell symbols
" let g:haskell_conceal_wide = 1 " enable all prity haskell symbols
" }}}

" vimwiki {{{
" markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
"}}}

" instant markdown_autostart {{{
" don't open browser on startup
let g:instant_markdown_autostart = 0
"}}}

"}}}

" when use GNU/Linux use bash as shell
"{{{

if has("unix")
    let &shell="bash"
    set clipboard=autoselect
endif
"}}}

" Return to last edit position when opening files ans save history
"{{{

set viminfo='100,\"1000,:40,%,n~/.viminfo
   au BufReadPost * if line("'\"")|execute("normal `\"")|endif
   autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
"}}}

" Manager Cursor color
" {{{
if exists('$TMUX')
else
    autocmd VimEnter * silent !echo -ne "\033]12;blue\007"
    autocmd InsertEnter * silent !echo -ne "\033]12;green\007"
    autocmd InsertLeave * silent !echo -ne "\033]12;blue\007"
    silent !echo -ne "\033]12;blue\007"
    " reset cursor when vim exits
    autocmd VimLeave * silent !echo -ne "\033]12\007"
endif
"}}}

"{{{ color

color monokai
color molokai
set t_ut=

"}}}

"}}}