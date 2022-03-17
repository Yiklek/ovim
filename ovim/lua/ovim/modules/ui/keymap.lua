-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for ui
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require("ovim.misc.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd

local function bufferline()
    return {
        ["n|gb"] = map_cr("BufferLinePick"):with_noremap():with_silent(),
        ["n|<A-j>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent(),
        ["n|<A-k>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent(),
        ["n|<A-S-j>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent(),
        ["n|<A-S-k>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent(),
        ["n|<leader>be"] = map_cr("BufferLineSortByExtension"):with_noremap(),
        ["n|<leader>bd"] = map_cr("BufferLineSortByDirectory"):with_noremap(),
        ["n|<A-1>"] = map_cr("BufferLineGoToBuffer 1"):with_noremap():with_silent(),
        ["n|<A-2>"] = map_cr("BufferLineGoToBuffer 2"):with_noremap():with_silent(),
        ["n|<A-3>"] = map_cr("BufferLineGoToBuffer 3"):with_noremap():with_silent(),
        ["n|<A-4>"] = map_cr("BufferLineGoToBuffer 4"):with_noremap():with_silent(),
        ["n|<A-5>"] = map_cr("BufferLineGoToBuffer 5"):with_noremap():with_silent(),
        ["n|<A-6>"] = map_cr("BufferLineGoToBuffer 6"):with_noremap():with_silent(),
        ["n|<A-7>"] = map_cr("BufferLineGoToBuffer 7"):with_noremap():with_silent(),
        ["n|<A-8>"] = map_cr("BufferLineGoToBuffer 8"):with_noremap():with_silent(),
        ["n|<A-9>"] = map_cr("BufferLineGoToBuffer 9"):with_noremap():with_silent(),
    }
end

function nvim_tree()
    -- use coc first 
    if vim.g.coc_enabled == nil or not vim.g.coc_enabled then
        return {
            ["n|=="] = map_cr("NvimTreeToggle"):with_noremap():with_silent(),
            ["n|=f"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent(),
            ["n|=r"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent(),
        }
    end
    return {}
end



--km.nvim_load_mapping(map)
return {
    bufferline = bufferline,
    nvim_tree = nvim_tree,
}
