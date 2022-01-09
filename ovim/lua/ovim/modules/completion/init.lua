return {
    name = "completion",
    level = 1,
    plugins = {
        ["hrsh7th/nvim-cmp"] = {
            "hrsh7th/nvim-cmp",
            config = [[require("ovim.modules.completion.config").cmp()]],
            event = "InsertEnter",
            opt = true,
            requires = {
                {"lukas-reineke/cmp-under-comparator"},
                {"saadparwaiz1/cmp_luasnip", after = "LuaSnip"},
                {"hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip"},
                {"hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp"},
                {"andersevenrud/cmp-tmux", after = "cmp-nvim-lua"},
                {"hrsh7th/cmp-path", after = "cmp-tmux"},
                {"f3fora/cmp-spell", after = "cmp-path"},
                {"hrsh7th/cmp-buffer", after = "cmp-spell"},
                {"kdheepak/cmp-latex-symbols", after = "cmp-buffer"}
                -- {
                --     'tzachar/cmp-tabnine',
                --     run = './install.sh',
                --     after = 'cmp-spell',
                --     config = conf.tabnine
                -- }
            }
        },
        ["L3MON4D3/LuaSnip"] = {
            "L3MON4D3/LuaSnip",
            after = "nvim-cmp",
            opt = true,
            config = [[require("ovim.modules.completion.config").lua_snip()]],
            requires = "rafamadriz/friendly-snippets"
        },
    }
}
