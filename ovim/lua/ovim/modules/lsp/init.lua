return {
    name = "lsp",
    level = 1,
    plugins = {
        ["neovim/nvim-lspconfig"] = {
            "neovim/nvim-lspconfig",
            level = 1,
            opt = true,
            event = "VimEnter",
            config = [[require("ovim.modules.lsp.config").nvim_lsp()]]
        },
        ["williamboman/nvim-lsp-installer"] = {
            "williamboman/nvim-lsp-installer",
            level = 1,
            opt = true,
            after = "nvim-lspconfig"
        },
        ["ray-x/lsp_signature.nvim"] = {"ray-x/lsp_signature.nvim", opt = true, after = "nvim-lspconfig"}
    }
}
