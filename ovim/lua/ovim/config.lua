-- File: config.lua
-- Author: Yiklek
-- Description: global config
-- Copyright (c) 2022 Yiklek
return {
    plugins = {},
    modules = {
        ui = {
            features = {
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
                    enable = true
                },
                devicons = {
                    enable = true
                },
                indent = {
                    enable = true
                },
                which_key = {
                    enable = true
                }
            }
        },
        editor = {
            features = {
                autopairs = {
                    enable = true
                },
                comment = {
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
        }
    }
}
