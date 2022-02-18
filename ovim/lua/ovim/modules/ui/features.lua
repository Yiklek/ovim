return {
    statusline = function(p, opts)
        p["hoob3rt/lualine.nvim"] = {
            "hoob3rt/lualine.nvim",
            opt = true,
            after = "lualine-lsp-progress",
            config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").lualine()]]
        }
        p["arkav/lualine-lsp-progress"] = {
            "arkav/lualine-lsp-progress",
            opt = true,
            after = "nvim-gps"
        }
        p["SmiteshP/nvim-gps"] = {
            "SmiteshP/nvim-gps",
            opt = true,
            after = "nvim-treesitter",
            config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").nvim_gps()]]
        }
    end,
    tabline = function(p, opts)
        p["akinsho/bufferline.nvim"] = {
            "akinsho/bufferline.nvim",
            opt = true,
            event = "VimEnter",
            config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").bufferline()]]
        }
    end,
    treesitter = function(p, opts)
        p["nvim-treesitter/nvim-treesitter"] = {
            "nvim-treesitter/nvim-treesitter",
            event = "VimEnter",
            opt = true,
            config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").nvim_treesitter()]]
        }
        p["nvim-treesitter/nvim-treesitter-textobjects"] = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            opt = true,
            after = "nvim-treesitter"
        }
        p["p00f/nvim-ts-rainbow"] = {
            "p00f/nvim-ts-rainbow",
            opt = true,
            after = "nvim-treesitter"
        }
        p["nvim-treesitter/nvim-treesitter-refactor"] = {
            "nvim-treesitter/nvim-treesitter-refactor",
            opt = true,
            after = "nvim-treesitter"
        }
    end
}
