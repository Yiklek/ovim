-- File: features.lua
-- Author: ovim
-- Description: ui features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

return {
    basic = function(p, opts)
        p["stevearc/dressing.nvim"] = {
            "stevearc/dressing.nvim",
            event = "VeryLazy",
            config = function()
                require("ovim.misc.safe_require")("ovim.modules.ui.config").dressing()
            end
        }
        p["folke/noice.nvim"] = {
            "folke/noice.nvim",
            event = "VimEnter",
            config = function()
                require("ovim.misc.safe_require")("ovim.modules.ui.config").noice()
            end,
            dependencies = {
                "MunifTanjim/nui.nvim",
                "rcarriga/nvim-notify",
            }
        }
    end,
    statusline = function(p, opts)
        p["hoob3rt/lualine.nvim"] = {
            "hoob3rt/lualine.nvim",
            event = "VimEnter",
            config = function()
                require("ovim.misc.safe_require")("ovim.modules.ui.config").lualine()
            end,
            dependencies = {
                {
                    "SmiteshP/nvim-gps",
                    dependencies = {
                        { "nvim-treesitter" }
                    },
                    config = function()
                        require("ovim.misc.safe_require")("ovim.modules.ui.config").nvim_gps()
                    end
                }
            }
        }
    end,
    tabline = function(p, opts)
        p["akinsho/bufferline.nvim"] = {
            "akinsho/bufferline.nvim",
            event = "VeryLazy",
            config = function()
                require("ovim.misc.safe_require")("ovim.modules.ui.config").bufferline()
            end
        }
    end,
    treesitter = function(p, opts)
        p["nvim-treesitter/nvim-treesitter"] = {
            "nvim-treesitter/nvim-treesitter",
            event = "VeryLazy",
            config = function()
                require("ovim.misc.safe_require")("ovim.modules.ui.config").nvim_treesitter()
            end,
            dependencies = {
                "nvim-treesitter/nvim-treesitter-textobjects",
                "p00f/nvim-ts-rainbow",
                "nvim-treesitter/nvim-treesitter-refactor",

            }
        }
    end,
    fileTree = function(p, opts)
        if require("ovim.config").modules.ui.features.fileTree.use == "NvimTree" then
            p["kyazdani42/nvim-tree.lua"] = {
                "kyazdani42/nvim-tree.lua",
                event = "VeryLazy",
                config = function()
                    require("ovim.misc.safe_require")("ovim.modules.ui.config").nvim_tree()
                end
            }
        end
    end,
    devicons = function(p, opts)
        p["kyazdani42/nvim-web-devicons"] = {
            "kyazdani42/nvim-web-devicons",
            event = "VeryLazy"
        }
        p["ryanoasis/vim-devicons"] = {
            "ryanoasis/vim-devicons",
            event = "VeryLazy"
        }
    end,
    indent = function(p, opts)
        if opts.use == nil or opts.use == "blankline" then
            p["lukas-reineke/indent-blankline.nvim"] = {
                "lukas-reineke/indent-blankline.nvim",
                event = "BufRead",
                config = function()
                    require("ovim.misc.safe_require")("ovim.modules.ui.config").indent_blankline()
                end
            }
        end
        if opts.use == "guides" then
            p["glepnir/indent-guides.nvim"] = {
                "glepnir/indent-guides.nvim",
                event = "BufRead",
                config = function()
                    require("ovim.misc.safe_require")("ovim.modules.ui.config").indent_guides()
                end
            }
        end
    end,
    which_key = function(p, opts)
        p["folke/which-key.nvim"] = {
            "folke/which-key.nvim",
            lazy = true,
            config = function()
                require("ovim.misc.safe_require")("ovim.modules.ui.config").which_key()
            end,
            -- event = { "InsertChange", "InsertEnter", "InsertLeave", "CursorMoved", "CursorMovedI", "CursorHold" }
            event = "VeryLazy"
        }
    end,
    terminal = function(p, opts)
        if opts.use ~= nil and opts.use == "toggleterm" then
            p["akinsho/toggleterm.nvim"] = {
                "akinsho/toggleterm.nvim",
                config = function()
                    require("ovim.misc.safe_require")("ovim.modules.ui.config").toggleterm()
                end,
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
                cmd = { "FloatermToggle", "FloatermPrev", "FloatermNext", "FloatermNew", "FloatermFirst", "FloatermLast",
                    "FloatermKill", "FloatermShow", "FloatermHide", "FloatermUpdate" },
                config = function()
                    require("ovim.misc.safe_require")("ovim.modules.ui.config").floaterm()
                end,
            }
        end
    end,
    lsp_progress = function(p, opts)
        if opts.use == "fidget" then
            p["j-hui/fidget.nvim"] = {
                "j-hui/fidget.nvim",
                config = function()
                    require("ovim.misc.safe_require")("fidget").setup()
                end,
                event = { "VeryLazy" }
            }
        elseif opts.use == "lualine-lsp-progress" then
            p["arkav/lualine-lsp-progress"] = {
                "arkav/lualine-lsp-progress",
                event = { "VeryLazy" }
            }
        end
    end,
    dashboard = function(p, opts)

        if opts.use == "dashboard-nvim" then
            p["glepnir/dashboard-nvim"] = {
                'glepnir/dashboard-nvim',
                event = 'VimEnter',
                opts = {
                    theme = 'hyper',
                    config = {
                        header = {
                            '',
                            ' ██████╗ ██╗   ██╗██╗███╗   ███╗',
                            '██╔═══██╗██║   ██║██║████╗ ████║',
                            '██║   ██║██║   ██║██║██╔████╔██║',
                            '██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
                            '╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
                            ' ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
                            '',
                        },
                        week_header = {
                            enable = false,
                        },
                        shortcut = {
                            { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
                            {
                                desc = ' Files',
                                group = 'Label',
                                action = 'Telescope find_files',
                                key = 'f',
                            },
                            {
                                desc = 'Oldfiles',
                                action = 'Telescope oldfiles',
                                key = 'o',
                            },
                        },
                    },
                },
                dependencies = { { 'nvim-web-devicons' } }
            }
        end
    end
}
