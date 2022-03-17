-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for lsp
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require("ovim.misc.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd

local function lsp()
    return {
        ["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
        ["n|<leader>lr"] = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
        ["n|<leader>g["] = map_cr("Lspsaga diagnostic_jump_next"):with_noremap():with_silent(),
        ["n|<leader>g]"] = map_cr("Lspsaga diagnostic_jump_prev"):with_noremap():with_silent(),
        ["n|<leader>gs"] = map_cr("Lspsaga signature_help"):with_noremap():with_silent(),
        ["n|<leader>gr"] = map_cr("Lspsaga rename"):with_noremap():with_silent(),
        ["n|<leader>g<space>"] = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
        ["n|<C-Up>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(-1)"):with_noremap():with_silent(),
        ["n|<C-Down>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(1)"):with_noremap():with_silent(),
        ["n|<leader>ga"] = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
        ["v|<leader>ga"] = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),
        ["n|<leader>gd"] = map_cr("Lspsaga preview_definition"):with_noremap():with_silent(),
        ["n|<leader>gD"] = map_cr("lua vim.lsp.buf.definition()"):with_noremap():with_silent(),
        ["n|<leader>gt"] = map_cr("lua vim.lsp.buf.type_definition()"):with_noremap():with_silent(),
        ["n|<leader>gi"] = map_cr("lua vim.lsp.buf.implementation()"):with_noremap():with_silent(),
        ["n|<leader>gn"] = map_cr("Lspsaga rename"):with_noremap():with_silent(),
        ["n|<leader>gc"] = map_cr("lua vim.lsp.buf.declaration()"):with_noremap():with_silent(),
        ["n|<leader>gu"] = map_cr("lua vim.lsp.buf.references()"):with_noremap():with_silent(),
        ["n|<leader>gf"] = map_cr("lua vim.lsp.buf.formatting()"):with_noremap():with_silent(),
    }
end 
return {
    lsp = lsp
}
