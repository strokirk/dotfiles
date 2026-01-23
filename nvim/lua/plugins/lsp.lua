local utils = require("utils")

-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#diagnosticTag
local DiagnosticTagUnnecessary = 1

local filterPyrightUnusedDiagnostics = function(a, params, client_id, c, config)
  params.diagnostics = vim.tbl_filter(function(diagnostic)
    -- Only filter out Pyright
    if diagnostic.source ~= "Pyright" then return true end
    if diagnostic.tags and diagnostic.tags[1] == DiagnosticTagUnnecessary then return false end
    return true
  end, params.diagnostics)
  vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
end

local luasnipConfig = function()
  -- Load my local snippets as well
  local ls = require("luasnip")
  require("luasnip.loaders.from_snipmate").lazy_load()
  pcall(function() require("telescope").load_extension("luasnip") end)
  -- Press <Tab> on selected text to replace it with the snippet, potentially reusing the content
  ls.config.set_config({ enable_autosnippets = true, store_selection_keys = "<Tab>" })
  vim.keymap.set(
    "i",
    "<Tab>",
    function() return ls.expand_or_locally_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>" end,
    { silent = true, expr = true, remap = true }
  )
  vim.keymap.set("i", "<S-Tab>", function() ls.jump(-1) end, { silent = true })
  vim.keymap.set("s", "<Tab>", function() ls.jump(1) end, { silent = true })
  vim.keymap.set("s", "<S-Tab>", function() ls.jump(-1) end, { silent = true })
end

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
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(filterPyrightUnusedDiagnostics, {})
vim.lsp.config("pyright", {
  before_init = function(_, config)
    if vim.env.VIRTUAL_ENV then config.settings.python.pythonPath = vim.env.VIRTUAL_ENV .. "/bin/python" end
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
      ensure_installed = { "pyright", "ruff" },
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
    dependencies = {
      "nvim-treesitter/playground",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          },
        },
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
