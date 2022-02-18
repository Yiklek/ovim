-- File: lsp/init.lua
-- Author: Yiklek
-- Description: lsp
-- Copyright (c) 2022 Yiklek
return {
    name = "lsp",
    level = 1,
    condition = "vim.g['ovim#modules#lsp'] and vim.g['ovim#modules#lsp'].method == 'nvim_lsp'",
    plugins = {
        ["neovim/nvim-lspconfig"] = {
            "neovim/nvim-lspconfig",
            level = 1,
            opt = true,
            event = "VimEnter",
            config = [[require("ovim.misc.safe_require")("ovim.modules.lsp.config").nvim_lsp()]]
        },
        ["williamboman/nvim-lsp-installer"] = {
            "williamboman/nvim-lsp-installer",
            level = 1,
            opt = true,
            after = "nvim-lspconfig"
        },
        ["ray-x/lsp_signature.nvim"] = {
            "ray-x/lsp_signature.nvim",
            opt = true,
            after = "nvim-lspconfig"
        },
        ["folke/trouble.nvim"] = {
            "folke/trouble.nvim",
            opt = true,
            event = "BufReadPost",
            config = [[require("ovim.misc.safe_require")("ovim.modules.lsp.config").trouble()]]
        }
    }
}
