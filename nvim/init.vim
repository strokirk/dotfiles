" S:SETTINGS: " {{{1
" General
filetype plugin on
syntax enable       " Syntax highlighting is enabled (and overrideable)
set autoread
set nobackup        " Honestly, local file backup is not so hot...
set noswapfile
set mouse=a
set history=1000

"" EDITING
set autoindent      " Keep indent from previous line
set autoread        " Set to auto read from file when it is changed
set backspace=indent,eol,start     " Enable backspacing over everything in insert mode
set expandtab       " Make spaces not tabs! Tabs runs you out!
set fo+=j           " Formatoptions: Combine comment lines intelligently with J
set hidden
set path+=**        " Improves the :find experience A LOT
set smartindent
set smarttab
set sw=4 tabstop=4  " Python development teaches you that 4 = good for indention
set wildmenu        " This is really funky
set wildignore=*.pyc

"" VISUAL
" set rnu           " Relative line numbers
set cpoptions-=n    " The "number" column should not be used for wrapping text
set laststatus=2    " Always enable the statusline
set linebreak       " Wrap intelligently
" Some slightly more interesting listchars
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×,eol:¬
set number          " Turn on line number
set ruler           " Shows line & column number (not really necessary with my statusline)
set scrolloff=5     " Always keep 7 lines above and below cursor
set showcmd         " Shows the half-finished command when typed
set showmatch       " Show matching brackets when cursor is over one of them
set statusline=[%F]%h%r%m\ Buf-%n%=%c,%l/%L\ [%p%%]
au Filetype qf setlocal nowrap " Quicklist shouldn't wrap by default

"" SEARCH
set hlsearch        " Highlight makes things easier
set ignorecase
set incsearch       " Incremental search is a necessity
set smartcase

"" GUI
set background=dark
silent! colorscheme desert
if has("gui")
    set vb t_vb=
    set guifont=Droid\ Sans\ Mono\ 10,Meslo\ LG\ S:h9,Inconsolata:h11,Consolas:h9
    set guifontwide=MS\ Gothic:h9
    set guioptions-=L   " Remove left and right scrollbar from vertically split
    set guioptions-=R   " windows. Those can cause problems on a docked gvim window
endif
" }}}
" S:MAPPINGS AND COMMANDS: " {{{1

" Repeat 'default' mapping (Essential, instead of Enter Ex mode)
nmap Q @q
" Natural up/down movement over long lines
nnoremap j gj
nnoremap k gk
" Save with C-s
nnoremap <C-s> :update<CR>
" Redraw and remove highlight
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Quick window resizing (thx kaldrenon!)
nnoremap ++ <C-w>+
nnoremap -- <C-w>-
" Follow tags more comfortably
nnoremap go <C-]>
" Select line characterwise (without whitespace)
nnoremap vv ^vg_

" Yank entire line / to end of line, without EOL
nnoremap Y y$

" * and # for selected text, trying to keep the search literal (in case of
" filenames, for example.)
vnoremap * "ly/\V<c-r>=escape(@l, '/\')<cr><cr>
vnoremap # "ly?\V<c-r>=escape(@l, '?\')<cr><cr>

" Utilize Swedish Characters:
let mapleader = 'å'
nmap ö [
nmap ä ]
nmap öö [[
nmap ää ]]

" More Bracket Navigation: extend ], [
nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>
nnoremap [a :prev<cr>
nnoremap ]a :next<cr>
nnoremap [b :bprev<cr>
nnoremap ]b :bnext<cr>
nnoremap [t :tnext<cr>
nnoremap ]t :tprev<cr>
nnoremap <leader>d :bp \| bd #<cr>

" Follow tags in help files with <Enter>
nmap <F1> <esc>
autocmd Filetype help nnoremap <buffer> <cr> <C-]>

" Quicksave on F8
nnoremap <F8> :update<cr>
" Toggle Wrap and List with F12
nnoremap <F12> :set wrap!<cr>
nnoremap <S-F12> :set list!<cr>
" Execute file on F5 (in various ways)
autocmd Filetype vim nnoremap <buffer> <F5> :source %<cr>
autocmd Filetype python nnoremap <buffer> <F5> :!python %<CR>
autocmd Filetype python nnoremap <buffer> <S-F5> :!python %

" Easier System Clipboard Interaction:
xnoremap <C-c> "*y
xnoremap gy "*y
noremap gy "*y
noremap ,y "*y
noremap ,p "*p
noremap ,P "*P

" Nice default-paste shortcut: þ (AltGr-p)
nnoremap þ "0p
xnoremap þ "0p
cnoremap þ <c-r>0
inoremap þ <c-r>0

" Make search more accessible
nnoremap s /
" Break insert undo-chain before deleting whole line
inoremap <C-U> <C-G>u<C-U>
" Keep flags when repeating last substitute command.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"" Text Replacement with <Ctrl-r>
" By pressing <ctrl-r> in visual mode you will be prompted to enter text to replace with.
" Press enter and then confirm each change you agree with 'y' or decline with 'n'.
vnoremap <C-r> "ly:%s/<C-r>l//gc<left><left><left>

" s:Commands:
" Quick vimrc editing
command! Vimrc tab drop $MYVIMRC
" Change current working directory to the current file's directory
command! WorkHere cd %:h
" Trim all whitespace from end of lines
command! Trim keepjump keeppattern %s/\s\+$//e
autocmd BufWritePre * Trim

" Frequent mispellings
command! W w
command! Wqall wqall
command! WQall wqall
command! Q q
command! Qall qall
" }}}
"
" s:Vim Plugins: " {{{1
call plug#begin('~/.nvim/plugged')
" Essential:
Plug 'airblade/vim-gitgutter'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
" Excellent:
Plug 'benekastah/neomake'
Plug 'davidhalter/jedi-vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
" Good:
Plug 'PeterRincker/vim-argumentative'
Plug 'SirVer/ultisnips'
Plug 'fmoralesc/vim-pad'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
" New Or Evaluating:
Plug 'AndrewRadev/sideways.vim'
Plug 'FooSoft/vim-argwrap'
Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-characterize'
" Syntax:
Plug 'pangloss/vim-javascript',  { 'for': 'javascript' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee'     }
Plug 'plasticboy/vim-markdown',  { 'for': 'markdown'   }
Plug 'wting/rust.vim',           { 'for': 'rust'       }
Plug 'vim-scripts/fountain.vim', { 'for': 'fountain'   }
Plug 'tpope/vim-git'
" Visual:
Plug 'bling/vim-airline'
Plug 'tomasr/molokai'
Plug 'tmhedberg/SimpylFold'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'

call plug#end()

colorscheme desert

" s:Plugin Maps And Commands:
nnoremap [g :GitGutterPrevHunk<cr>
nnoremap ]g :GitGutterNextHunk<cr>

" Nerdtree (plugin)
nnoremap <F3> :NERDTreeFind<CR>
nnoremap <c-t> :NERDTreeToggle<cr>

let NERDTreeIgnore=['\.pyc$']
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Fountain (plugin)
au BufEnter *.fountain setf fountain

let g:colorscheme_switcher_define_mappings = 0
nnoremap <silent> <F2> :NextColorScheme<CR>

" }}}
" vim: foldmethod=marker
