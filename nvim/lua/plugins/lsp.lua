local utils = require("utils")

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
  end,
})
-- The schemaStore contains all kinds of outdated schemas, so disable it
vim.lsp.config("yamlls", { settings = { yaml = { schemaStore = { enable = false } } } })

local plugins = utils.PluginList()

plugins.add({
  { "folke/lazydev.nvim", ft = "lua", opts = {} }, -- LSP config for Neovim
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "ruff" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    -- Autocompletion
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = { preset = "enter" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Needs the tree-sitter CLI; no-op once installed. Bundled-in-nvim languages (lua, c, vim, markdown, ...)
      -- are listed too: this plugin's queries override nvim's, so the parser must match them.
      require("nvim-treesitter").install({
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "javascript",
        "python",
        "rust",
        "typescript",
        "zig",
        "rst",
      })
      utils.Autocmd.Filetype({
        pattern = "*",
        callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
        desc = "Treesitter highlighting",
      })
      utils.Autocmd.BufRead({
        pattern = "*",
        callback = function(ev)
          local buf_name = vim.api.nvim_buf_get_name(ev.buf)
          local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
          -- Only enable folding for files smaller than 256 KB
          if file_size < 256 * 1024 then
            vim.o.foldmethod = "expr"
            vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.o.foldenable = false
          end
        end,
        desc = "Enable folding via Treesitter",
      })
    end,
  },
})

return plugins.values
