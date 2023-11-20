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
}

function M.FiletypeConversion(mapping)
  for pattern, filetype in pairs(mapping) do
    create_au("BufRead", {
      pattern = pattern,
      callback = function() vim.api.nvim_cmd({ cmd = "setfiletype", args = { filetype } }, {}) end,
    })
  end
end

function M.FiletypeSettings(mapping)
  for pattern, callback in pairs(mapping) do
    create_au("Filetype", { pattern = pattern, callback = callback, desc = "Filetype Settings for " .. pattern })
  end
end

function M.PluginList()
  local values = {}
  local skip = function() end
  local add = function(list) vim.list_extend(values, list) end
  local configure = function(plugin_name, config)
    -- find plugin and merge the config table with the plugin
    for i, plugin in ipairs(values) do
      -- if plugin is a string, then it's the name of the plugin
      if plugin == plugin_name then
        values[i] = vim.tbl_extend("force", { plugin }, config)
        return
      end
      -- if plugin is a table, then the first element is the name of the plugin
      if plugin[1] == plugin_name then
        values[i] = vim.tbl_extend("force", plugin, config)
        return
      end
    end
  end
  return {
    add = add,
    skip = skip,
    values = values,
    configure = configure,
  }
end

return M
