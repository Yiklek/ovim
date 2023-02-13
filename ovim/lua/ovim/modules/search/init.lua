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
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
}
local features = require("ovim.misc.features").setup_module_features("search", plugins)
return {
  name = "search",
  level = 1,
  plugins = plugins,
  features = features,
}
