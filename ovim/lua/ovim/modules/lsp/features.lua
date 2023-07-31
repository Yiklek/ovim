-- File: features.lua
-- Author: ovim
-- Description: editor features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim
local km = require "ovim.core.keymap"
return {
  vista = function(p, opts)
    p["liuchengxu/vista.vim"] = {
      "liuchengxu/vista.vim",
      cmd = "Vista",
      init = function()
        km.load(require("ovim.modules.lsp.keymap").vista())
      end,
      config = function()
        require "ovim.core.safe_require"("ovim.modules.lsp.config").vista()
      end,
    }
  end,
  lspsaga = function(p, opts)
    local lspsaga_plugin = {
      "tami5/lspsaga.nvim",
      event = "BufRead",
      config = function()
        require "ovim.core.safe_require"("ovim.modules.lsp.config").lspsaga()
      end,
    }
    if p["neovim/nvim-lspconfig"].dependencies ~= nil then
      p["neovim/nvim-lspconfig"].dependencies[#p["neovim/nvim-lspconfig"].dependencies + 1] = lspsaga_plugin
    else
      p["neovim/nvim-lspconfig"].dependencies = { lspsaga_plugin }
    end
  end,
}
