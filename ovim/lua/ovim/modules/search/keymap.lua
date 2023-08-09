local K = {}

local km = require("ovim.core.keymap")
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
    ["n|<leader>s"] = display("Search (Telescope)"),
    ["n|<leader>sy"] = map_cr("Telescope frecency", opts),
    ["n|<leader>sc"] = map_cr("Telescope commands", opts),
    ["n|<leader>sb"] = map_cr("Telescope buffers", opts),
    ["n|<leader>,"] = map_cr("Telescope buffers", opts),
    ["n|<leader>ss"] = map_cr("Telescope live_grep", opts),
    ["n|<leader>/"] = map_cr("Telescope live_grep", opts),
    ["n|<leader>sS"] = map_cr("Telescope grep_string", opts),
    ["n|<leader>sf"] = map_cr("Telescope find_files", opts),
    ["n|<leader><space>"] = map_cr("Telescope find_files", opts),
    ["n|<leader>so"] = map_cr("Telescope oldfiles", opts),
    ["n|<leader>su"] = map_cr("Telescope undo", opts),
    ["n|<leader>sp"] = map_cr("Telescope project", opts),
    ["n|<leader>:"] = map_cr("Telescope command_history", opts),
  }
end

return K
