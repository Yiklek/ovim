return {
    name = 'completion',
    level = 1,
    plugins = {
        ["neovim/nvim-lspconfig"] = {
            "neovim/nvim-lspconfig",
            level = 1,
            opt = true,
            event = "VimEnter",
            config = [[require("ovim.modules.completion.config").nvim_lsp()]]
        },
        ["williamboman/nvim-lsp-installer"] = {
            "williamboman/nvim-lsp-installer",
            level = 1,
            opt = true,
            after = "nvim-lspconfig"
        }
    }
}

