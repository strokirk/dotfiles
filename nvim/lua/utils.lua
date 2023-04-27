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

return M
