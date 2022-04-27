-- File: features.lua
-- Author: ovim
-- Description: editor features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

return {
    vista = function(p, opts)
        p["liuchengxu/vista.vim"] = {
            "liuchengxu/vista.vim",
            cmd = { "Vista", "Vista!", "Vista!!",},
            config = [[require("ovim.misc.safe_require")("ovim.modules.lsp.config").vista()]]
        }
    end,
    lspsaga = function(p, opts)
        p["tami5/lspsaga.nvim"] = {
            "tami5/lspsaga.nvim",
            opt = true,
            after = "nvim-lspconfig",
            event = "BufRead",
            config = [[require("ovim.misc.safe_require")("ovim.modules.lsp.config").lspsaga()]]
        }
    end,
}
