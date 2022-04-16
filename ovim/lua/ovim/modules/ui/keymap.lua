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

function K.bufferline()
    return {
        ["n|<leader>b"] = display("Buffer"),
        ["n|gb"] = map_cr("BufferLinePick"):with_display():with_noremap():with_silent(),
        ["n|<leader>bn"] = map_cr("BufferLineCycleNext"):with_display():with_noremap():with_silent(),
        ["n|<leader>bj"] = map_cr("BufferLineCycleNext"):with_display():with_noremap():with_silent(),
        ["n|<leader>bp"] = map_cr("BufferLineCyclePrev"):with_display():with_noremap():with_silent(),
        ["n|<leader>bk"] = map_cr("BufferLineCyclePrev"):with_display():with_noremap():with_silent(),
        ["n|<A-S-j>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent(),
        ["n|<A-S-k>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent(),
        ["n|<leader>be"] = map_cr("BufferLineSortByExtension"):with_display():with_noremap(),
        ["n|<leader>bd"] = map_cr("BufferLineSortByDirectory"):with_display():with_noremap(),
        ["n|<leader>b1"] = map_cr("BufferLineGoToBuffer 1"):with_display():with_noremap():with_silent(),
        ["n|<leader>b2"] = map_cr("BufferLineGoToBuffer 2"):with_display():with_noremap():with_silent(),
        ["n|<leader>b3"] = map_cr("BufferLineGoToBuffer 3"):with_display():with_noremap():with_silent(),
        ["n|<leader>b4"] = map_cr("BufferLineGoToBuffer 4"):with_display():with_noremap():with_silent(),
        ["n|<leader>b5"] = map_cr("BufferLineGoToBuffer 5"):with_display():with_noremap():with_silent(),
        ["n|<leader>b6"] = map_cr("BufferLineGoToBuffer 6"):with_display():with_noremap():with_silent(),
        ["n|<leader>b7"] = map_cr("BufferLineGoToBuffer 7"):with_display():with_noremap():with_silent(),
        ["n|<leader>b8"] = map_cr("BufferLineGoToBuffer 8"):with_display():with_noremap():with_silent(),
    }
end
function K.nvim_tree()
    -- use coc first
    if vim.g.coc_enabled == nil or not vim.g.coc_enabled then
        return {
            ["n|="] = display("FileExplorer"),
            ["n|=="] = map_cr("NvimTreeToggle"):with_display():with_noremap():with_silent(),
            ["n|=f"] = map_cr("NvimTreeFindFile"):with_display():with_noremap():with_silent(),
            ["n|=r"] = map_cr("NvimTreeRefresh"):with_display():with_noremap():with_silent(),
        }
    end
    return {}
end

return K
