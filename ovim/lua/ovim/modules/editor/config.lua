-- File: editor/config.lua
-- Author: Yiklek
-- Description: editor config
-- Copyright (c) 2022 Yiklek
local C = {}
local km = require("ovim.core.keymap")
local keymap = require("ovim.modules.editor.keymap")
function C.nvim_autopairs()
  require("ovim.core.safe_require")("nvim-autopairs").setup {}
end
function C.nvim_comment()
  km.load(keymap.nvim_comment())
  require("ovim.core.safe_require")("nvim_comment").setup {
    comment_empty = false,
    line_mapping = "<leader>c<space>",
    operator_mapping = "<leader>c",
  }
end

function C.comment_dot_nvim()
  km.load(keymap.comment_dot_nvim())
  require("ovim.core.safe_require")("Comment").setup {
    toggler = {
      ---Line-comment toggle keymap
      line = "<leader>c<space>",
      ---Block-comment toggle keymap
      block = "<leader>cb",
    },
    ---LHS of operator-pending mappings in NORMAL mode
    ---LHS of mapping in VISUAL mode
    ---@type table
    opleader = {
      ---Line-comment keymap
      line = "<leader>c<space>",
      ---Block-comment keymap
      block = "<leader>cb",
    },
    extra = {
      ---Add comment on the line above
      above = "<leader>cO",
      ---Add comment on the line below
      below = "<leader>co",
      ---Add comment at the end of line
      eol = "<leader>cA",
    },
  }
end

function C.gitsigns()
  require("ovim.core.safe_require")("gitsigns").setup {
    on_attach = function(bufnr)
      local opts = {
        map = {
          buffer = nil,
        },
      }
      km.load(keymap.gitsigns(), opts)
    end,
  }
end

function C.diffview()
  local cb = require("diffview.config").diffview_callback
  require("diffview").setup()
end

return C
