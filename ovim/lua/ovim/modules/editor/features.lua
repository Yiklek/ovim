-- File: features.lua
-- Author: ovim
-- Description: editor features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

return {
    autopairs = function(p, opts)
        p["windwp/nvim-autopairs"] = {
"windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = [[require("ovim.misc.safe_require")("ovim.modules.editor.config").nvim_autopairs()]]
        }
    end,
    comment = function(p, opts)
        if opts.use ~= nil and opts.use == "nvim-comment" then
            p["terrortylor/nvim-comment"] = {
                "terrortylor/nvim-comment",
                event = "BufReadPost",
                config = [[require("ovim.misc.safe_require")("ovim.modules.editor.config").nvim_comment()]]
            }
        end
        if opts.use ~= nil and opts.use == "Comment.nvim" then
            p["numToStr/Comment.nvim"] = {
                "numToStr/Comment.nvim",
                event = "BufReadPost",
                config = [[require("ovim.misc.safe_require")("ovim.modules.editor.config").comment_dot_nvim()]]
            }
        end
    end,
    vcs = function (p, opts)
        p["lewis6991/gitsigns.nvim"] = {
            "lewis6991/gitsigns.nvim",
            event = "BufReadPost",
            config = [[require("ovim.misc.safe_require")("ovim.modules.editor.config").gitsigns()]]
        }
        p["sindrets/diffview.nvim"] = {
            "sindrets/diffview.nvim",
            config = [[require("ovim.misc.safe_require")("ovim.modules.editor.config").diffview()]],
            cmd = {"DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory"},
            -- require plenary in basic
            requires = nil,
        }
    end
}
