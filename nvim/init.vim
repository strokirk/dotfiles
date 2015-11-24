" S:SETTINGS: " {{{1
" General
filetype plugin indent on
syntax enable       " Syntax highlighting is enabled (and overrideable)
set autoread
set mouse=a
" Vim-based backup is more trouble than it's worth
set nobackup nowb noswapfile
" More history
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

"" VisualOptions: {{{
set background=dark
silent! colorscheme desert
set laststatus=2    " Always enable statusline
set number          " Turn n line number
set ruler           " Shows line & column number
set scrolloff=5     " Always keep 7 lines above and below cursor
set showcmd         " Shows the half-finished command when typed
set showmatch       " Show matching brackets when cursor is over one of them
" set rnu           " Relative line numbers

set smartcase
set ignorecase

" These are set by default in NeoVim, so are technically no-ops in a .nvimrc " {{{
set hlsearch        " Highlight makes things easier to find
set incsearch       " Incremental search is a necessity
set autoread        " Automatically load external changes to files
set backspace=indent,eol,start
set wildmenu        " Pop-up-menu based command-line completion
set autoindent
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif
" }}}

"" Line Wrapping:
set cpoptions+=n            " The 'number' column used for wrapped text
set linebreak               " Makes vim try to wrap lines at non-word characters
set showbreak=+++           " Text to put before wrapped text
set wrap
" Some slightly more interesting listchars
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×,eol:¬
au Filetype qf setlocal nowrap " Quicklist shouldn't wrap by default
set statusline=[%F]%h%r%m\ Buf-%n%=%c,%l/%L\ [%p%%]
" }}}

"" GUI
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
nnoremap Q @q

" Quick window resizing. Thanks kaldrenon!
" Double-tapping feels a bit quicker than a chord.
nnoremap ++ <C-w>+
nnoremap -- <C-w>-

" Move down a screen line if the actual line is wrapped.
noremap j gj
noremap k gk

" Select line characterwise (without whitespace)
nnoremap vv ^vg_

" Select the entire file
nnoremap VF VggoG

" I never use normal _, but g_ is often more useful than $
nnoremap _ g_

" Save with C-s
nnoremap <C-s> :update<CR>
" Redraw and remove highlight
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Follow tags more comfortably
nnoremap go <C-]>

" Yank entire line / to end of line, without EOL, like D
nnoremap Y yg_:echo "Yanked: ".@"<cr>

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

imap ¨ /
nmap ¨ /
cmap ¨ /

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

" Quick :copen. Abbreviation avoids mistyping it as :copy
" Techically :cw might be faster, but I often tend to use copen when I shouldn't
cabbrev cop copen

" Other common misspellings
cabbrev Q q
cabbrev W w
cabbrev Wq wq
cabbrev Qall qall
cabbrev Wall wall
cabbrev Wqall wqall

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
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'fmoralesc/vim-pad'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'

" Visual:
Plug 'bling/vim-airline'
Plug 'tmhedberg/SimpylFold'
Plug 'tomasr/molokai'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'

" Syntax:
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee'     }
Plug 'pangloss/vim-javascript',  { 'for': 'javascript' }
Plug 'plasticboy/vim-markdown',  { 'for': 'markdown'   }
Plug 'vim-scripts/fountain.vim', { 'for': 'fountain'   }
Plug 'wting/rust.vim',           { 'for': 'rust'       }
Plug 'tpope/vim-git'
Plug 'tmux-plugins/vim-tmux'

" New Or Evaluating:
Plug 'AndrewRadev/sideways.vim'
Plug 'FooSoft/vim-argwrap'
Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-characterize'

call plug#end()

" s:Plugin Maps And Commands:
nnoremap [g :GitGutterPrevHunk<cr>
nnoremap ]g :GitGutterNextHunk<cr>

" Ag (plugin)
let g:ag_prg="ag --column"
nnoremap ª :Ag! "\b<c-r>=expand("<cword>")<cr>\b"
cabbrev ag Ag

" NERDTree (plugin)
nnoremap <C-T> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>
command! NTF NERDTreeFind
cabbrev ntf NTF
let NERDTreeIgnore=['\.cover$', '\.pyc$', '\~$', '__pycache__']

" Fugitive (plugin)
nnoremap <F4> :Gblame<cr>

" Vim-pad (plugin)
nnoremap <F9> :Pad ls<cr>

" CtrlP (plugin)
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let NERDTreeIgnore=['\.pyc$']
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Fountain (plugin)
au BufEnter *.fountain setf fountain

let g:colorscheme_switcher_define_mappings = 0
nnoremap <silent> <F2> :NextColorScheme<CR>

" Use desert as default colorscheme, molokai if installed
silent! colorscheme desert
silent! colorscheme molokai

" }}}
" vim: foldmethod=marker
