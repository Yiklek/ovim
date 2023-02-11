-- File: config.lua
-- Author: Yiklek
-- Description: global config
-- Copyright (c) 2022 Yiklek

local km = require "ovim.misc.keymap"
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local map_s = km.map_s
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
  ["skywind3000/asynctasks.vim"] = {
    "skywind3000/asynctasks.vim",
    event = "VeryLazy",
    config = function()
      vim.g.asynctasks_extra_config = {
        ovim.const.root_path .. "/config/asynctasks/tasks.ini",
      }
      vim.g.asynctasks_term_pos = "bottom"
      km.load {
        ["n|<leader>r"] = display "Run",
        ["n|<leader>rp"] = map_cmd("AsyncTask project-build"):with_display "Project Build",
        ["n|<leader>rb"] = map_cmd("AsyncTask file-build"):with_display "File Build",
        ["n|<leader>rx"] = map_cmd("AsyncTask file-run"):with_display "File Run",
        ["n|<leader>rr"] = map_cmd("AsyncTask project-run"):with_display "Project Run",
      }
    end,
    dependencies = {
      {
        "skywind3000/asyncrun.vim",
        config = function()
          vim.g.asyncrun_open = 10
        end,
      },
    },
  },
}
return {
  plugins = plugins,
}
