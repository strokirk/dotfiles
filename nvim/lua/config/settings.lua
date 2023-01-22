vim.o.updatetime = "100"

-- Whitespace options is mainly based on Python/Django
vim.o.expandtab = true -- Make spaces not tabs! Tabs runs you out!
vim.o.textwidth = "120"
-- Python development teaches you that 4 = good for indention
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.mouse = "a" -- Enable mouse in all modes
vim.o.ttimeoutlen = -1 -- Fixes input issues when nvim is run in tmux
vim.o.hidden = true -- Allow unsaved buffers to be backgrounded
vim.o.path = "**" -- Makes :find work better. Thanks romainl!
vim.opt.wildignore = { "*.pyc", "*~", "*.mo" }

-- Vim-based backup is more trouble than it's worth
vim.o.backup = false
vim.o.wb = false
vim.o.swapfile = false

vim.o.inccommand = "nosplit" -- Shows the effects of a command incrementally, as you type
vim.o.nosmartindent = true -- Python comments (#) can't handle smartindent
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
vim.o.foldlevel = "999"

vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.inccommand = "nosplit"

-- Line Wrapping:
vim.o.cpoptions = "n" -- The 'number' column used for wrapped text
vim.o.linebreak = true -- Makes vim try to wrap lines at non-word characters
vim.o.showbreak = "+++" -- Text to put before wrapped text
vim.o.wrap = true
-- Some slightly more interesting listchars
vim.o.listchars = "tab:▸\\ ,trail:·,extends:❯,precedes:❮,nbsp:×,eol:¬"
vim.o.statusline = "[%F]%h%r%m\\ Buf-%n%=%c,%l/%L\\ [%p%%]"

local Autocmd = {
	BufRead = function(opts) vim.api.nvim_create_autocmd("BufRead", opts) end,
	Filetype = function(opts) vim.api.nvim_create_autocmd("Filetype", opts) end,
	ConvertFiletype = function(pattern, filetype)
		vim.api.nvim_create_autocmd("BufRead", {
			pattern = pattern,
			callback = function() vim.api.nvim_cmd({ cmd = "setfiletype", args = { filetype } }) end,
		})
	end,
}
Autocmd.Filetype({ pattern = "qf", callback = function() vim.cmd("setlocal nowrap") end })

-- Spelling: in git commit messages
Autocmd.BufRead({
	pattern = { "COMMIT_EDITMSG", "gitcommit" },
	callback = function()
		vim.bo.textwidth = 72
		vim.wo.spell = true
	end,
})

Autocmd.Filetype({ pattern = "yaml", callback = function() vim.wo.foldmethod = "indent" end })
Autocmd.Filetype({ pattern = "elixir", callback = function() vim.wo.foldmethod = "indent" end })
Autocmd.Filetype({ pattern = "markdown", callback = function() vim.bo.textwidth = 73 end })
Autocmd.Filetype({ pattern = "vim", callback = function() vim.wo.foldmethod = "marker" end })

Autocmd.ConvertFiletype(".babelrc", "json5.json")
Autocmd.ConvertFiletype("tsconfig.json", "json5.json")
Autocmd.ConvertFiletype("Dockerfile.*", "dockerfile")
Autocmd.ConvertFiletype("poetry.lock", "toml")
