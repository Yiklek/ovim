-- File: config.lua
-- Author: Yiklek
-- Description: global config
-- Copyright (c) 2022 Yiklek
return {
    level = 4,
    plugins = {},
    modules = {
        ui = {
            features = {
                basic = {
                    enable = true,
                },
                statusline = {
                    enable = true,
                    use = "lualine"
                },
                tabline = {
                    enable = true,
                    use = "bufferline"
                },
                treesitter = {
                    enable = true
                },
                fileTree = {
                    enable = true,
                    use = "NvimTree"
                },
                devicons = {
                    enable = true
                },
                indent = {
                    enable = true
                },
                which_key = {
                    enable = true
                },
                terminal = {
                    use = "floaterm",
                    enable = true
                },
                lsp_progress = {
                    enable = true,
                    use = "fidget",
                    -- use = "noice",
                    -- use = "lualine-lsp-progress",
                }
            }
        },
        editor = {
            features = {
                autopairs = {
                    enable = true
                },
                comment = {
                    enable = true,
                    use = "Comment.nvim"
                    -- use = "nvim-comment",
                },
                vcs = {
                    enable = true
                }
            }
        },
        lsp = {
            features = {
                vista = {
                    enable = true
                },
                lspsaga = {
                    enable = true
                }
            }
        },
        debug = {
            features = {
                dap = {
                    enable = true
                }
            }
        },
        search = {
            features = {
                ["telescope-fzf-native"] = {
                    enable = true
                },
                ["telescope-frecency"] = {
                    enable = true
                },
            }
        }
    }
}
