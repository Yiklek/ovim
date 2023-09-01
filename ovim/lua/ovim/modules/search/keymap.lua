local K = {}

local km = require("ovim.core.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local map = km.map
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
  local map_keys = function(target)
    return function()
      require("telescope.builtin")[target]()
    end
  end
  return {
    ["n|<leader>s"] = display("Search (Telescope)"),
    ["n|<leader>sy"] = map(map_keys("frecency"), opts):display("frecency"),
    ["n|<leader>sc"] = map(map_keys("commands"), opts):display("commands"),
    ["n|<leader>sb"] = map(map_keys("buffers"), opts):display("buffers"),
    ["n|<leader>,"] = map(map_keys("buffers"), opts):display("buffers"),
    ["n|<leader>ss"] = map(map_keys("live_grep"), opts):display("live_grep"),
    ["n|<leader>/"] = map(map_keys("live_grep"), opts):display("live_grep"),
    ["n|<leader>sS"] = map(map_keys("grep_string"), opts):display("grep_string"),
    ["n|<leader>sf"] = map(map_keys("find_files"), opts):display("find_files"),
    ["n|<leader><space>"] = map(map_keys("find_files"), opts):display("find_files"),
    ["n|<leader>so"] = map(map_keys("oldfiles"), opts):display("oldfiles"),
    ["n|<leader>su"] = map(map_keys("undo"), opts):display("undo"),
    ["n|<leader>sp"] = map(map_keys("project"), opts):display("project"),
    ["n|<leader>:"] = map(map_keys("command_history"), opts):display("command_history"),
  }
end

return K
