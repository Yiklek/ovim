-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for ui
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require "ovim.misc.keymap"
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local map = km.map
local display = km.display
local K = {}
local opts = {
  display = {
    enable = true,
  },
  map = {
    noremap = true,
    silent = true,
  },
}
function K.bufferline()
  return {
    ["n|<leader>b"] = display "Buffer",
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
    ["n|="] = display "FileExplorer",
    ["n|=="] = map_cr("NvimTreeToggle", opts),
    ["n|=f"] = map_cr("NvimTreeFindFile", opts),
    ["n|=r"] = map_cr("NvimTreeRefresh", opts),
  }
end

function K.floaterm()
  return {
    ["n|<leader>et"] = display "Floaterm",
    ["n|<leader>et<space>"] = map_cmd("FloatermToggle", opts):with_display "Floaterm Toggle",
    ["n|<leader>et;"] = map_cmd("FloatermFirst", opts):with_display "First Terminal",
    ["n|<leader>et'"] = map_cmd("FloatermLast", opts):with_display "Last Terminal",
    ["n|<leader>etq"] = map_cmd("FloatermKill", opts):with_display "Kill Terminal",
    ["n|<leader>etw"] = display "New Terminal Window",
    ["n|<leader>etw<space>"] = map_cmd("FloatermNew --wintype=vsplit --position=right --width=0.4", opts):with_display "Right Window",
    ["n|<leader>etwr"] = map_cmd("FloatermNew --wintype=vsplit --position=right --width=0.4", opts):with_display "Right Window",
    ["n|<leader>etwb"] = map_cmd("FloatermNew --wintype=split --position=bottom --height=0.3", opts):with_display "Bottom Window",
    ["n|<leader>et9"] = map_cmd("FloatermPrev", opts):with_display "Previous Terminal",
    ["n|<leader>et0"] = map_cmd("FloatermNext", opts):with_display "Next Terminal",
    ["n|<leader>etn"] = map_cmd("FloatermNew --wintype=float --position=center --width=0.8 --height=0.8", opts):with_display "New Terminal",
    ["n|<leader>et="] = map_cmd("FloatermUpdate --wintype=split --position=botright --height=0.3", opts):with_display "Move to Bottom",
    ["n|<leader>et-"] = map_cmd("FloatermUpdate --wintype=split --position=topleft --height=0.3", opts):with_display "Move to Top",
    ["n|<leader>et["] = map_cmd("FloatermUpdate --wintype=vsplit --position=topleft --width=0.4", opts):with_display "Move to Left",
    ["n|<leader>et]"] = map_cmd("FloatermUpdate --wintype=vsplit --position=botright --width=0.4", opts):with_display "Move to Right",
    ["n|<leader>et\\"] = map_cmd("FloatermUpdate --wintype=float --position=center --width=0.8 --height=0.8", opts):with_display "Float",

    ["n|<A-t>"] = map_cmd("FloatermToggle", opts):with_display "Floaterm Toggle",
    ["n|<A-CR>"] = map_cmd("FloatermToggle", opts):with_display "Floaterm Toggle",
    ["n|<A-;>"] = map_cmd("FloatermFirst", opts):with_display "First Terminal",
    ["n|<A-'>"] = map_cmd("FloatermLast", opts):with_display "Last Terminal",
    ["n|<A-q>"] = map_cmd("FloatermKill", opts):with_display "Kill Terminal",
    ["n|<A-w><space>"] = map_cmd("FloatermNew --wintype=vsplit --position=right --width=0.4", opts):with_display "Right Window",
    ["n|<A-w>r"] = map_cmd("FloatermNew --wintype=vsplit --position=right --width=0.4", opts):with_display "Right Window",
    ["n|<A-w>b"] = map_cmd("FloatermNew --wintype=split --position=bottom --height=0.3", opts):with_display "Bottom Window",
    ["n|<A-9>"] = map_cmd("FloatermPrev", opts):with_display "Previous Terminal",
    ["n|<A-0>"] = map_cmd("FloatermNext", opts):with_display "Next Terminal",
    ["n|<A-n>"] = map_cmd("FloatermNew --wintype=float --position=center --width=0.8 --height=0.8", opts):with_display "New Terminal",
    ["n|<A-->"] = map_cmd("FloatermUpdate --wintype=split --position=topleft --height=0.3", opts):with_display "Move to Top",
    ["n|<A-=>"] = map_cmd("FloatermUpdate --wintype=split --position=botright --height=0.3", opts):with_display "Move to Bottom",
    ["n|<A-[>"] = map_cmd("FloatermUpdate --wintype=vsplit --position=topleft --width=0.4", opts):with_display "Move to Left",
    ["n|<A-]>"] = map_cmd("FloatermUpdate --wintype=vsplit --position=botright --width=0.4", opts):with_display "Move to Right",
    ["n|<A-\\>"] = map_cmd("FloatermUpdate --wintype=float --position=center --width=0.8 --height=0.8", opts):with_display "Float",

    ["t|<A-t>"] = map_cmd("FloatermToggle", opts):with_display "Floaterm Toggle",
    ["t|<A-CR>"] = map_cmd("FloatermToggle", opts):with_display "Floaterm Toggle",
    ["t|<A-;>"] = map_cmd("FloatermFirst", opts):with_display "First Terminal",
    ["t|<A-'>"] = map_cmd("FloatermLast", opts):with_display "Last Terminal",
    ["t|<A-q>"] = map_cmd("FloatermKill", opts):with_display "Kill Terminal",
    ["t|<A-w><space>"] = map_cmd("FloatermNew --wintype=vsplit --position=right --width=0.4", opts):with_display "Right Window",
    ["t|<A-w>r"] = map_cmd("FloatermNew --wintype=vsplit --position=right --width=0.4", opts):with_display "Right Window",
    ["t|<A-w>b"] = map_cmd("FloatermNew --wintype=split --position=bottom --height=0.3", opts):with_display "Bottom Window",
    ["t|<A-9>"] = map_cmd("FloatermPrev", opts):with_display "Previous Terminal",
    ["t|<A-0>"] = map_cmd("FloatermNext", opts):with_display "Next Terminal",
    ["t|<A-n>"] = map_cmd("FloatermNew --wintype=float --position=center --width=0.8 --height=0.8", opts):with_display "New Terminal",
    ["t|<A-->"] = map_cmd("FloatermUpdate --wintype=split --position=topleft --height=0.3", opts):with_display "Move to Top",
    ["t|<A-=>"] = map_cmd("FloatermUpdate --wintype=split --position=botright --height=0.3", opts):with_display "Move to Bottom",
    ["t|<A-[>"] = map_cmd("FloatermUpdate --wintype=vsplit --position=topleft --width=0.4", opts):with_display "Move to Left",
    ["t|<A-]>"] = map_cmd("FloatermUpdate --wintype=vsplit --position=botright --width=0.4", opts):with_display "Move to Right",
    ["t|<A-\\>"] = map_cmd("FloatermUpdate --wintype=float --position=center --width=0.8 --height=0.8", opts):with_display "Float",

    ["v|<leader>ets"] = map_cmd("FloatermSend", opts),
  }
end

return K
