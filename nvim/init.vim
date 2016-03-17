" "VIMRC SETTINGS" ##
" Version: 2015.11 @private
"
" SECTIONS
" GeneralOptions:
" VisualOptions:
" MappingsAndCommands:
" VimPlugins:

"" GeneralOptions: {{{
filetype plugin indent on
syntax enable       " Syntax highlighting is enabled (and overrideable)

" Whitespace options is mainly based on Python/Django
set expandtab       " Make spaces not tabs! Tabs runs you out!
set sw=4 tabstop=4  " Python development teaches you that 4 = good for indention
set textwidth=120

set ttimeoutlen=-1           " Fixes input issues when nvim is run in tmux
set hidden                   " Allow unsaved buffers to be backgrounded
set path=**                  " Makes :find work better. Thanks romainl!
set nobackup nowb noswapfile " Vim-based backup is more trouble than it's worth
set history=1000             " More history
set wildmenu                 " This is really funky
set wildignore=*.pyc,*~,*.mo

set autoindent      " Keep indent from previous line
set autoread        " Set to auto read from file when it is changed
set fo+=j           " Formatoptions: Combine comment lines intelligently with J
set backspace=indent,eol,start     " Enable backspacing over everything in insert mode
set smartindent
set smarttab
set autoread
set mouse=a
set tags=./tags;,tags,./.git/tags

" Enable Vim to read it's own quickfix format
set errorformat+=%f\|%l\ col\ %c\|%m

" Spelling: in git commit messages
autocmd BufRead  COMMIT_EDITMSG setlocal spell
" }}}

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

"" MappingsAndCommands: {{{

" Not sure what <leader> to choose... 's'? '§'? '\' is the default.
let mapleader = ' '

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

" Bracket Navigation: Quickfix, Buffers, Arguments, Tags
nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>
nnoremap [l :lprev<cr>
nnoremap ]l :lnext<cr>
nnoremap [b :bprev<cr>
nnoremap ]b :bnext<cr>
nnoremap [a :prev<cr>
nnoremap ]a :next<cr>
nnoremap [t :pop<cr>
nnoremap ]t :tag<cr>

" I don't really use [count]go (go to byte #), tags are more useful to me
nnoremap go g<c-]>
xnoremap go g<c-]>

" Yank entire line / to end of line, without EOL, like D
nnoremap Y yg_:echo "Yanked: ".@"<cr>

" Easier access to search
nnoremap s /
xnoremap s /

" This is a great shortcut for fast redrawing and resetting highlight.
nnoremap <silent> <C-l> :<C-u>nohlsearch<cr><C-l>

" Utilize Swedish Characters:

" For comfort, remap Swedish keys to oft-used AltGr characters.
" (Technically these are placed at å and ¨ on American keyboards.)
nmap ö [
nmap Ö {
nmap ä ]
nmap Ä }
nmap öö [[
nmap ää ]]

imap ¨ /
nmap ¨ /
cmap ¨ /

" Quick access to temporary mappings
nnoremap § :nmap §

" Follow tags in helpfiles with <CR> or <F1>
nmap <F1> <esc>
autocmd Filetype help nnoremap <buffer> <cr> <c-]>
autocmd Filetype help nnoremap <buffer> <F1> <c-]>

" Execute file on F5 (in various ways)
autocmd Filetype vim nnoremap <buffer> <F5> :source %<cr>
autocmd Filetype python nnoremap <buffer> <F5> :!python %<CR>
autocmd Filetype python nnoremap <buffer> <S-F5> :!python %
" Quicksave
nnoremap <F8> :w<cr>
" Use <F12> and <S-F12> to toggle wrapping and listing
nnoremap <F12> :set wrap!<cr>
nnoremap <F24> :set list!<cr>
" <F11> to set colorcolumn based on Github maxwidth
nnoremap <F11> :set colorcolumn=111<cr>

" Search non-magically with * and # in visual mode
" Useful for text containing special characters, e.g. filenames or line-endings
function! NullToDollar(str)
    return substitute(substitute(a:str, '\%x00$', '\\$', ''), '\%x00', '\\$\\n', 'g')
endfunction
xnoremap * "ly/\V<c-r>=NullToDollar(escape(@l, '/\'))<cr><cr>
xnoremap # "ly?\V<c-r>=NullToDollar(escape(@l, '/\'))<cr><cr>

" Easier System Clipboard Interaction:
nnoremap ,p "+p
nnoremap ,P "+P
xnoremap ,p "+p
xnoremap ,P "+P
xnoremap åy "+y
xnoremap gy "+y
xnoremap ,y "+y

" QuickPaste: Nice default-paste shortcut: þ (AltGr-p)
noremap  þ "0p
noremap! þ <c-r>0
noremap  ,þ "+p
noremap! ,þ <c-r>+

" Break insert undo-chain before deleting whole line
inoremap <C-U> <C-G>u<C-U>
" Keep flags when repeating last substitute command.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"" Text Replacement with <Ctrl-r>
" By pressing <ctrl-r> in visual mode you will be prompted to enter text to replace with.
" Press enter and then confirm each change you agree with 'y' or decline with 'n'.
vnoremap <C-r> "ly:%s/<C-r>l//gc<left><left><left>

" Unload current buffer and go to previous. (Thanks Mud)
" Useful for keeping the window open, which :bd<cr> doesn't.
nnoremap <leader>d :bp <bar> bd #<cr>

" Neovim Term
tnoremap <Esc> <C-\><C-n>

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
" Quick .vimrc editing
command! Vimrc tab drop $MYVIMRC
" Change current working directory to the current file's directory
command! WorkHere cd %:h
" Make current buffer a "Scratch" buffer
command! Temporary setlocal buftype=nofile bufhidden=hide noswapfile
" Copy current filename
command! CopyFilename let @"=@% | let @+=@% | let @*=@%

" Trim: trim all whitespace from end of lines
command! Trim exe "norm! ml" | keeppatterns %s/\s\+$//e | norm! `l
autocmd BufWritePre * Trim

au Filetype python setl equalprg=yapf\ --style={column_limit:120}
au Filetype python command! -buffer -range=% Isort :<line1>,<line2>! isort -
au Filetype python command! -buffer PrintWrap normal! Iprint(<esc>A<c-v>)<esc>
au Filetype python command! -buffer Breakpoint call append(line('.')-1, repeat(' ', indent(prevnonblank(line('.')))).'import ipdb; ipdb.set_trace()  # XXX BREAKPOINT')
au Filetype python nnoremap <buffer> <leader>b :Breakpoint<cr>
au Filetype python nnoremap <buffer> <leader>p :PrintWrap<cr>
au Filetype python nnoremap <buffer> <leader>s :Isort<cr>
au Filetype sql,mysql set formatprg=sqlformat\ -r\ -
au Filetype vim setlocal foldmethod=marker

" }}}

"" VimPlugins: {{{

" Plugin List: {{{2
call plug#begin()
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
Plug 'chakrit/upstart.vim'

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
" 2}}}

" Plugin Options: {{{2

" GitGutter (plugin)
nnoremap [g :GitGutterPrevHunk<cr>
nnoremap ]g :GitGutterNextHunk<cr>
command! GGR GitGutterRevertHunk
cabbrev ggr GGR

" Emmet (Plugin)
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Ag (plugin)
let g:ag_prg="ag --column"
nnoremap ª :Ag! "\b<c-r>=expand("<cword>")<cr>\b"
xnoremap ª "ly:Ag! "\b<c-r>l\b"
cabbrev ag Ag
command! -nargs=1 Usage Ag! "\b<args>\b"

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
