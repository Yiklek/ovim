-- File: search/init.lua
-- Author: Yiklek
-- Description: search init
-- Copyright (c) 2022 Yiklek
return {
    name = "search",
    level = 1,
    plugins = {
        ["nvim-telescope/telescope.nvim"] = {
            "nvim-telescope/telescope.nvim",
            requires = {
                -- require plenary in basic
                {"nvim-lua/popup.nvim", opt = true}
            },
            level = 1,
            opt = true,
            cmd = "Telescope",
            event = "VimEnter",
            module = "telescope",
            config = [[require("ovim.misc.safe_require")("ovim.modules.search.config").telescope()]]
        },
        ["nvim-telescope/telescope-fzf-native.nvim"] = {
            "nvim-telescope/telescope-fzf-native.nvim",
            opt = true,
            run = "make",
            after = "telescope.nvim"
        },
        ["nvim-telescope/telescope-project.nvim"] = {
            "nvim-telescope/telescope-project.nvim",
            opt = true,
            after = "telescope-fzf-native.nvim",
            run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        },
        ["nvim-telescope/telescope-frecency.nvim"] = {
            "nvim-telescope/telescope-frecency.nvim",
            opt = true,
            after = "telescope-project.nvim",
            requires = {
                {
                    "tami5/sqlite.lua", opt = true,
                    config = [[require("ovim.misc.safe_require")("ovim.modules.search.config").sqlite()]],
                }
            }
        },
        ["jvgrootveld/telescope-zoxide"] = {
            "jvgrootveld/telescope-zoxide",
            opt = true,
            after = "telescope-frecency.nvim"
        },
        ["gbrlsnchs/telescope-lsp-handlers.nvim"] = {
            "gbrlsnchs/telescope-lsp-handlers.nvim",
            opt = true,
            after = "telescope.nvim"
        }
    }
}
