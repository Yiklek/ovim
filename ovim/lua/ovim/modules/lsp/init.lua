-- File: lsp/init.lua
-- Author: Yiklek
-- Description: lsp
-- Copyright (c) 2022 Yiklek
local plugins = {
  ["neovim/nvim-lspconfig"] = {
    "neovim/nvim-lspconfig",
    level = 1,
    opt = true,
    event = "VeryLazy",
    config = function()
      require("ovim.modules.lsp.config").nvim_lsp()
    end,
    dependencies = {
      {
        "mason.nvim",
        "ray-x/lsp_signature.nvim",
        "lvimuser/lsp-inlayhints.nvim",
        "folke/neodev.nvim",
      },
    },
  },
  ["williamboman/mason.nvim"] = {
    "williamboman/mason.nvim",
    level = 1,
    event = "VeryLazy",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
      },
    },
  },
  ["folke/trouble.nvim"] = {
    "folke/trouble.nvim",
    event = "BufReadPost",
    config = function()
      require("ovim.modules.lsp.config").trouble()
    end,
  },
}
local features = require("ovim.core.features").setup_module_features("lsp", plugins)
return {
  name = "lsp",
  level = 1,
  plugins = plugins,
  features = features,
}
