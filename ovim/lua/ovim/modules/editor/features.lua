-- File: features.lua
-- Author: ovim
-- Description: editor features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

return {
    autopairs = function(p, opts)
        p["windwp/nvim-autopairs"] = {
            "windwp/nvim-autopairs",
            event = "BufReadPost",
            config = function()
                require("ovim.misc.safe_require")("ovim.modules.editor.config").nvim_autopairs()
            end
        }
    end,
    comment = function(p, opts)
        if opts.use ~= nil and opts.use == "nvim-comment" then
            p["terrortylor/nvim-comment"] = {
                "terrortylor/nvim-comment",
                event = "BufReadPost",
                config = function()
                    require("ovim.misc.safe_require")("ovim.modules.editor.config").nvim_comment()
                end
            }
        end
        if opts.use ~= nil and opts.use == "Comment.nvim" then
            p["numToStr/Comment.nvim"] = {
                "numToStr/Comment.nvim",
                event = "BufReadPost",
                config = function()
                    require("ovim.misc.safe_require")("ovim.modules.editor.config").comment_dot_nvim()
                end
            }
        end
    end,
    vcs = function (p, opts)
        p["lewis6991/gitsigns.nvim"] = {
            "lewis6991/gitsigns.nvim",
            event = "BufReadPost",
            config = function()
                require("ovim.misc.safe_require")("ovim.modules.editor.config").gitsigns()
            end
        }
        p["sindrets/diffview.nvim"] = {
            "sindrets/diffview.nvim",
            config = function()
                require("ovim.misc.safe_require")("ovim.modules.editor.config").diffview()
            end,
            cmd = {"DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory"},
            -- require plenary in basic
            dependencies = {
                "nvim-lua/plenary.nvim"
            },
        }
    end
}
