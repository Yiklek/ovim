-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for editor
-- Last Modified: 04 16, 2022
-- Copyright (c) 2022 ovim

local K = {}

local km = require("ovim.misc.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local display = km.display

function K.nvim_comment()
    return {
        ["n|<leader>c"] = display("Comment")
    }
end

function K.gitsigns()
    local opts = {
        display = {
            enable = true
        },
        map = {
            silent = true,
            nowait = true
        }
    }
    return {
        ["n|<leader>eh"] = display("VCS"),
        ["n|<leader>ehj"] = map_cr("Gitsigns next_hunk", opts),
        ["n|<leader>ehk"] = map_cr("Gitsigns prev_hunk", opts),
        ["n|]h"] = map_cr("Gitsigns next_hunk", opts),
        ["n|[h"] = map_cr("Gitsigns prev_hunk", opts),
        ["n|<leader>ehs"] = map_cr("Gitsigns stage_hunk", opts),
        ["n|<leader>ehr"] = map_cr("Gitsigns reset_hunk", opts),
        ["n|<leader>ehu"] = map_cr("Gitsigns undo_stage_hunk", opts),
        ["n|<leader>ehS"] = map_cr("Gitsigns stage_buffer", opts),
        ["n|<leader>ehR"] = map_cr("Gitsigns reset_buffer", opts),
        ["n|<leader>ehp"] = map_cr("Gitsigns preview_hunk", opts),
        ["n|<leader>ehB"] = map_cr([[lua require"gitsigns".blame_line{full=true}]], opts):with_display("Gitsigns BlameLineFull"),
        ["n|<leader>ehb"] = map_cr("Gitsigns toggle_current_line_blame", opts):with_display("Gitsigns BlameLine"),
        ["n|<leader>ehd"] = map_cr("Gitsigns diffthis", opts):with_display("Gitsigns Diffthis"),
        ["n|<leader>ehD"] = map_cr([[lua require"gitsigns".diffthis("~")]], opts):with_display("Gitsigns Diffthis~"),
        ["o|ih"] = map_cu("Gitsigns select_hunk"),
        ["x|ih"] = map_cu("Gitsigns select_hunk"),
    }
end

return K
