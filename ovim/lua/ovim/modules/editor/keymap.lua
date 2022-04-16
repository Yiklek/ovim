local K = {}

local km = require("ovim.misc.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local display = km.display

function K.nvim_comment()
    return {
        ["n|<leader>c"] = display("Comment") 
    } 
end

return K
