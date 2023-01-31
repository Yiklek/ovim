-- File: lsp/init.lua
-- Author: Yiklek
-- Description: lsp
-- Copyright (c) 2022 Yiklek
local plugins = {
        ["neovim/nvim-lspconfig"] = {
            "neovim/nvim-lspconfig",
            level = 1,
            opt = true,
            event = "VimEnter",
            config = [[require("ovim.misc.safe_require")("ovim.modules.lsp.config").nvim_lsp()]]
        },
        ["williamboman/mason.nvim"] = {
            "williamboman/mason.nvim",
            level = 1,
            opt = true,
            after = "nvim-lspconfig"
        },
        ["williamboman/mason-lspconfig.nvim"] = {
            "williamboman/mason-lspconfig.nvim",
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
        },
        ["jose-elias-alvarez/null-ls.nvim"] = {
            "jose-elias-alvarez/null-ls.nvim",
            opt = true,
            event = "BufReadPost",
            config = [[require("ovim.misc.safe_require")("ovim.modules.lsp.config").null_ls()]]
        }
    }
local features = require("ovim.misc.features").setup_module_features("lsp", plugins)
return {
    name = "lsp",
    level = 1,
    condition = "vim.g['ovim#modules#lsp'] and vim.g['ovim#modules#lsp'].method == 'nvim_lsp'",
    plugins = plugins,
    features = features,
}
