-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for ui
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require("ovim.core.keymap")
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
    ["n|<leader>d"] = display("Debug"),
    ["n|<leader>db"] = map_cr("lua require('dap').toggle_breakpoint()", opts):display("ToggleBreakpoint"),
    ["n|<leader>dr"] = map_cr("lua require('dap').repl.open()", opts):display("OpenREPL"),
    ["n|<leader>dl"] = map_cr("lua require('dap').run_last()", opts):display("RunLast"),
    ["n|<leader>dc"] = map_cr("lua require('dap').continue()", opts):display("Continue"),
    ["n|<leader>dt"] = map_cr("lua require('dap').terminate()", opts):display("Terminate"),
    ["n|<leader>ds"] = map_cr("lua require('dap').step_over()", opts):display("StepOver"),
    ["n|<leader>di"] = map_cr("lua require('dap').step_into()", opts):display("StepInto"),
    ["n|<leader>do"] = map_cr("lua require('dap').step_out()", opts):display("StepOut"),
  }
end

return K
