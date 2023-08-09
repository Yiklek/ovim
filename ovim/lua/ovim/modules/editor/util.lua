local M = {}
local km = require("ovim.core.keymap")
function M.remove_space()
  try {
    function()
      local ignore_filetypes = require("ovim.config").modules.editor.remove_space.ignore_filetypes
      if ignore_filetypes == nil or vim.fn.index(ignore_filetypes, vim.o.ft) then
        vim.cmd([[silent! %s/\s\+$//]])
        vim.cmd([[silent! %s/\(\s*\n\)\+\%$//]])
      end
    end,
  }
end

return M
