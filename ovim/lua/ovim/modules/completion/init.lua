-- File: completion/init.lua
-- Author: Yiklek
-- Description: completion
-- Copyright (c) 2022 Yiklek
return {
    name = "completion",
    level = 1,
    condition = "vim.g['ovim#modules#autocomplete'] and vim.g['ovim#modules#autocomplete'].method == 'nvim_cmp'",
    plugins = {
        ["hrsh7th/nvim-cmp"] = {
            "hrsh7th/nvim-cmp",
            config = [[require("ovim.misc.safe_require")("ovim.modules.completion.config").nvim_cmp()]],
            event = "VimEnter",
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
                {"hrsh7th/cmp-cmdline", after = "cmp-spell"},
                {"kdheepak/cmp-latex-symbols", after = "cmp-buffer"},
                {"SirVer/ultisnips", setup = [[vim.cmd("source $OVIM_ROOT_PATH/plugins/ultisnips.vim")]], event = {"InsertEnter"}},
                {
                    "quangnguyen30192/cmp-nvim-ultisnips",
                    config = [[require("ovim.misc.safe_require")("cmp_nvim_ultisnips").setup{}]],
                    after = "ultisnips"
                },
                {"honza/vim-snippets", event = {"VimEnter"}},
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
            config = [[require("ovim.misc.safe_require")("ovim.modules.completion.config").lua_snip()]],
            requires = "rafamadriz/friendly-snippets"
        }
    }
}
