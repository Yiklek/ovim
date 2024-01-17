-- File: features.lua
-- Author: ovim
-- Description: editor features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim
local km = require("ovim.core.keymap")
return {
  lspsaga = function(p, opts)
    local lspsaga_plugin = {
      "nvimdev/lspsaga.nvim",
      event = "BufRead",
      dependencies = {
        "nvim-treesitter/nvim-treesitter", -- optional
        "nvim-tree/nvim-web-devicons", -- optional
      },
    }
    if p["neovim/nvim-lspconfig"].dependencies ~= nil then
      p["neovim/nvim-lspconfig"].dependencies[#p["neovim/nvim-lspconfig"].dependencies + 1] = lspsaga_plugin
    else
      p["neovim/nvim-lspconfig"].dependencies = { lspsaga_plugin }
    end
  end,
}
