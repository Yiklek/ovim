-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for ui
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require("ovim.misc.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local display = km.display
local K = {}
local opts = {
    display = {
        enable = true
    },
    map = {
        noremap = true,
        silent = true
    }
}
function K.bufferline()
    return {
        ["n|<leader>b"] = display("Buffer"),
        ["n|gb"] = map_cr("BufferLinePick", opts),
        ["n|<leader>bn"] = map_cr("BufferLineCycleNext", opts),
        ["n|<leader>bj"] = map_cr("BufferLineCycleNext", opts),
        ["n|<leader>bp"] = map_cr("BufferLineCyclePrev", opts),
        ["n|<leader>bk"] = map_cr("BufferLineCyclePrev", opts),
        ["n|<A-S-j>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent(),
        ["n|<A-S-k>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent(),
        ["n|<leader>be"] = map_cr("BufferLineSortByExtension", opts),
        ["n|<leader>bd"] = map_cr("BufferLineSortByDirectory", opts),
        ["n|<leader>b1"] = map_cr("BufferLineGoToBuffer 1", opts),
        ["n|<leader>b2"] = map_cr("BufferLineGoToBuffer 2", opts),
        ["n|<leader>b3"] = map_cr("BufferLineGoToBuffer 3", opts),
        ["n|<leader>b4"] = map_cr("BufferLineGoToBuffer 4", opts),
        ["n|<leader>b5"] = map_cr("BufferLineGoToBuffer 5", opts),
        ["n|<leader>b6"] = map_cr("BufferLineGoToBuffer 6", opts),
        ["n|<leader>b7"] = map_cr("BufferLineGoToBuffer 7", opts),
        ["n|<leader>b8"] = map_cr("BufferLineGoToBuffer 8", opts),
    }
end
function K.nvim_tree()
    return {
        ["n|="] = display("FileExplorer"),
        ["n|=="] = map_cr("NvimTreeToggle", opts),
        ["n|=f"] = map_cr("NvimTreeFindFile", opts),
        ["n|=r"] = map_cr("NvimTreeRefresh", opts),
    }
end

return K
