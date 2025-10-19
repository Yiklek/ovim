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

local function map_act(target)
  return function()
    require("telescope.builtin")[target]()
  end
end

function K.telescope()
  return {
    ["n|<leader>s"] = display("Search (Telescope)"),
    ["n|<leader>s<space>"] = map_cmd("Telescope", opts):display("Telescope"),
    ["n|<leader>sy"] = map_cmd("Telescope frecency", opts):display("frecency"),
    ["n|<leader>sp"] = map_cmd("Telescope project", opts):display("project"),
    ["n|<leader>sc"] = map(map_act("commands"), opts):display("commands"),
    ["n|<leader>sb"] = map(map_act("buffers"), opts):display("buffers"),
    ["n|<leader>,"] = map(map_act("buffers"), opts):display("buffers"),
    ["n|<leader>ss"] = map(map_act("grep_string"), opts):display("live_grep"),
    ["n|<leader>/"] = map(map_act("live_grep"), opts):display("live_grep"),
    ["n|<leader>sS"] = map(require("ovim.core.action").live_grep, opts):display("grep_string"),
    ["n|<leader>sf"] = map(map_act("find_files"), opts):display("find_files"),
    ["n|<leader>sF"] = map(require("ovim.core.action").find_files, opts):display("find_files"),
    ["n|<leader>."] = map(map_act("find_files"), opts):display("find_files"),
    ["n|<leader>so"] = map(map_act("oldfiles"), opts):display("oldfiles"),
    ["n|<leader>su"] = map(map_act("undo"), opts):display("undo"),
    ["n|<leader>;"] = map(map_act("command_history"), opts):display("command_history"),
    ["n|<leader>'"] = map(map_act("registers"), opts):display("registers"),
  }
end

function K.telescope_which_key()
  return {
    mode = "n",
    { "<leader>s", desc = "Search (Telescope)" },
    { "<leader>s<space>", km.cmd("Telescope"), desc = "Telescope" },
    { "<leader>sy", km.cmd("Telescope frecency"), desc = "frecency" },
    { "<leader>sp", km.cmd("Telescope project"), desc = "project" },

    { "<leader>sc", map_act("commands"), desc = "commands" },
    { "<leader>sb", map_act("buffers"), desc = "buffers" },
    { "<leader>,", map_act("buffers"), desc = "buffers" },
    { "<leader>ss", map_act("live_grep"), desc = "live_grep" },
    { "<leader>/", map_act("live_grep"), desc = "live_grep" },
    { "<leader>sS", map_act("grep_string"), desc = "grep_string" },
    { "<leader>sf", map_act("find_files"), desc = "find_files" },
    { "<leader>.", map_act("find_files"), desc = "find_files" },
    { "<leader>so", map_act("oldfiles"), desc = "oldfiles" },
    { "<leader>su", map_act("undo"), desc = "undo" },
    { "<leader>;", map_act("command_history"), desc = "command_history" },
    { "<leader>'", map_act("registers"), desc = "registers" },
  }
end

return K
