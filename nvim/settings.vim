" vim: foldmethod=marker

scriptencoding utf-8

let g:python3_host_prog = expand($HOME) . '/.pyenv/versions/neovim-3/bin/python'
set updatetime=100

" Whitespace options is mainly based on Python/Django
set expandtab                " Make spaces not tabs! Tabs runs you out!
set shiftwidth=4 tabstop=4   " Python development teaches you that 4 = good for indention
set textwidth=120

set mouse=a                  " Enable mouse in all modes
set ttimeoutlen=-1           " Fixes input issues when nvim is run in tmux
set hidden                   " Allow unsaved buffers to be backgrounded
set path=**                  " Makes :find work better. Thanks romainl!
set nobackup nowb noswapfile " Vim-based backup is more trouble than it's worth
set wildignore=*.pyc,*~,*.mo

set inccommand=nosplit       " Shows the effects of a command incrementally, as you type
set formatoptions+=l         " Formatoptions: Don't break already long lines
set nosmartindent            " Python comments (#) can't handle smartindent
set tags=./tags;,tags,./.git/tags,.git/tags

" Enable Vim to read it's own quickfix format
set errorformat+=%f\|%l\ col\ %c\|%m
set errorformat+=%f:%l\ %m
" set errorformat+=%f:\ line\ %l,\ col\ %c,\ %m
set errorformat+=%f:%m

" CSS selector names are usually in snake-case
set iskeyword+=-

"" VisualOptions: {{{
set termguicolors
set background=dark
silent! colorscheme desert
set number          " Turn n line number
set ruler           " Shows line & column number
set scrolloff=5     " Always keep 7 lines above and below cursor
set showcmd         " Shows the half-finished command when typed
set showmatch       " Show matching brackets when cursor is over one of them
set foldlevel=999

set smartcase
set ignorecase
set inccommand="nosplit"

"" Line Wrapping:
set cpoptions+=n            " The 'number' column used for wrapped text
set linebreak               " Makes vim try to wrap lines at non-word characters
set showbreak=+++           " Text to put before wrapped text
set wrap
" Some slightly more interesting listchars
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×,eol:¬
set statusline=[%F]%h%r%m\ Buf-%n%=%c,%l/%L\ [%p%%]
" }}}

autocmd Filetype qf setlocal nowrap " Quicklist shouldn't wrap by default

" Spelling: in git commit messages
autocmd BufRead COMMIT_EDITMSG setlocal spell
autocmd BufRead COMMIT_EDITMSG setlocal textwidth=72
autocmd Filetype gitcommit setlocal spell
autocmd Filetype gitcommit setlocal textwidth=72
" }}}

autocmd Filetype yaml setlocal foldmethod=indent
autocmd Filetype elixir setlocal foldmethod=indent
autocmd Filetype markdown setlocal textwidth=73
