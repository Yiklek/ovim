-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for lsp
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require "ovim.core.keymap"
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local map_f = km.map_f
local display = km.display
local K = {}
local opts = {
  display = {
    enable = true,
  },
  map = {
    noremap = true,
    silent = true,
    nowait = true,
  },
}
function K.lsp()
  local m = {
    ["n|<leader>l"] = display "LSP",
    ["n|<leader>g"] = display "LSPAction",
    ["n|<leader>li"] = map_cr("LspInfo", opts),
    ["n|<leader>lI"] = map_cr("LspInstallInfo", opts),
    ["n|<leader>ll"] = map_cr("LspInstallLog", opts),
    ["n|<leader>lr"] = map_cr("LspRestart", opts),
    ["n|<leader>lg"] = map_cr("LspStart", opts),
    ["n|<leader>ls"] = map_cr("LspStop", opts),
    ["n|<leader>g]"] = map_cr("Lspsaga diagnostic_jump_next", opts),
    ["n|<leader>g["] = map_cr("Lspsaga diagnostic_jump_prev", opts),
    ["n|<leader>gs"] = map_cr("Lspsaga signature_help", opts),
    ["n|<leader>gr"] = map_cr("Lspsaga rename", opts),
    ["n|<leader>g<space>"] = map_cr("Lspsaga hover_doc", opts),
    ["n|<C-Up>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(-1)"):with_silent(),
    ["n|<C-k>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(-1)"):with_silent(),
    ["n|<C-Down>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(1)"):with_silent(),
    ["n|<C-j>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(1)"):with_silent(),
    ["n|<leader>ga"] = map_cr("Lspsaga code_action", opts),
    ["v|<leader>ga"] = map_cu("Lspsaga range_code_action", opts),
    ["n|<leader>gd"] = map_cr("Lspsaga preview_definition", opts),
    ["n|<leader>gD"] = map_cr("lua vim.lsp.buf.definition()", opts):with_display "Definition",
    ["n|<leader>gt"] = map_cr("lua vim.lsp.buf.type_definition()", opts):with_display "TypeDefinition",
    ["n|<leader>gi"] = map_cr("lua vim.lsp.buf.implementation()", opts):with_display "Implementation",
    ["n|<leader>gn"] = map_cr("Lspsaga rename", opts):with_display "Rename",
    ["n|<leader>gc"] = map_cr("lua vim.lsp.buf.declaration()", opts):with_display "Declaration",
    ["n|<leader>gu"] = map_cr("lua vim.lsp.buf.references()", opts):with_display "References",
    ["n|<leader>gf"] = map_cr("lua vim.lsp.buf.format { async = true }", opts):with_display "Format",
    ["v|<leader>gf"] = map_f(vim.lsp.buf.format):with_display "Format",
    ["n|<leader>gp"] = map_cr("Lspsaga show_cursor_diagnostics", opts):with_display "show cursor diagnostic",
  }
  if vim.fn.has "nvim-0.10" then
    m["n|<leader>gh"] = map_cr("lua vim.lsp.inlay_hint(0, nil)", opts):with_display "toggle inlay hint"
  end
  return m
end

function K.trouble()
  return {
    ["n|<leader>gq"] = display "Trouble",
    ["n|<leader>gq<space>"] = map_cr("TroubleToggle document_diagnostics"):with_display "Trouble File",
    ["n|<leader>gqw"] = map_cr("TroubleToggle workspace_diagnostics"):with_display "Trouble Workspace",
    ["n|<leader>gqf"] = map_cr("TroubleToggle quickfix"):with_display "Trouble Quickfix",
  }
end

function K.vista()
  return {
    ["n|<leader>ev"] = display "Vista",
    ["n|<leader>ev<space>"] = map_cr("Vista!!", opts),
    ["n|<leader>eva"] = map_cr("Vista ale", opts),
    ["n|<leader>evt"] = map_cr("Vista ctags", opts),
    ["n|<leader>evc"] = map_cr("Vista coc", opts),
    ["n|<leader>evl"] = map_cr("Vista lcn", opts),
    ["n|<leader>evn"] = map_cr("Vista nvim_lsp", opts),
    ["n|<leader>evL"] = map_cr("Vista vim_lsp", opts),
    ["n|<leader>evC"] = map_cr("Vista vim_lsc", opts),
  }
end

return K
