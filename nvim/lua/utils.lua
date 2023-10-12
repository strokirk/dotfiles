local M = {}

-- Override editorconfig
M.editorconfig_override = function(opts)
  require("editorconfig").properties[opts.prop] = function(_, value)
    if vim.bo.filetype == opts.filetype then
      return opts.value
    else
      return value
    end
  end
end

-- Easily make autocommands
local create_au = vim.api.nvim_create_autocmd
M.Autocmd = {
  BufRead = function(opts) create_au("BufRead", opts) end,
  Filetype = function(opts) create_au("Filetype", opts) end,
  TextYankPost = function(opts) create_au("TextYankPost", opts) end,
  ConvertFiletype = function(pattern, filetype)
    create_au("BufRead", {
      pattern = pattern,
      callback = function() vim.api.nvim_cmd({ cmd = "setfiletype", args = { filetype } }, {}) end,
    })
  end,
}

M.List = function()
  local values = {}
  local skip = function(list) end
  local add = function(list) vim.list_extend(values, list) end
  return { skip = skip, add = add, values = values }
end

return M
