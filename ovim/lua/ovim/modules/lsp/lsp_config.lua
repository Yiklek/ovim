-- File: lsp/lspconfig.lua
-- Author: Yiklek
-- Description: lspconfig
-- Copyright (c) 2022 Yiklek

local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
require("neoconf").setup()
mason.setup {
  install_root_dir = ovim.util.path_concat { ovim.const.cache_path, "mason" },
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}

mason_lsp.setup {}

if vim.diagnostic ~= nil and vim.diagnostic.config ~= nil then
  vim.diagnostic.config {
    virtual_text = false,
  }
end
local keymap = require("ovim.modules.lsp.keymap")
require("ovim.core.keymap").load(keymap.lsp())
