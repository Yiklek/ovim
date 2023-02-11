local K = {}

local km = require "ovim.misc.keymap"
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local display = km.display
local opts = {
  display = {
    enable = true,
  },
  map = {
    noremap = true,
    silent = true,
    nowait = true,
  },
}
function K.telescope()
  return {
    ["n|<leader>st"] = display "Telescope",
    ["n|<leader>st<space>"] = map_cr("Telescope", opts),
    ["n|<leader>sty"] = map_cr("Telescope frecency", opts),
    ["n|<leader>stc"] = map_cr("Telescope commands", opts),
    ["n|<leader>stb"] = map_cr("Telescope buffers", opts),
    ["n|<leader>sts"] = map_cr("Telescope live_grep", opts),
    ["n|<leader>stS"] = map_cr("Telescope grep_string", opts),
    ["n|<leader>stf"] = map_cr("Telescope find_files", opts),
    ["n|<leader>sto"] = map_cr("Telescope oldfiles", opts),
    ["n|<leader>stu"] = map_cr("Telescope undo", opts),
  }
end

return K
