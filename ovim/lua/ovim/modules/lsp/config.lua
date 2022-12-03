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
return C
