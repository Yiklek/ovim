
local K = {}

local km = require("ovim.misc.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local display = km.display

function K.telescope()

    return {
        ["n|<leader>st"] = display("Telescope"),
        ["n|<leader>st<space>"] = map_cr("Telescope"):with_display():with_noremap():with_silent(),
        ["n|<leader>stf"] = map_cr("Telescope frecency"):with_display():with_noremap():with_silent(),
        ["n|<leader>stc"] = map_cr("Telescope commands"):with_display():with_noremap():with_silent(),
    }
end

return K
