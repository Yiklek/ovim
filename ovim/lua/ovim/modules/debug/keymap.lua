-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for ui
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require "ovim.core.keymap"
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
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

function K.dap()
  return {
    ["n|<leader>d"] = display "Debug",
    ["n|<leader>db"] = map_cr("lua require('dap').toggle_breakpoint()", opts):with_display "ToggleBreakpoint",
    ["n|<leader>dr"] = map_cr("lua require('dap').repl.open()", opts):with_display "OpenREPL",
    ["n|<leader>dl"] = map_cr("lua require('dap').run_last()", opts):with_display "RunLast",
    ["n|<leader>dc"] = map_cr("lua require('dap').continue()", opts):with_display "Continue",
    ["n|<leader>dt"] = map_cr("lua require('dap').terminate()", opts):with_display "Terminate",
    ["n|<leader>ds"] = map_cr("lua require('dap').step_over()", opts):with_display "StepOver",
    ["n|<leader>di"] = map_cr("lua require('dap').step_into()", opts):with_display "StepInto",
    ["n|<leader>do"] = map_cr("lua require('dap').step_out()", opts):with_display "StepOut",
  }
end

return K
