-- File: config.lua
-- Author: Yiklek
-- Description: global config
-- Copyright (c) 2022 Yiklek

local km = require "ovim.misc.keymap"
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local map = km.map
local display = km.display

local opts = {
  display = {
    enable = true,
  },
  map = {
    noremap = true,
    silent = true,
  },
}

local plugins = {
  ["tweekmonster/startuptime.vim"] = {
    "tweekmonster/startuptime.vim",
    level = 0,
    cmd = "StartupTime",
  },
  ["lambdalisue/suda.vim"] = {
    "lambdalisue/suda.vim",
    level = 0,
    cmd = { "SudaRead", "SudaWrite" },
  },
  ["stevearc/overseer.nvim"] = {
    "stevearc/overseer.nvim",
    event = "VeryLazy",
    config = function()
      require("overseer").setup {
        templates = { "builtin", "ovim" },
      }
    end,
  },
}
return {
  plugins = plugins,
}
