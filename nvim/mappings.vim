" Mappings: {{{

" Use <space> as <leader>
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

" I never uSe HML, so easier line navigation is nice
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
nnoremap <F20> :Gw<cr>
inoremap <F20> <c-o>:Gw<cr>
" Use <F12> and <S-F12> to toggle wrapping and listing
nnoremap <F12> :set wrap!<cr>
nnoremap <F24> :set list!<cr>
" <F11> to set colorcolumn based on Github maxwidth
nnoremap <F11> :set colorcolumn=111<cr>

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

" Quick filter:
nnoremap == :Neoformat<cr>
au Filetype python nnoremap <buffer> <F9> :Neoformat black<cr>
au Filetype typescript nnoremap <buffer> <F9> :Neoformat prettier<cr>

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


" Commands: {{{
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
function! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    Trim
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType fountain let b:noStripWhitespace=1
" }}}


" Autocommands: {{{ "
au FileType qf nnoremap <buffer> t <C-W><Enter><C-W>T

au Filetype python nnoremap <buffer> <leader>to viwo<esc>iOptional[<esc>ea]<esc>

au Filetype python nnoremap <buffer> gp yiwoprint("<c-r>0: ", <c-r>0)  # XXX<esc>
au Filetype python xnoremap <buffer> gp yoprint("<c-r>0: ", <c-r>0)  # XXX<esc>
au Filetype python xnoremap <buffer> gpi yofrom icecream import ic; ic(<c-r>0)  # XXX<esc>
au Filetype javascript nnoremap <buffer> gp yiwoconsole.log("<c-r>0: ", <c-r>0)  // XXX<esc>
au Filetype javascript xnoremap <buffer> gp yoconsole.log("<c-r>0: ", <c-r>0)  // XXX<esc>
au Filetype elixir nnoremap <buffer> gp yiwoLogger.info("<c-r>0: #{inspect <c-r>0}")<esc>
au Filetype elixir xnoremap <buffer> gp yoLogger.info("<c-r>0: #{inspect <c-r>0}")<esc>

au Filetype python command! -buffer -range=% Isort :<line1>,<line2>! isort -
au Filetype python command! -buffer PrintWrap normal! Iprint(<esc>A<c-v>)<esc>
au Filetype python command! -buffer Breakpoint call append(line('.')-1, repeat(' ', indent(prevnonblank(line('.')))).'import ipdb; ipdb.set_trace()  # XXX BREAKPOINT')
au Filetype python nnoremap <buffer> <leader>b :Breakpoint<cr>
au Filetype python nnoremap <buffer> <leader>p :PrintWrap<cr>
au Filetype python nnoremap <buffer> <leader>s :Isort<cr>
au Filetype sql,mysql setl formatprg=sqlformat\ -r\ -
au Filetype sql,mysql setl equalprg=sqlformat\ -r\ -
au Filetype sql,mysql nmap <buffer> <F5> vip<F5>
au Filetype sql,mysql xnoremap <buffer> <F5> :'<,'>Clam mysql --table<cr>gg<c-w>h
au Filetype vim setlocal foldmethod=marker
au Filetype scss setl equalprg=prettier\ --parser=scss
au Filetype python setl equalprg=autopep8\ -\ --max-line-length\ 119\ -a\ --ignore\ E309\ --ignore\ E731
au Filetype javascript,javascript.jsx setl suffixesadd+=.js,.jsx,.es6.js,.ts,.tsx
au Filetype javascript,javascript.jsx setl foldmethod=syntax
au Filetype elixir setl foldmethod=syntax
au Filetype scss setl foldmethod=marker foldmarker={,}
autocmd BufRead .babelrc,tsconfig.json setfiletype json5.json
autocmd BufRead Dockerfile.* setfiletype dockerfile
autocmd BufRead poetry.lock setfiletype toml
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

" s:ScratchRead {{{
function! s:ScratchRead(cmd, ...)
    if bufwinnr('*scratch*') | bw *scratch* | endif
    Scratch | set previewwindow
    exe '0read !'.a:cmd
    execute "normal \<c-w>p"
endfunction
command! -nargs=+ ScratchRead call s:ScratchRead("<args>")
" }}}

" s:Create Missing Directories On Save: {{{ "
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" }}} s:Create Missing Directories On Save: "

" s:CompareQuickfixEntries {{{
function! s:CompareQuickfixEntries(i1, i2)
  if bufname(a:i1.bufnr) == bufname(a:i2.bufnr)
    return a:i1.lnum == a:i2.lnum ? 0 : (a:i1.lnum < a:i2.lnum ? -1 : 1)
  else
    return bufname(a:i1.bufnr) < bufname(a:i2.bufnr) ? -1 : 1
  endif
endfunction
function! s:SortUniqQFList()
  let sortedList = sort(getqflist(), 's:CompareQuickfixEntries')
  let uniqedList = []
  let last = ''
  for item in sortedList
    let this = bufname(item.bufnr) . "\t" . item.lnum
    if this !=# last
      call add(uniqedList, item)
      let last = this
    endif
  endfor
  call setqflist(uniqedList)
endfunction
autocmd! QuickfixCmdPost * call s:SortUniqQFList()
" }}}
