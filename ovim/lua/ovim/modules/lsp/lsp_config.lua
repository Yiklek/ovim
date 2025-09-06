-- File: lsp/lspconfig.lua
-- Author: Yiklek
-- Description: lspconfig
-- Copyright (c) 2022 Yiklek

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local config = require("ovim.config")
require("neoconf").setup()
mason.setup {
  install_root_dir = ovim.const.cache_path .. "/mason",
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}

local servers = {
  lua_ls = require("ovim.modules.lsp.server.lua"),
  clangd = require("ovim.modules.lsp.server.clangd"),
  html = require("ovim.modules.lsp.server.html"),
}

local function custom_attach(client, bufnr)
  local signature = require("ovim.core.safe_require")("lsp_signature")
  if signature ~= nil then
    require("lsp_signature").on_attach {
      bind = true,
      use_lspsaga = false,
      floating_window = true,
      fix_pos = true,
      hint_enable = true,
      hi_parameter = "Search",
      handler_opts = { "double" },
    }
  end
  local navic = require("ovim.core.safe_require")("nvim-navic")
  if navic ~= nil and client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  if config.modules.lsp.opts.inlay_hint and client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

local function setup(server_name)
  local server_config = servers[server_name]
  local server_opts
  if server_config ~= nil and type(server_config) == "table" then
    server_opts = server_config.on_setup {
      on_attach = custom_attach,
    }
  else
    server_opts = {
      on_attach = custom_attach,
    }
  end
  lspconfig[server_name].setup(server_opts)
end

mason_lsp.setup {
  handlers = { setup },
}

if vim.diagnostic ~= nil and vim.diagnostic.config ~= nil then
  vim.diagnostic.config {
    virtual_text = false,
  }
end
local keymap = require("ovim.modules.lsp.keymap")
require("ovim.core.keymap").load(keymap.lsp())
