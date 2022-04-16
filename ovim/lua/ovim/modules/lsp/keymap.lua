-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for lsp
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require("ovim.misc.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local display = km.display
local K = {}
function K.lsp()
    return {
        ["n|<leader>l"] = display("LSP"),
        ["n|<leader>g"] = display("LSPAction"),
        ["n|<leader>li"] = map_cr("LspInfo"):with_display():with_noremap():with_silent():with_nowait(),
        ["n|<leader>lI"] = map_cr("LspInstallInfo"):with_display():with_noremap():with_silent():with_nowait(),
        ["n|<leader>ll"] = map_cr("LspInstallLog"):with_display():with_noremap():with_silent():with_nowait(),
        ["n|<leader>lr"] = map_cr("LspRestart"):with_display():with_noremap():with_silent():with_nowait(),
        ["n|<leader>lg"] = map_cr("LspStart"):with_display():with_noremap():with_silent():with_nowait(),
        ["n|<leader>ls"] = map_cr("LspStop"):with_display():with_noremap():with_silent():with_nowait(),
        ["n|<leader>g]"] = map_cr("Lspsaga diagnostic_jump_next"):with_display():with_noremap():with_silent(),
        ["n|<leader>g["] = map_cr("Lspsaga diagnostic_jump_prev"):with_display():with_noremap():with_silent(),
        ["n|<leader>gs"] = map_cr("Lspsaga signature_help"):with_display():with_noremap():with_silent(),
        ["n|<leader>gr"] = map_cr("Lspsaga rename"):with_display():with_noremap():with_silent(),
        ["n|<leader>g<space>"] = map_cr("Lspsaga hover_doc"):with_display():with_noremap():with_silent(),
        ["n|<C-Up>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(-1)"):with_noremap():with_silent(),
        ["n|<C-k>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(-1)"):with_noremap():with_silent(),
        ["n|<C-Down>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(1)"):with_noremap():with_silent(),
        ["n|<C-j>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(1)"):with_noremap():with_silent(),
        ["n|<leader>ga"] = map_cr("Lspsaga code_action"):with_display():with_noremap():with_silent(),
        ["v|<leader>ga"] = map_cu("Lspsaga range_code_action"):with_display():with_noremap():with_silent(),
        ["n|<leader>gd"] = map_cr("Lspsaga preview_definition"):with_display():with_noremap():with_silent(),
        ["n|<leader>gD"] = map_cr("lua vim.lsp.buf.definition()"):with_display("Definition"):with_noremap():with_silent(),
        ["n|<leader>gt"] = map_cr("lua vim.lsp.buf.type_definition()"):with_display("TypeDefinition"):with_noremap():with_silent(),
        ["n|<leader>gi"] = map_cr("lua vim.lsp.buf.implementation()"):with_display("Implementation"):with_noremap():with_silent(),
        ["n|<leader>gn"] = map_cr("Lspsaga rename"):with_display("Rename"):with_noremap():with_silent(),
        ["n|<leader>gc"] = map_cr("lua vim.lsp.buf.declaration()"):with_display("Declaration"):with_noremap():with_silent(),
        ["n|<leader>gu"] = map_cr("lua vim.lsp.buf.references()"):with_display("References"):with_noremap():with_silent(),
        ["n|<leader>gf"] = map_cr("lua vim.lsp.buf.formatting()"):with_display("Format"):with_noremap():with_silent(),
        ["n|<leader>gp"] = map_cr("Lspsaga show_cursor_diagnostics"):with_display("Show Cursor Diagnostic"):with_noremap():with_silent(),
    }
end

function K.trouble()
    return {
        ["n|<leader>gq"] = display("Trouble"),
        ["n|<leader>gq<space>"] = map_cr("TroubleToggle document_diagnostics"):with_display("Trouble File"):with_noremap():with_silent(),
        ["n|<leader>gqw"] = map_cr("TroubleToggle workspace_diagnostics"):with_display("Trouble Workspace"):with_noremap():with_silent(),
        ["n|<leader>gqf"] = map_cr("TroubleToggle quickfix"):with_display("Trouble Quickfix"):with_noremap():with_silent(),
    }
end

return K
