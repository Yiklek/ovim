-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for lsp
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require("ovim.misc.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local display = km.display
local function basic()
    return {
        ["n|<leader>\\"] = display("vsplit"),
        ["n|<leader>-"] = display("split"),
        ["n|<leader>q"] = display("Exit"),
        ["n|<leader>t"] = display("Tag"),
        ["n|<leader>tq"] = display("Close"),
        ["n|<leader>tk"] = display("Prev"),
        ["n|<leader>th"] = display("Prev"),
        ["n|<leader>tj"] = display("Next"),
        ["n|<leader>tl"] = display("Next"),
        ["n|<leader>tQ"] = display("CloseAll"),
        ["n|<leader>to"] = display("Open"),
        ["n|<leader>tp"] = display("OpenCurrentInNewTab"),
        ["n|<leader>tL"] = display("List"),
        ["n|<leader>w"] = display("Window"),
        ["n|<leader>wH"] = display("Move to Left"),
        ["n|<leader>wJ"] = display("Move to Below"),
        ["n|<leader>wK"] = display("Move to Top"),
        ["n|<leader>wL"] = display("Move to Right"),
        ["n|<leader>wa"] = display("Vertical Decrease"),
        ["n|<leader>w,"] = display("Vertical Decrease"),
        ["n|<leader>wd"] = display("Vertical Increase"),
        ["n|<leader>w."] = display("Vertical Increase"),
        ["n|<leader>ws"] = display("Height Decrease"),
        ["n|<leader>ww"] = display("Height Increase"),
        ["n|<leader>w-"] = display("Height Decrease"),
        ["n|<leader>w="] = display("Height Increase"),
        ["n|<leader>wh"] = display("Focus to Left"),
        ["n|<leader>wj"] = display("Focus to Below"),
        ["n|<leader>wk"] = display("Focus to Top"),
        ["n|<leader>wl"] = display("Focus to Right"),
        ["n|<leader>w<space>"] = display("Choose Window"),

        -- the following keymaps are for plugins loaded by dein or vim-plug
        -- and will be remove in the future
        -- Floaterm
        ["n|<leader>e"] = display("Extensions"),
        ["n|<leader>et"] = display("Floaterm"),
        ["n|<leader>et<space>"] = display("Floaterm Toggle"),
        ["n|<leader>et0"] = display("First Terminal"),
        ["n|<leader>et9"] = display("Last Terminal"),
        ["n|<leader>etk"] = display("Kill Terminal"),
        ["n|<leader>etw"] = display("Normal Terminal"),
        ["n|<leader>etw<space>"] = display("Right Window"),
        ["n|<leader>etwn"] = display("New Window"),
        ["n|<leader>etwnr"] = display("Right Window"),
        ["n|<leader>etwnb"] = display("Bottom Window"),
        ["n|<leader>et["] = display("Previous Terminal"),
        ["n|<leader>et]"] = display("Next Terminal"),
        ["n|<leader>etn"] = display("New Terminal"),
        ["n|<leader>et?"] = display("Help"),

        -- AnyJump
        ["n|<leader>ej"] = display("AnyJump"),
        ["n|<leader>ej<space>"] = display("Jump"),
        ["n|<leader>ejb"] = display("JumpBack"),
        ["n|<leader>ejl"] = display("JumpLastResults"),

        -- AsyncRun
        ["n|<leader>r"] = display("AsyncRun"),
        ["n|<leader>r<space>"] = display("Run"),
        ["n|<leader>rp"] = display("Project Build"),
        ["n|<leader>rb"] = display("File Build"),
        ["n|<leader>rx"] = display("File Run"),
        ["n|<leader>rr"] = display("Project Run"),

        -- Search
        ["n|<leader>s"] = display("Search"),
        ["n|<leader>sp"] = display("CtrlP"),
        ["n|<leader>sp<space>"] = display("CtrlP"),

        ["n|<leader>sf"] = display("FZF"),
        ["n|<leader>sf<space>"] = display("Files"),

        ["n|<leader>sl"] = display("Leaderf"),
        ["n|<leader>sl<space>"] = display("LeaderFile"),


        ["n|<leader>x"] = display("Edit"),
        ["n|<leader>xf"] = display("Format"),
        ["n|<leader>xa"] = display("RemoveTraialingSpace"),

    }
end

km.load(basic())
km.load(require("ovim.modules.search.keymap").telescope())

return {
    basic = basic
}
