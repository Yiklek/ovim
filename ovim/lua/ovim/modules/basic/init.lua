-- File: config.lua
-- Author: Yiklek
-- Description: global config
-- Copyright (c) 2022 Yiklek

local km = require("ovim.core.keymap")
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
  ["folke/lazy.nvim"] = {
    "folke/lazy.nvim",
  },
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
  ["folke/persistence.nvim"] = {
    "folke/persistence.nvim",
    event = "BufReadPre",
    init = function()
      km.load { ["n|<leader>r"] = display("Session") }
    end,
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    keys = {
      -- stylua: ignore start
      { "<leader>rs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>rl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>rd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
      -- stylua: ignore end
    },
  },
  ["bfredl/nvim-luadev"] = {
    "bfredl/nvim-luadev",
    event = "VeryLazy",
    keys = {
      -- stylua: ignore start
      { "<leader>xl", "<Plug>(Luadev-RunLine)", desc = "Luadev RunLine" },
      { "<leader>xr", "<Plug>(Luadev-Run)",     desc = "Luadev Run",    mode = { "v", "n" } },
      { "<leader>xw", "<Plug>(Luadev-RunWord)", desc = "Luadev RunWord" }
,
      -- { "<leader>xc", "<Plug>(Luadev-Complete)", desc = "Luadev Complete", mode = "i" }
      -- stylua: ignore end
    },
  },
  ["EtiamNullam/deferred-clipboard.nvim"] = {
    "EtiamNullam/deferred-clipboard.nvim",
    event = "VeryLazy",
    config = function()
      require("deferred-clipboard").setup {
        fallback = "unnamedplus",
      }
    end,
  },
}
return {
  plugins = plugins,
}
