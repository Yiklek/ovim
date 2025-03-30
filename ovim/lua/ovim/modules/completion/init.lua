-- File: completion/init.lua
-- Author: Yiklek
-- Description: completion
-- Copyright (c) 2022 Yiklek

return {
  name = "completion",
  level = 1,
  plugins = {
    ["hrsh7th/nvim-cmp"] = {
      "hrsh7th/nvim-cmp",
      config = function()
        require("ovim.modules.completion.config").nvim_cmp()
      end,
      event = "VeryLazy",
      enabled = false,
      dependencies = {
        "lukas-reineke/cmp-under-comparator",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "andersevenrud/cmp-tmux",
        "hrsh7th/cmp-path",
        "f3fora/cmp-spell",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "kdheepak/cmp-latex-symbols",
      },
    },
    ["saghen/blink.cmp"] = {
      "saghen/blink.cmp",
      dependencies = {
        "rafamadriz/friendly-snippets",
        "mikavilpas/blink-ripgrep.nvim",
      },
      event = "VeryLazy",
      opts = require("ovim.modules.completion.config").blink_cmp(),
      -- 由于“opts_extend”，您的配置中的其他位置无需重新定义它
      opts_extend = { "sources.default" },
    },
    {
      "L3MON4D3/LuaSnip",
      config = function()
        require("ovim.modules.completion.config").lua_snip()
      end,
      event = "InsertEnter",
      build = "make install_jsregexp",
      dependencies = {
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
        "Yiklek/ovim-snippets",
      },
    },
  },
}
