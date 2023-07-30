-- File: search/init.lua
-- Author: Yiklek
-- Description: search init
-- Copyright (c) 2022 Yiklek
local km = require "ovim.misc.keymap"
local plugins = {
  ["nvim-telescope/telescope.nvim"] = {
    "nvim-telescope/telescope.nvim",
    level = 1,
    opt = true,
    cmd = "Telescope",
    event = "VeryLazy",
    module = "telescope",
    init = function()
      km.load(require("ovim.modules.search.keymap").telescope())
    end,
    config = function()
      require "ovim.misc.safe_require"("ovim.modules.search.config").telescope()
    end,
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "nvim-telescope/telescope-project.nvim",
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = {
          {
            "tami5/sqlite.lua",
            config = function()
              require "ovim.misc.safe_require"("ovim.modules.search.config").sqlite()
            end,
          },
        },
      },
      "jvgrootveld/telescope-zoxide",
      "gbrlsnchs/telescope-lsp-handlers.nvim",
      "debugloop/telescope-undo.nvim",
    },
  },
  ["nvim-pack/nvim-spectre"] = {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    event = "VeryLazy",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      -- stylua: ignore start
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)", },
      -- stylua: ignore end
    },
  },
}
local features = require("ovim.misc.features").setup_module_features("search", plugins)
return {
  name = "search",
  level = 1,
  plugins = plugins,
  features = features,
}
