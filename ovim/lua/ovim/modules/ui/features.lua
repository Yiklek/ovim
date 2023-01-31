-- File: features.lua
-- Author: ovim
-- Description: ui features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

return {
    basic = function(p, opts)
        p["stevearc/dressing.nvim"] = {
            "stevearc/dressing.nvim",
            opt = true,
            event = "VimEnter",
            config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").dressing()]]
        }
        p["MunifTanjim/nui.nvim"] = {
            "MunifTanjim/nui.nvim",
            opt = true,
            event = "VimEnter",
            module = "ui-dep"
        }
        p["rcarriga/nvim-notify"] = {
            "rcarriga/nvim-notify",
            opt = true,
            event = "VimEnter",
            module = "ui-dep"
        }
        p["folke/noice.nvim"] = {
            "folke/noice.nvim",
            opt = true,
            event = "VimEnter",
            config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").noice()]],
            requires = {
                -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
                "MunifTanjim/nui.nvim",
                -- OPTIONAL:
                --   `nvim-notify` is only needed, if you want to use the notification view.
                --   If not available, we use `mini` as the fallback
                "rcarriga/nvim-notify",
            }
        }
    end,
    statusline = function(p, opts)
        p["hoob3rt/lualine.nvim"] = {
            "hoob3rt/lualine.nvim",
            opt = true,
            event = "VimEnter",
            config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").lualine()]]
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
        p["ryanoasis/vim-devicons"] = {
            "ryanoasis/vim-devicons",
            opt = false,
        }
    end,
    indent = function(p, opts)
        if opts.use == nil or opts.use == "blankline" then
            p["lukas-reineke/indent-blankline.nvim"] = {
                "lukas-reineke/indent-blankline.nvim",
                opt = true,
                event = "VimEnter",
                config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").indent_blankline()]]
            }
        end
        if opts.use == "guides" then
            p["glepnir/indent-guides.nvim"] = {
                "glepnir/indent-guides.nvim",
                event = "VimEnter",
                opt = true,
                config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").indent_guides()]]
            }
        end
    end,
    which_key = function(p, opts)
        p["folke/which-key.nvim"] = {
            "folke/which-key.nvim",
            config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").which_key()]],
            opt = true,
            event = { "InsertChange", "InsertEnter", "InsertLeave", "CursorMoved", "CursorMovedI", "CursorHold" }
        }
    end,
    terminal = function(p, opts)
        if opts.use ~= nil and opts.use == "toggleterm" then
            p["akinsho/toggleterm.nvim"] = {
                "akinsho/toggleterm.nvim",
                config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").toggleterm()]],
                opt = true,
                cmd = { "ToggleTerm",
                    "ToggleTermToggleAll",
                    "ToggleTermSendCurrentLine",
                    "ToggleTermSendVisualLines",
                    "ToggleTermSendVisualSelection",
                }
            }

        elseif opts.use ~= nil and opts.use == "floaterm" then
            p["voldikss/vim-floaterm"] = {
                "voldikss/vim-floaterm",
                opt = true,
                cmd = { "FloatermToggle", "FloatermPrev", "FloatermNext", "FloatermNew", "FloatermFirst", "FloatermLast",
                    "FloatermKill", "FloatermShow", "FloatermHide", "FloatermUpdate" },
                setup = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").floaterm()]],
            }
        end
    end,
    lsp_progress = function(p, opts)
        if opts.use == "fidget" then
            p["j-hui/fidget.nvim"] = {
                "j-hui/fidget.nvim",
                config = [[require("ovim.misc.safe_require")("fidget").setup()]],
                opt = true,
                event = { "VimEnter" }
            }
        elseif opts.use == "lualine-lsp-progress" then
            p["arkav/lualine-lsp-progress"] = {
                "arkav/lualine-lsp-progress",
                opt = true,
                event = { "VimEnter" }
            }
        end
    end,
}
