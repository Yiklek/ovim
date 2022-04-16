-- File: editor/config.lua
-- Author: Yiklek
-- Description: editor config
-- Copyright (c) 2022 Yiklek
local C = {}
local km = require("ovim.misc.keymap")
local keymap = require("ovim.modules.editor.keymap")
function C.nvim_autopairs()
   require("ovim.misc.safe_require")("nvim-autopairs").setup({})
end
function C.nvim_comment()
    km.load(keymap.nvim_comment())
    require("ovim.misc.safe_require")('nvim_comment').setup {comment_empty = false, line_mapping = "<leader>c<space>", operator_mapping = "<leader>c"}
end
return C
