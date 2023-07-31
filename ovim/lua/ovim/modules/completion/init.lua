-- File: completion/init.lua
-- Author: Yiklek
-- Description: completion
-- Copyright (c) 2022 Yiklek
return {
  name = "completion",
  level = 1,
  condition = "vim.g['ovim#modules#autocomplete'] and vim.g['ovim#modules#autocomplete'].method == 'nvim_cmp'",
  plugins = {
    ["hrsh7th/nvim-cmp"] = {
      "hrsh7th/nvim-cmp",
      config = function()
        require "ovim.core.safe_require"("ovim.modules.completion.config").nvim_cmp()
      end,
      event = "VeryLazy",
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
    {
      "L3MON4D3/LuaSnip",
      config = function()
        require "ovim.core.safe_require"("ovim.modules.completion.config").lua_snip()
      end,
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
        "Yiklek/ovim-snippets",
      },
    },
  },
}
