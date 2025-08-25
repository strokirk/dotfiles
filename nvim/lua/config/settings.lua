local utils = require("utils")
local Autocmd = utils.Autocmd

vim.o.updatetime = 100

-- Whitespace options is mainly based on Python/Django
vim.o.expandtab = true -- Make spaces not tabs! Tabs runs you out!
vim.o.textwidth = 120
-- Python development teaches you that 4 = good for indention
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Commented out due to https://github.com/neovim/neovim/issues/29047
-- vim.o.ttimeoutlen = -1 -- Fixes input issues when nvim is run in tmux

vim.o.mouse = "a" -- Enable mouse in all modes
vim.o.hidden = true -- Allow unsaved buffers to be backgrounded
vim.o.path = "**" -- Makes :find work better. Thanks romainl!
vim.opt.wildignore = { "*.pyc", "*~", "*.mo" }

-- Vim-based backup is more trouble than it's worth
vim.o.backup = false
vim.o.wb = false
vim.o.swapfile = false

vim.o.inccommand = "nosplit" -- Shows the effects of a command incrementally, as you type
vim.o.smartindent = false -- Python comments (#) can't handle smartindent
vim.o.tags = "./tags;,tags,./.git/tags,.git/tags"
vim.opt.formatoptions:append("l") -- Formatoptions: Don't break already long lines

-- CSS selector names are usually in snake-case
vim.opt.iskeyword:append("-")

-- Visual:
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.number = true -- Turn n line number
vim.o.ruler = true -- Shows line & column number
vim.o.scrolloff = 5 -- Always keep 7 lines above and below cursor
vim.o.showcmd = true -- Shows the half-finished command when typed
vim.o.showmatch = true -- Show matching brackets when cursor is over one of them
vim.o.foldlevel = 999
vim.wo.foldtext = "v:lua.vim.treesitter.foldtext()" -- Use syntax highlighting in fold summaries

vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.inccommand = "nosplit"

-- Line Wrapping:
vim.opt.cpoptions = table.concat({
  "n", -- n: Use 'number' column for wrapped text
  "B", -- B: Include blackslashes verbatim in mappings
  "F", -- F: Set buffer filename when writing a file
})
vim.o.linebreak = true -- Makes vim try to wrap lines at non-word characters
vim.o.showbreak = "+++" -- Text to put before wrapped text
vim.o.wrap = true
-- Some slightly more interesting listchars
vim.o.listchars = "tab:▸\\ ,trail:·,extends:❯,precedes:❮,nbsp:×,eol:¬"
vim.o.statusline = "[%F]%h%r%m\\ Buf-%n%=%c,%l/%L\\ [%p%%]"

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable python provider - it adds ~800ms to startup time
vim.g.loaded_python3_provider = 0

Autocmd.TextYankPost({ pattern = "*", callback = function() vim.highlight.on_yank({ timeout = 350 }) end })

utils.editorconfig_override({ filetype = "gitcommit", prop = "max_line_length", value = "72" })
utils.FiletypeConversion({
  [".babelrc"] = "json5.json",
  ["tsconfig.json"] = "json5.json",
  ["Dockerfile.*"] = "dockerfile",
  ["poetry.lock"] = "toml",
})
utils.FiletypeSettings({
  ["gitcommit"] = function() vim.wo.spell = true end,
  ["markdown"] = function() vim.bo.textwidth = 73 end,
  ["lua"] = function() vim.wo.wrap = false end,
  ["vue"] = function()
    vim.bo.formatprg = "prettier --parser vue"
    vim.bo.commentstring = "// %s"
  end,
  ["json"] = function() vim.bo.formatprg = "prettier --parser json" end,
  ["json5"] = function() vim.bo.formatprg = "prettier --parser json5" end,
})
