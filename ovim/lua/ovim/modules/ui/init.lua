return {
    name = "ui",
    level = 1,
    plugins = {
        ["glepnir/indent-guides.nvim"] = {
            "glepnir/indent-guides.nvim",
            event = "VimEnter",
            opt = true,
            config = [[require("ovim.pack").require("ovim.modules.ui.config").indent_guides()]]
        },
        ["nvim-treesitter/nvim-treesitter"] = {
            "nvim-treesitter/nvim-treesitter",
            event = "VimEnter",
            opt = true,
            config = [[require("ovim.pack").require("ovim.modules.ui.config").nvim_treesitter()]]
        },
        ["nvim-treesitter/nvim-treesitter-textobjects"] = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            opt = true,
            after = "nvim-treesitter"
        },
        ["p00f/nvim-ts-rainbow"] = {
            "p00f/nvim-ts-rainbow",
            opt = true,
            after = "nvim-treesitter"
        },
        ["nvim-treesitter/nvim-treesitter-refactor"] = {
            "nvim-treesitter/nvim-treesitter-refactor",
            opt = true,
            after = "nvim-treesitter"
        },
        ["SmiteshP/nvim-gps"] = {
            "SmiteshP/nvim-gps",
            opt = true,
            after = "nvim-treesitter",
            config = [[require("ovim.pack").require("ovim.modules.ui.config").nvim_gps()]]
        },
        ["hoob3rt/lualine.nvim"] = {
            "hoob3rt/lualine.nvim",
            opt = true,
            after = "lualine-lsp-progress",
            config = [[require("ovim.pack").require("ovim.modules.ui.config").lualine()]]
        },
        ["arkav/lualine-lsp-progress"] = {
            "arkav/lualine-lsp-progress",
            opt = true,
            after = "nvim-gps"
        }
    }
}
