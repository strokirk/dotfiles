" Plugin List: {{{
call plug#begin('~/.config/vim-plugged')

" New Or Evaluating: {{{
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    Plug 'mhinz/vim-signify'
    " Plug 'liuchengxu/vista.vim' | " Viewer for LSP tags
    Plug 'mgedmin/python-imports.vim'
    " Plug 'rizzatti/dash.vim'
    Plug 'Lokaltog/vim-easymotion'
    Plug 'jremmen/vim-ripgrep'
    Plug 'kana/vim-textobj-entire'
    Plug 'kana/vim-textobj-user'
    " Plug 'michaelb/sniprun'
    Plug 'terryma/vim-expand-region'
    Plug 'mg979/vim-visual-multi'

    " Used for running jobs in lua
    Plug 'nvim-lua/plenary.nvim'
    " Actual plugin
    Plug 'tjdevries/apyrori.nvim'
" }}}

" Visual: {{{
    " Plug 'bling/vim-airline'
    Plug 'machakann/vim-highlightedyank'
" }}}

" AutoCompletion: {{{
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'davidhalter/jedi-vim',    { 'for': 'python' }
    " Plug 'zxqfl/tabnine-vim'   | " AI Based Autocompletion
    " Plug 'zchee/deoplete-jedi'
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" }}}

" Syntax And Filetype: {{{
    Plug 'sheerun/vim-polyglot'
    Plug 'ElmCast/elm-vim',           { 'for': 'elm'       }
    Plug 'cespare/vim-toml',          { 'for': 'toml'      }
    Plug 'dleonard0/pony-vim-syntax', { 'for': 'pony'      }
    Plug 'google/vim-jsonnet',        { 'for': 'jsonnet'   }
    Plug 'pangloss/vim-javascript'    | Plug 'mxw/vim-jsx'
    Plug 'plasticboy/vim-markdown',   { 'for': 'markdown'  }
    Plug 'rust-lang/rust.vim',        { 'for': 'rust'      }
    Plug 'vim-scripts/fountain.vim',  { 'for': 'fountain'  }
    Plug 'alfredodeza/coveragepy.vim',{ 'for': 'python'    }
    Plug 'alfredodeza/pytest.vim',    { 'for': 'python'    }
    Plug 'tmhedberg/SimpylFold',      { 'for': 'python'    }
    Plug 'Glench/Vim-Jinja2-Syntax'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'chakrit/upstart.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'elixir-editors/vim-elixir'
    Plug 'fatih/vim-hclfmt'
    Plug 'gutenye/json5.vim'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'robbles/logstash.vim'
    Plug 'tmux-plugins/vim-tmux'
    Plug 'tpope/vim-git'
    Plug 'vim-scripts/nginx.vim'
" }}}

" Notetaking: {{{
    Plug 'vimoutliner/vimoutliner' | " Uses a custom syntax vaguely similar to org-mode
    Plug 'junegunn/vim-journal'
" }}}

" Color: {{{
    Plug 'challenger-deep-theme/vim'
    Plug 'tomasr/molokai'
" }}}

" Good: {{{
    Plug 'SirVer/ultisnips'                | Plug 'honza/vim-snippets'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'fcpg/vim-kickfix'
    Plug 'jiangmiao/auto-pairs'
    Plug 'xolox/vim-misc'
    Plug 'FooSoft/vim-argwrap'             | " Adds :ArgWrap, which 'unfolds' lists and arguments
    Plug 'PeterRincker/vim-argumentative'  | " Adds arguments manipulations with <, [, a,
    Plug 'djoshea/vim-autoread'            | " Makes autoread actually work
    Plug 'jeetsukumaran/vim-gazetteer'     | " Manages tag finding for ctrl-p (use gz)
    Plug 'romainl/vim-qf'                  | " Add quickfix manipulation commands and mappings
    Plug 'sjl/clam.vim'                    | " Easily run Shell commands with :Clam
    Plug 'tpope/vim-eunuch'                | " Adds :Remove, :Move and other useful file management commands
    Plug 'wellle/targets.vim'              | " Add more text objects, like vi' or viq
    " NOTE: Lazy-load vim-characterize so it only loads it's big emoji database when needed
    Plug 'tpope/vim-characterize', { 'on': ['<Plug>(characterize)'] }
" }}}

" Excellent: {{{
    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'majutsushi/tagbar'
    Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
" }}}


" Essential: {{{
    " Plug 'airblade/vim-gitgutter'
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
    Plug 'haya14busa/vim-asterisk' | " Adds z* anv x_* mappings. 🔍️
    Plug 'benekastah/neomake'
    Plug 'sbdchd/neoformat'                | " Adds :Neoformat, which formats selected text
" }}}

