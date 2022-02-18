-- File: features.lua
-- Author: ovim
-- Description: ui features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

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
    end,
    fileTree = function(p, opts)
        p["kyazdani42/nvim-tree.lua"] = {
            "kyazdani42/nvim-tree.lua",
            opt = true,
            event = "BufRead",
            config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").nvim_tree()]]
        }
    end,
    devicons = function(p, opts)
        p["kyazdani42/nvim-web-devicons"] = {
            "kyazdani42/nvim-web-devicons",
            opt = true,
            event = "VimEnter"
        }
    end
}
