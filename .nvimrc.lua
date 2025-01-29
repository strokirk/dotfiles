local utils = require("utils")

-- Enable autoformat for specific filetypes
utils.Autocmd.Filetype({
  pattern = { "lua" },
  callback = function() vim.b.enable_autoformat = true end,
  desc = "Enable autoformat for supported files",
})
