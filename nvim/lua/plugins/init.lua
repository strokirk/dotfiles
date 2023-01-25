-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Fugitive:
vim.keymap.set("n", "<F4>", ":Git blame<cr>")
vim.keymap.set("n", "<leader>gw", ":Gw<cr>")
vim.keymap.set("n", "<leader>ga", ":Gdiff<cr>")
vim.keymap.set("n", "<leader>gg", ":Gcommit -v<cr>")
vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", ".git/.*" }

-- ArgWrap: FooSoft/vim-argwrap
vim.keymap.set("n", "<leader>a", ":ArgWrap<cr>")

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function() vim.highlight.on_yank({ timeout = 350 }) end,
})

return {
	"mbbill/undotree",
	"isobit/vim-caddyfile",
	"monaqa/dial.nvim",
	"folke/trouble.nvim",
	"tomasr/molokai", -- Colorful colorscheme
	"tpope/vim-fugitive", -- Adds git integration with :Gblame and :Gwrite
	"folke/which-key.nvim",
	"FooSoft/vim-argwrap", -- Adds :ArgWrap, which 'unfolds' lists and arguments
	"tpope/vim-eunuch", -- Adds :Remove, :Move and other useful file management commands
	"tpope/vim-commentary", -- Adds gc, which toggles line comments on and off
	"michaeljsmith/vim-indent-object", -- Adds ii ai aI indent-based text objects
	"tpope/vim-surround", -- Adds mappings for changing 'surrounding' characters, like ds( ...
	"mg979/vim-visual-multi", -- Multicursor with <c-n>
	{ "nvim-lualine/lualine.nvim", opts = { options = { theme = "onedark" } } },
	{
		"goolord/alpha-nvim", -- Welcome Screen
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function() require("alpha").setup(require("alpha.themes.startify").config) end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"haya14busa/vim-asterisk", -- Adds z* anv x_* mappings. 🔍️
		config = function()
			vim.keymap.set("n", "*", "<Plug>(asterisk-z*)", { remap = true })
			vim.keymap.set("n", "#", "<Plug>(asterisk-z#)", { remap = true })
			vim.keymap.set("n", "g*", "<Plug>(asterisk-gz*)", { remap = true })
			vim.keymap.set("n", "g#", "<Plug>(asterisk-gz#)", { remap = true })
		end,
	},

	-- Lazy loaded
	{ "folke/twilight.nvim", cmd = "Twilight" }, -- Adds :Twilight, a code flashlight
	{ "mattn/emmet-vim", cmd = "Emmet" }, -- Adds :Emmet, a HTML boilerplate generator
	{ "junegunn/vim-easy-align", cmd = "EasyAlign" }, -- Adds :EasyAlign, that aligns columns of text
}
