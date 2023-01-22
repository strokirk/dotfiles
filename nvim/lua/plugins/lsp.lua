return {
	{
		"folke/neodev.nvim", -- LSP configuration for Neovim config code
		config = function() require("neodev").setup() end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",

			-- Snippets
			"L3MON4D3/LuaSnip",
			-- Snippet Collection (Optional)
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local lsp = require("lsp-zero")
			lsp.preset("recommended")
			lsp.nvim_workspace()
			lsp.setup()
			vim.keymap.set("n", "<F9>", vim.lsp.buf.format, {})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/playground",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			})
		end,
	},
}