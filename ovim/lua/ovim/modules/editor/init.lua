-- File: editor/init.lua
-- Author: Yiklek
-- Description: editor init
-- Copyright (c) 2022 Yiklek
local plugins = {
  ["echasnovski/mini.bufremove"] = {
    "echasnovski/mini.bufremove",
        -- stylua: ignore
        keys = {
            { "<leader>br", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bR", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
        },
  },
  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  ["folke/todo-comments.nvim"] = {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
        -- stylua: ignore start
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
        },
    -- stylua: ignore end
  },
  ["danymat/neogen"] = {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = { snippet_engine = "luasnip" },
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*"
        -- stylua: ignore start
        keys = {
            { "<leader>xdd", function() require('neogen').generate { type = "func" } end,  desc = "function doc" },
            { "<leader>xdf", function() require('neogen').generate { type = "file" } end,  desc = "file doc" },
            { "<leader>xdc", function() require('neogen').generate { type = "class" } end, desc = "class doc" },
            { "<leader>xdt", function() require('neogen').generate { type = "type" } end,  desc = "type doc" },
        }
,
    -- stylua: ignore end
  },
}

local addon = require("ovim.modules.editor.addon")
addon.init()
require("ovim.modules.editor.keymap").init()

local features = require("ovim.core.features").setup_module_features("editor", plugins)
return {
  name = "editor",
  level = 1,
  features = features,
  plugins = plugins,
}
