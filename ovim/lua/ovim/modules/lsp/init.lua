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
        "folke/neoconf.nvim",
        {
          "folke/lazydev.nvim",
          ft = "lua", -- only load on lua files
          opts = {
            library = {
              -- See the configuration section for more details
              -- Load luvit types when the `vim.uv` word is found
              { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
          },
        },
      },
    },
  },
  ["williamboman/mason.nvim"] = {
    "williamboman/mason.nvim",
    level = 1,
    event = "VeryLazy",
    opts = {
      install_root_dir = ovim.const.cache_path .. "/mason",
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
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
