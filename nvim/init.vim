" "VIMRC SETTINGS" ##
"
" SECTIONS
" GeneralOptions:
" VisualOptions:
" Mappings:
" Commands:
" Plugins:

"" GeneralOptions: {{{
" TODO: MkNonExDir
" TODO: Mapping för Expand selection
" TODO: Mapping för Select under cursor
" TODO: Mapping %% för hela filen?
" TODO: Mapping för viW och viW
" TODO: Mapping för CtrlP i taggläge?
" TODO: Blockdiff / Linediff
" TODO: VIM toggle list
" TODO: Edit quickfix lists interactively
" TODO: Gör bättre text-obj för [{(indent
" TODO: Bättre shortcut for bokmärken
" TODO: Bättre listning av saker som :reg
" NOTE: v_g Ctrl-A (increment all sequentially)

scriptencoding utf-8

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

set formatoptions+=l         " Formatoptions: Don't break already long lines
set nosmartindent   " Python comments (#) can't handle smartindent
set tags=./tags;,tags,./.git/tags

" Enable Vim to read it's own quickfix format
set errorformat+=%f\|%l\ col\ %c\|%m
set errorformat+=%f:%l\ %m
" set errorformat+=%f:\ line\ %l,\ col\ %c,\ %m
set errorformat+=%f:%m

" CSS selector names are usually in snake-case
set iskeyword+=-

" Spelling: in git commit messages
autocmd BufRead COMMIT_EDITMSG setlocal spell
autocmd BufRead COMMIT_EDITMSG setlocal textwidth=72
autocmd Filetype gitcommit setlocal spell
autocmd Filetype gitcommit setlocal textwidth=72
" }}}

"" VisualOptions: {{{
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
au Filetype qf setlocal nowrap " Quicklist shouldn't wrap by default
set statusline=[%F]%h%r%m\ Buf-%n%=%c,%l/%L\ [%p%%]
" }}}

"" Mappings: {{{

" Not sure what <leader> to choose... 's'? '§'? '\' is the default.
let g:mapleader = ' '

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

" I never use HML, so easier line navigation is nice
nnoremap L g_
xnoremap L g_
nnoremap H ^
xnoremap H ^

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

nnoremap <leader>go <c-w>g<c-]><c-w>T
nnoremap <leader>gf <c-w>gf

" Yank entire line / to end of line, without EOL, like D
nnoremap Y yg_:echo "Yanked: ".@"<cr>

" Easier access to search
nnoremap s /
xnoremap s /

" Make vim command mode more like readine
cnoremap <c-a>  <home>

" This is a great shortcut for fast redrawing and resetting highlight.
nnoremap <silent> <C-l> :<C-u>nohlsearch<bar>diffupdate<cr><C-l>

" Utilize Swedish Characters:

" For comfort, remap Swedish keys to oft-used AltGr characters.
" (Technically these are placed at å and ¨ on American keyboards.)
nmap ö [
nmap Ö {
nmap ä ]
nmap Ä }
nmap öö [[
nmap ää ]]
nmap ]] ]q
nmap [[ [q

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
inoremap <F8> <c-o>:w<cr>
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
xnoremap <leader>y "+y
xnoremap <leader>p "+p
xnoremap <leader>P "+P
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" QuickPaste: Nice default-paste shortcut: þ (AltGr-p)
noremap  þ "0p
noremap! þ <c-r>0
noremap  ,þ "+p
noremap! ,þ <c-r>+
map  π þ
map! π þ

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
command! CloseBuffer bp <bar> bd #
nnoremap <leader>d :CloseBuffer<cr>

" Neovim Term
tnoremap <Esc> <C-\><C-n>

" Quick :sort
xnoremap <leader>s :sort<cr>

" Abbreviations: {{{ "
" Quick :copen. Abbreviation avoids mistyping it as :copy
" Techically :cw might be faster, but I often tend to use copen when I shouldn't
cabbrev cop copen

" Just let me, darnit!
nnoremap ZQ :qa!<cr>
cabbrev Q q
cabbrev W w
cabbrev Qa qall
cabbrev Wq wq
cabbrev Qall qall
cabbrev Wall wall
cabbrev Wqall wqall
" }}} Abbreviations "
" }}}

" " Commands: {{{
" Quick .vimrc editing
command! Vimrc tab drop $MYVIMRC
" Change current working directory to the current file's directory
command! WorkHere cd %:h
" Make current buffer a "Scratch" buffer
command! -bar Temporary setlocal buftype=nofile bufhidden=hide nobuflisted noswapfile
command! -bar Scratch botright new *scratch*|Temporary|res 8|setl winfixheight
" Copy current filename
command! CopyFilename let @"=@% | let @+=@% | let @*=@%
" Clear open help panes like quickfix and similar
command! Clear silent tabdo NERDTreeClose | lcl | ccl

" Trim: trim all whitespace from end of lines
command! Trim exe "norm! ml" | keeppatterns %s/\s\+$//e | norm! `l
autocmd BufWritePre * Trim

" Autocommands: {{{ "
au Filetype python nnoremap <buffer> gp yiwoprint("<c-r>0: ", <c-r>0)  # XXX<esc>
au Filetype python xnoremap <buffer> gp yoprint("<c-r>0: ", <c-r>0)  # XXX<esc>
au Filetype javascript nnoremap <buffer> gp yiwoconsole.log("<c-r>0: ", <c-r>0)  // XXX<esc>
au Filetype javascript xnoremap <buffer> gp yoconsole.log("<c-r>0: ", <c-r>0)  // XXX<esc>

au Filetype python command! -buffer -range=% Isort :<line1>,<line2>! isort -
au Filetype python command! -buffer PrintWrap normal! Iprint(<esc>A<c-v>)<esc>
au Filetype python command! -buffer Breakpoint call append(line('.')-1, repeat(' ', indent(prevnonblank(line('.')))).'import ipdb; ipdb.set_trace()  # XXX BREAKPOINT')
au Filetype python nnoremap <buffer> <leader>b :Breakpoint<cr>
au Filetype python nnoremap <buffer> <leader>p :PrintWrap<cr>
au Filetype python nnoremap <buffer> <leader>s :Isort<cr>
au Filetype sql,mysql set formatprg=sqlformat\ -r\ -
au Filetype sql,mysql set equalprg=sqlformat\ -r\ -
au Filetype sql,mysql nmap <F5> vip<F5>
au Filetype sql,mysql xnoremap <F5> :'<,'>Clam mysql --table<cr><c-w>h
au Filetype vim setlocal foldmethod=marker
au Filetype scss setl equalprg=sass-convert\ --stdin\ -F\ scss\ -T\ scss
au Filetype python setl equalprg=autopep8\ -\ --max-line-length\ 119\ -a\ --ignore\ E309
au Filetype javascript setl equalprg=js-beautify\ -i\ -s\ 2\ -w\ 130\ -X\ --brace-style=collapse-preserve-inline
au Filetype javascript setl foldmethod=syntax
" }}} Autocommands "

" s:Pipe Vim Command Output To Tab: {{{ "
" From the vim wikia
function! TabMessage(cmd)
  redir => l:message
  silent execute a:cmd
  redir END
  if empty(l:message)
    echoerr 'no output'
  else
    " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
    tabnew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
" }}} Pipe Vim Command Output To Tab: "

function! s:ScratchRead(cmd, ...)
    if bufwinnr('*scratch*') | bw *scratch* | endif
    Scratch | set previewwindow
    exe '0read !'.a:cmd
    execute "normal \<c-w>p"
endfunction
command! -nargs=+ ScratchRead call s:ScratchRead("<args>")

" Toggle Quickfix window {{{ "
nnoremap <leader>q :QuickfixToggle<cr>
command! QuickfixToggle call QuickfixToggle()
function! QuickfixToggle()
  if exists("g:qfix_win")
    cclose
    unlet g:qfix_win
  else
    copen
    let g:qfix_win = bufnr("$")
  endif
endfunction
" }}} Toggle Quickfix window "

" }}}

"" Plugins: {{{

" Plugin List: {{{2
call plug#begin()
" Essential:
Plug 'airblade/vim-gitgutter'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'benekastah/neomake'

" Excellent:
Plug 'davidhalter/jedi-vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'

" Good:
Plug 'PeterRincker/vim-argumentative'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'sjl/clam.vim'         | " easily run Shell commands
Plug 'tpope/vim-eunuch'

" Visual:
Plug 'bling/vim-airline'
Plug 'tmhedberg/SimpylFold'
Plug 'tomasr/molokai'
Plug 'tpope/vim-characterize'
Plug 'xolox/vim-misc'
Plug 'machakann/vim-highlightedyank'

" Syntax And Filetype:
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee'     }
Plug 'pangloss/vim-javascript'   | Plug 'mxw/vim-jsx'
Plug 'plasticboy/vim-markdown',  { 'for': 'markdown'   }
Plug 'rust-lang/rust.vim',       { 'for': 'rust'       }
Plug 'vim-scripts/fountain.vim', { 'for': 'fountain'   }
Plug 'ElmCast/elm-vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'chakrit/upstart.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-hclfmt'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-git'
Plug 'vim-scripts/nginx.vim'
Plug 'elixir-lang/vim-elixir'

" Notetaking:
Plug 'vimoutliner/vimoutliner' | " Uses a custom syntax vaguely similar to org-mode
Plug 'xolox/vim-notes'         | " Uses a custom syntax
Plug 'mrtazz/simplenote.vim'

" New Or Evaluating:
Plug 'jeetsukumaran/vim-gazetteer' | " Manages tag finding for ctrl-p (use gz)
Plug 'AndrewRadev/sideways.vim'
Plug 'FooSoft/vim-argwrap'
Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'michaeljsmith/vim-indent-object'
Plug 'terryma/vim-multiple-cursors'
Plug 'wellle/targets.vim'
Plug 'rizzatti/dash.vim'

call plug#end()
" 2}}}

" Plugin Options: {{{2

" GitGutter: (plugin)
nnoremap [g :GitGutterPrevHunk<cr>
nnoremap ]g :GitGutterNextHunk<cr>
command! GGR GitGutterRevertHunk
cabbrev ggr GGR

" Neomake: (plugin)
au BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

" Emmet: (Plugin)
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Tagbar: (Plugin)
nnoremap <F2> :TagbarToggle<cr>

" Jedi: (Plugin)
let g:jedi#goto_command = '' | " This competes with my <leader>d mapping
let g:jedi#popup_on_dot = 0 | " Jedi tends to freeze vim while loading the autocompletions

" Ag: (plugin) (use AltGr to quickly search)
let g:ag_prg='ag --column'
nnoremap ª :Ag! "\b<c-r>=expand("<cword>")<cr>\b"
xnoremap ª "ly:Ag! "<c-r>l"
cabbrev ag Ag
command! -nargs=1 Usage Ag! '\b<args>\b'

" NERDTree: (plugin)
nnoremap <C-T> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>
command! NTF NERDTreeFind
cabbrev ntf NTF
let g:NERDTreeIgnore=['\.cover$', '\.pyc$', '\~$', '__pycache__', 'node_modules']

" Fugitive: (plugin)
nnoremap <F4> :Gblame<cr>
nnoremap <leader>gw :Gw<cr>
nnoremap <leader>ga :Gdiff<cr>
nnoremap <leader>gg :Gcommit -v<cr>
let g:EditorConfig_exclude_patterns = ['fugitive://.*', '.git/.*']

" Notes: (plugin)
let g:notes_directories = ['~/Dropbox/Documents/notes/']
let g:notes_title_sync = 'no'

" Syntax Plugins:
let g:jsx_ext_required = 0
let g:elm_format_autosave = 1

" CtrlP: (plugin)
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_extensions = ['tag']
let g:ctrlp_types = ['fil', 'mru', 'buf']

" UltiSnips: (plugin)
" g:UltiSnipsSnippetsDir = "~/.dotfiles/"

" Use desert as default colorscheme, molokai if installed
silent! colorscheme desert
silent! colorscheme molokai

" }}}
" vim: foldmethod=marker
