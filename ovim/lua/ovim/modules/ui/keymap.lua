-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for ui
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require "ovim.misc.keymap"
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local map_s = km.map_s
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

    ["n|<esc>"] = display "Floaterm",
    ["n|<esc><space>"] = map_cmd("FloatermToggle", opts):with_display "Floaterm Toggle",
    ["n|<esc>;"] = map_cmd("FloatermFirst", opts):with_display "First Terminal",
    ["n|<esc>'"] = map_cmd("FloatermLast", opts):with_display "Last Terminal",
    ["n|<esc>q"] = map_cmd("FloatermKill", opts):with_display "Kill Terminal",
    ["n|<esc>w"] = display "New Terminal Window",
    ["n|<esc>w<space>"] = map_cmd("FloatermNew --wintype=vsplit --position=right --width=0.4", opts):with_display "Right Window",
    ["n|<esc>wr"] = map_cmd("FloatermNew --wintype=vsplit --position=right --width=0.4", opts):with_display "Right Window",
    ["n|<esc>wb"] = map_cmd("FloatermNew --wintype=split --position=bottom --height=0.3", opts):with_display "Bottom Window",
    ["n|<esc>9"] = map_cmd("FloatermPrev", opts):with_display "Previous Terminal",
    ["n|<esc>0"] = map_cmd("FloatermNext", opts):with_display "Next Terminal",
    ["n|<esc>n"] = map_cmd("FloatermNew --wintype=float --position=center --width=0.8 --height=0.8", opts):with_display "New Terminal",
    ["n|<esc>-"] = map_cmd("FloatermUpdate --wintype=split --position=topleft --height=0.3", opts):with_display "Move to Top",
    ["n|<esc>="] = map_cmd("FloatermUpdate --wintype=split --position=botright --height=0.3", opts):with_display "Move to Bottom",
    ["n|<esc>["] = map_cmd("FloatermUpdate --wintype=vsplit --position=topleft --width=0.4", opts):with_display "Move to Left",
    ["n|<esc>]"] = map_cmd("FloatermUpdate --wintype=vsplit --position=botright --width=0.4", opts):with_display "Move to Right",
    ["n|<esc>\\"] = map_cmd("FloatermUpdate --wintype=float --position=center --width=0.8 --height=0.8", opts):with_display "Float",
    ["n|<esc>j"] = map_s([[<c-w>j]], opts):with_display "Focus to Bottom",
    ["n|<esc>k"] = map_cmd([[<c-w>k]], opts):with_display "Focus to Top",
    ["n|<esc>h"] = map_cmd([[<c-w>h]], opts):with_display "Focus to Left",
    ["n|<esc>l"] = map_cmd([[<c-w>l]], opts):with_display "Focus to Right",

    ["t|<esc>"] = display "Floaterm",
    ["t|<esc><space>"] = map_cmd("FloatermToggle", opts):with_display "Floaterm Toggle",
    ["t|<esc>;"] = map_cmd("FloatermFirst", opts):with_display "First Terminal",
    ["t|<esc>'"] = map_cmd("FloatermLast", opts):with_display "Last Terminal",
    ["t|<esc>q"] = map_cmd("FloatermKill", opts):with_display "Kill Terminal",
    ["t|<esc>w"] = display "New Terminal Window",
    ["t|<esc>w<space>"] = map_cmd("FloatermNew --wintype=vsplit --position=right --width=0.4", opts):with_display "Right Window",
    ["t|<esc>wr"] = map_cmd("FloatermNew --wintype=vsplit --position=right --width=0.4", opts):with_display "Right Window",
    ["t|<esc>wb"] = map_cmd("FloatermNew --wintype=split --position=bottom --height=0.3", opts):with_display "Bottom Window",
    ["t|<esc>9"] = map_cmd("FloatermPrev", opts):with_display "Previous Terminal",
    ["t|<esc>0"] = map_cmd("FloatermNext", opts):with_display "Next Terminal",
    ["t|<esc>n"] = map_cmd("FloatermNew --wintype=float --position=center --width=0.8 --height=0.8", opts):with_display "New Terminal",
    ["t|<esc>-"] = map_cmd("FloatermUpdate --wintype=split --position=topleft --height=0.3", opts):with_display "Move to Top",
    ["t|<esc>="] = map_cmd("FloatermUpdate --wintype=split --position=botright --height=0.3", opts):with_display "Move to Bottom",
    ["t|<esc>["] = map_cmd("FloatermUpdate --wintype=vsplit --position=topleft --width=0.4", opts):with_display "Move to Left",
    ["t|<esc>]"] = map_cmd("FloatermUpdate --wintype=vsplit --position=botright --width=0.4", opts):with_display "Move to Right",
    ["t|<esc>\\"] = map_cmd("FloatermUpdate --wintype=float --position=center --width=0.8 --height=0.8", opts):with_display "Float",
    ["t|<esc>j"] = map_s([[<c-\><c-n><c-w>j]], opts):with_display "Focus to Bottom",
    ["t|<esc>k"] = map_s([[<c-\><c-n><c-w>k]], opts):with_display "Focus to Top",
    ["t|<esc>h"] = map_s([[<c-\><c-n><c-w>h]], opts):with_display "Focus to Left",
    ["t|<esc>l"] = map_s([[<c-\><c-n><c-w>l]], opts):with_display "Focus to Right",

    ["v|<leader>ets"] = map_cmd("FloatermSend", opts),
  }
end

return K