" ShouldBeBuiltin: {{{
    Plug 'tpope/vim-surround'              | " Adds mappings for changing 'surrounding' characters, like ds( ...
    Plug 'michaeljsmith/vim-indent-object' | " Adds ii ai aI indent-based text objects
" }}}

call plug#end()
" }}}

" Plugin Options: {{{

" You may want to put this within a python only part of your config.
nmap <leader>i <plug>ApyroriInsert

let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier', 'coc-python']

" KickFix: (plugin) Disable Zebra striping in Quickfix window
let g:kickfix_zebra = 0

" ArgWrap: FooSoft/vim-argwrap
nnoremap <leader>a :ArgWrap<cr>

" ArgWrap:
nmap ga <Plug>(characterize)

" Signify:
nmap [g <plug>(signify-prev-hunk)
nmap ]g <plug>(signify-next-hunk)

" Neomake: (plugin)
au BufWritePost * Neomake
au BufRead .env NeomakeDisableBuffer
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_enabled_makers = ["python", "flake8", "mypy"]

" Emmet: (Plugin)
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Tagbar: (Plugin)
nnoremap <F2> :TagbarToggle<cr>
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'm:modules:1',
        \ 'O:OTP callbacks',
        \ 't:tests',
        \ 'f:functions (public)',
        \ 'g:functions (private)',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 's:structs',
        \ 'p:protocols',
        \ 'r:records',
        \ 'T:types'
    \ ]
\ }
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:H1',
        \ 'i:H2',
        \ 'k:H3'
    \ ],
\ 'sort' : 0,
\ }
let g:airline#extensions#tagbar#enabled = 0

" Asterisk: (Plugin)
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

" Jedi: (Plugin)
let g:jedi#goto_command = ''       | " This competes with my <leader>d mapping
let g:jedi#goto_stubs_command = '' | " This competes with my <leader>s mapping
let g:jedi#popup_on_dot = 0        | " Jedi tends to freeze vim while loading the autocompletions
let g:deoplete#enable_at_startup = 1

" Rg: (plugin) (use AltGr to quickly search)
nnoremap º :Rg --ignore tests --ignore __tests__ "\b<c-r>=expand("<cword>")<cr>\b"
xnoremap º "ly:Rg --ignore tests --ignore __tests__ --fixed-strings "<c-r>l"
nnoremap ª :Rg "\b<c-r>=expand("<cword>")<cr>\b"
xnoremap ª "ly:Rg --fixed-strings "<c-r>l"
cabbrev rg Rg

xnoremap <leader>s :sort<cr>
xnoremap <leader>f "ly:Rg --fixed-strings "<c-r>l"<cr><c-w>p
nnoremap <leader>f :Rg "\b<c-r>=expand("<cword>")<cr>\b"

" ArgWrap:
let g:argwrap_tail_comma=1

" NERDTree: (plugin)
nnoremap <C-T> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>
command! NTF NERDTreeFind
cabbrev ntf NTF
let g:NERDTreeIgnore=['\.cover$', '\.pyc$', '\~$', '__pycache__', 'node_modules']

" Fugitive: (plugin)
nnoremap <F4> :Git blame<cr>
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
let g:ctrlp_extensions = ['line', 'tag']
let g:ctrlp_types = ['fil', 'buf']
let g:ctrlp_show_hidden = 0

" QF: (plugin)"
nmap <leader>q <Plug>(qf_qf_toggle_stay)
nmap <leader>l <Plug>(qf_loc_toggle_stay)

" Pytest: (plugin)
autocmd Filetype python nnoremap <buffer> <leader>t :Pytest file<CR>
autocmd Filetype python nnoremap <buffer> <leader>tc :Pytest class<CR>

" UltiSnips: (plugin)
" g:UltiSnipsSnippetsDir = "~/.dotfiles/"


" EasyAlign: (plugin)
xmap <leader>0 <Plug>(EasyAlign)

" JsonNet: (plugin)
let g:jsonnet_fmt_options = ' --string-style d '

let g:neoformat_enabled_javascriptreact = ['prettier']
let g:neoformat_enabled_typescriptreact = ['prettier']
let g:neoformat_javascriptreact_prettier = {'exe': 'prettier', 'stdin': 1, 'args': ['--stdin', '--stdin-filepath', '"%:p"', '--parser', 'typescript']}
let g:neoformat_typescriptreact_prettier = {'exe': 'prettier', 'stdin': 1, 'args': ['--stdin', '--stdin-filepath', '"%:p"', '--parser', 'typescript']}

let g:neoformat_enabled_json5 = ['prettier']
let g:neoformat_json5_prettier = {
  \ 'exe': 'prettier',
  \ 'args': ['--stdin', '--stdin-filepath', '"%:p"', '--parser', 'json5'],
  \ 'stdin': 1,
  \ 'no_append': 1,
  \ }

" }}}

" vim: foldmethod=marker
