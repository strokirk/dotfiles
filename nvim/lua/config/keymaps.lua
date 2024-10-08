-- Mappings: {{{
local utils = require("utils")
local Autocmd = utils.Autocmd

-- (utils for this file)
local command = function(name, command, opts) vim.api.nvim_create_user_command(name, command, opts or {}) end
local abbrev = function(lhs, rhs) vim.cmd.cabbrev({ args = { lhs, rhs } }) end

-- Use <space> as <leader>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Repeat 'default' mapping (Essential, instead of Enter Ex mode)
vim.keymap.set("n", "Q", "@q")

-- Quick window resizing. Thanks kaldrenon!
-- Double-tapping feels a bit quicker than a chord.
vim.keymap.set("n", "++", "<C-w>+")
vim.keymap.set("n", "--", "<C-w>-")

-- Move down a screen line if the actual line is wrapped.
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Select line characterwise (without whitespace)
vim.keymap.set("n", "vv", "^vg_")

-- Select the entire file
vim.keymap.set("n", "VF", "VggoG")

-- I never use normal _, but g_ is often more useful than $
vim.keymap.set("n", "_", "g_")

-- I never uSe HML, so easier line navigation is nice
vim.keymap.set("n", "L", "g_")
vim.keymap.set("x", "L", "g_")
vim.keymap.set("n", "H", "^")
vim.keymap.set("x", "H", "^")

-- Bracket Navigation: Quickfix, Buffers, Arguments, Tags
vim.keymap.set("n", "[q", ":cprev<cr>")
vim.keymap.set("n", "]q", ":cnext<cr>")
vim.keymap.set("n", "[l", ":lprev<cr>")
vim.keymap.set("n", "]l", ":lnext<cr>")
vim.keymap.set("n", "[b", ":bprev<cr>")
vim.keymap.set("n", "]b", ":bnext<cr>")
vim.keymap.set("n", "[a", ":prev<cr>")
vim.keymap.set("n", "]a", ":next<cr>")
vim.keymap.set("n", "[t", ":pop<cr>")
vim.keymap.set("n", "]t", ":tag<cr>")

-- Move Lines (Thanks LazyVim!)
vim.keymap.set("n", "√", ":m .+1<CR>==", { desc = "Move down" })
vim.keymap.set("v", "√", ":m '>+1<CR>gv=gv", { desc = "Move down" })
vim.keymap.set("i", "√", "<Esc>:m .+1<CR>==gi", { desc = "Move down" })
vim.keymap.set("n", "ª", ":m .-2<CR>==", { desc = "Move up" })
vim.keymap.set("v", "ª", ":m '<-2<CR>gv=gv", { desc = "Move up" })
vim.keymap.set("i", "ª", "<Esc>:m .-2<CR>==gi", { desc = "Move up" })

-- I don't really use [count]go (go to byte #), tags are more useful to me
vim.keymap.set("n", "go", "g<c-]>")
vim.keymap.set("x", "go", "g<c-]>")

vim.keymap.set("n", "<leader>go", "<c-w>g<c-]><c-w>T")
vim.keymap.set("n", "<leader>gf", "<c-w>gf")

-- Yank entire line / to end of line, without EOL, like D
vim.keymap.set("n", "Y", 'yg_:echo "Yanked: ".@"<cr>')

-- Make vim command mode more like readine
vim.keymap.set("c", "<c-a>", "<home>")

-- This is a great shortcut for fast redrawing and resetting highlight.
vim.keymap.set("n", "<C-l>", function()
  vim.cmd("nohlsearch")
  vim.cmd("diffupdate")
  vim.cmd("mode")
  -- Close floating windows
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then -- is_floating_window?
      vim.api.nvim_win_close(win, false) -- do not force
    end
  end
end, { silent = true })

-- Utilize Swedish Characters:

-- For comfort, remap Swedish keys to oft-used AltGr characters.
-- (Technically these are placed at å and ¨ on American keyboards.)
vim.keymap.set("n", "ö", "[", { remap = true })
vim.keymap.set("n", "Ö", "{", { remap = true })
vim.keymap.set("n", "ä", "]", { remap = true })
vim.keymap.set("n", "Ä", "}", { remap = true })
vim.keymap.set("n", "öö", "[[", { remap = true })
vim.keymap.set("n", "ää", "]]", { remap = true })
vim.keymap.set("n", "]]", "]q", { remap = true })
vim.keymap.set("n", "[[", "[q", { remap = true })

vim.keymap.set("i", "¨", "/", { remap = true })
vim.keymap.set("n", "¨", "/", { remap = true })
vim.keymap.set("c", "¨", "/", { remap = true })

-- Quick access to temporary mappings
vim.keymap.set("n", "§", ":nmap §")

-- Follow tags in helpfiles with <CR> or <F1>
vim.keymap.set("n", "<F1>", "<esc>", { remap = true })
vim.cmd("autocmd Filetype help nnoremap <buffer> <cr> <c-]>")
vim.cmd("autocmd Filetype help nnoremap <buffer> <F1> <c-]>")

-- Quicksave
vim.keymap.set("n", "<F8>", ":w<cr>")
vim.keymap.set("i", "<F8>", "<c-o>:w<cr>")
vim.keymap.set("n", "<F20>", ":Gw<cr>")
vim.keymap.set("i", "<F20>", "<c-o>:Gw<cr>")
-- Use <F12> and <S-F12> to toggle wrapping and listing
vim.keymap.set("n", "<F12>", ":set wrap!<cr>")
vim.keymap.set("n", "<F24>", ":set list!<cr>")
-- <F11> to set colorcolumn based on Github maxwidth
vim.keymap.set("n", "<F11>", ":set colorcolumn=111<cr>")

-- Easier System Clipboard Interaction:
vim.keymap.set("n", ",p", '"+p')
vim.keymap.set("n", ",P", '"+P')
vim.keymap.set("x", ",p", '"+p')
vim.keymap.set("x", ",P", '"+P')
vim.keymap.set("x", "åy", '"+y')
vim.keymap.set("x", "gy", '"+y')
vim.keymap.set("x", ",y", '"+y')
vim.keymap.set("x", "<leader>y", '"+y')
vim.keymap.set("x", "<leader>p", '"+p')
vim.keymap.set("x", "<leader>P", '"+P')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')

-- QuickPaste: Nice default-paste shortcut: þ (AltGr-p)
-- noremap  þ "0p
-- noremap! þ <c-r>0
-- noremap  ,þ "+p
-- noremap! ,þ <c-r>+
-- map  π þ
-- map! π þ

-- Break insert undo-chain before deleting whole line
vim.keymap.set("i", "<C-U>", "<C-G>u<C-U>")
-- Keep flags when repeating last substitute command.
vim.keymap.set("n", "&", ":&&<CR>")
vim.keymap.set("x", "&", ":&&<CR>")

-- Unload current buffer and go to previous. (Thanks Mud)
-- Useful for keeping the window open, which :bd<cr> doesn't.
-- command! CloseBuffer bp <bar> bd #
vim.keymap.set("n", "<leader>d", ":CloseBuffer<cr>")

-- Quick :sort
vim.keymap.set("x", "<leader>s", ":sort<cr>")

-- Abbreviations:
-- Quick :copen. Abbreviation avoids mistyping it as :copy
-- Techically :cw might be faster, but I often tend to use copen when I shouldn't
abbrev("cop", "copen")

-- Just let me quit, darnit!
vim.keymap.set("n", "ZQ", ":qa!<cr>")
abbrev("Q", "q")
abbrev("Q", "q")
abbrev("W", "w")
abbrev("Qa", "qall")
abbrev("Wq", "wq")
abbrev("Qall", "qall")
abbrev("Wall", "wall")
abbrev("Wqall", "wqall")

-- Copy current filename
command("CopyFilename", 'let @"=@% | let @+=@% | let @*=@%')
vim.keymap.set("n", "<leader>yf", ":CopyFilename<cr>")
vim.keymap.set("n", "Ç", ":CopyFilename<cr>")

-- Clear open help panes like quickfix and similar
command("Clear", "silent tabdo NERDTreeClose | lcl | ccl")

-- EmptyRegisters: Taken from https://stackoverflow.com/a/39348498
command("EmptyRegisters", "call EmptyRegisters()")
vim.cmd([[function! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfunction]])

-- Autocommands: {{{
vim.cmd("au FileType qf nnoremap <buffer> t <C-W><Enter><C-W>T")
vim.cmd("au Filetype sql,mysql nmap <buffer> <F5> vip<F5>")
vim.cmd("au Filetype sql,mysql xnoremap <buffer> <F5> :'<,'>Clam mysql --table<cr>gg<c-w>h")
vim.cmd("au Filetype prql nnoremap <buffer> ! vip:Clam prqlc compile<cr>:setf sql<cr><c-w>h")

-- }}} Autocommands

-- Pipe Vim Command Output To Tab: {{{
-- From the vim wikia
vim.cmd([[
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
]])
-- }}} Pipe Vim Command Output To Tab

-- Create Missing Directories On Save: {{{
vim.cmd([[
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
]])
-- }}} Create Missing Directories On Save

-- CompareQuickfixEntries: {{{
vim.cmd([[
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
]])
-- }}}

vim.keymap.set("n", "<F3>", ":NeoTreeReveal<cr>")
vim.keymap.set("n", "<C-T>", ":NeoTreeFocusToggle<cr>")

-- Easily edit Vim config
local tabdropcfg = function(filename)
  return function()
    vim.cmd("tab drop " .. vim.fn.stdpath("config") .. "/" .. filename)
    vim.cmd.tcd(vim.fn.stdpath("config"))
  end
end
vim.keymap.set("n", "<leader>,,", tabdropcfg("init.lua"), { desc = "Edit init.vim" })
vim.keymap.set("n", "<leader>,c", tabdropcfg("init.lua"), { desc = "Edit init.vim" })
vim.keymap.set("n", "<leader>,p", tabdropcfg("lua/plugins/init.lua"), { desc = "Edit plugins" })
vim.keymap.set("n", "<leader>,m", tabdropcfg("lua/config/keymaps.lua"), { desc = "Edit mappings" })
vim.keymap.set("n", "<leader>,k", tabdropcfg("lua/config/keymaps.lua"), { desc = "Edit mappings" })
vim.keymap.set("n", "<leader>,s", tabdropcfg("lua/config/settings.lua"), { desc = "Edit settings" })
vim.keymap.set("n", "<leader>,l", tabdropcfg("lua/plugins/testing.lua"), { desc = "Edit temporary settings" })
vim.keymap.set("n", "<leader>,w", function() vim.cmd("tab drop .nvim.lua") end, { desc = "Edit workspace settings" })

Autocmd.Filetype({
  pattern = "lua",
  callback = function()
    -- Open quoted text in Github as a repo
    vim.keymap.set("n", "<leader>K", ":silent !open https://github.com/<cfile><cr>", { desc = "Open Github" })
  end,
})

Autocmd.Filetype({
  pattern = "requirements",
  callback = function()
    -- Open quoted text in PyPI
    vim.keymap.set("n", "<leader>K", ":silent !open https://pypi.org/project/<cword>/<cr>", { desc = "Open PyPI" })
  end,
})

-- Lazy:
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")

-- Fugitive:
vim.keymap.set("n", "<leader>gb", ":Git blame<cr>")
vim.keymap.set("n", "<leader>gw", ":Gw<cr>")
vim.keymap.set("n", "<leader>ga", ":Gdiff<cr>")
vim.keymap.set("n", "<leader>gg", ":Gcommit -v<cr>")
vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", ".git/.*" }

vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>")
vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>")
vim.keymap.set("n", "ög", "<cmd>Gitsigns prev_hunk<cr>")
vim.keymap.set("n", "äg", "<cmd>Gitsigns next_hunk<cr>")

-- ArgWrap: FooSoft/vim-argwrap
vim.keymap.set("n", "<leader>a", ":ArgWrap<cr>")

-- QF:
vim.keymap.set("n", "<leader>q", "<Plug>(qf_qf_toggle_stay)", { remap = true, desc = "Toggle quickfix window" })
vim.keymap.set("n", "<leader>l", "<Plug>(qf_loc_toggle_stay)", { remap = true, desc = "Toggle location list window" })

vim.keymap.set("n", "<leader>x", "<cmd>TroubleToggle<cr>")
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")

vim.keymap.set("n", "<leader>w", "viw")
vim.keymap.set("n", "<leader>W", "viW")
