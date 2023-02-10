-- File: lsp/config.lua
-- Author: Yiklek
-- Description: lsp config
-- Copyright (c) 2022 Yiklek
local km = require("ovim.misc.keymap")
local keymap = require("ovim.modules.lsp.keymap")
local C = {}
function C.nvim_lsp()
    require("ovim.misc.safe_require")("ovim.modules.lsp.lsp_config")
end

function C.trouble()
    require("trouble").setup {}
    km.load(keymap.trouble())
end

function C.vista()
end

function C.lspsaga()
    local saga = require("lspsaga")
    saga.init_lsp_saga(
        {
            error_sign = " ",
            warn_sign = " ",
            hint_sign = " ",
            infor_sign = " "
        }
    )
end

function C.null_ls()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    -- local completion = null_ls.builtins.completion
    null_ls.setup({
        log_level = "error",
        sources = {
            formatting.stylua,
            formatting.autopep8,
            -- formatting.clang_format,
            formatting.gofmt,
            formatting.fixjson,
        },
    })
end

return C
