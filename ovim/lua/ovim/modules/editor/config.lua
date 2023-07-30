-- File: editor/config.lua
-- Author: Yiklek
-- Description: editor config
-- Copyright (c) 2022 Yiklek
local C = {}
local km = require "ovim.misc.keymap"
local keymap = require "ovim.modules.editor.keymap"
function C.nvim_autopairs()
  require "ovim.misc.safe_require"("nvim-autopairs").setup {}
end
function C.nvim_comment()
  km.load(keymap.nvim_comment())
  require "ovim.misc.safe_require"("nvim_comment").setup {
    comment_empty = false,
    line_mapping = "<leader>c<space>",
    operator_mapping = "<leader>c",
  }
end

function C.comment_dot_nvim()
  km.load(keymap.comment_dot_nvim())
  require "ovim.misc.safe_require"("Comment").setup {
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
  require "ovim.misc.safe_require"("gitsigns").setup {
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

  require("diffview").setup {
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
    use_icons = true, -- Requires nvim-web-devicons
    icons = { -- Only applies when use_icons is true.
      folder_closed = "",
      folder_open = "",
    },
    signs = {
      fold_closed = "",
      fold_open = "",
    },
    file_panel = {
      position = "left", -- One of 'left', 'right', 'top', 'bottom'
      width = 35, -- Only applies when position is 'left' or 'right'
      height = 10, -- Only applies when position is 'top' or 'bottom'
      listing_style = "tree", -- One of 'list' or 'tree'
      tree_options = { -- Only applies when listing_style is 'tree'
        flatten_dirs = true, -- Flatten dirs that only contain one single dir
        folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
      },
    },
    file_history_panel = {
      position = "bottom",
      width = 35,
      height = 16,
      log_options = {
        max_count = 256, -- Limit the number of commits
        follow = false, -- Follow renames (only for single file)
        all = false, -- Include all refs under 'refs/' including HEAD
        merges = false, -- List only merge commits
        no_merges = false, -- List no merge commits
        reverse = false, -- List commits in reverse order
      },
    },
    default_args = { -- Default args prepended to the arg-list for the listed commands
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {}, -- See ':h diffview-config-hooks'
    key_bindings = {
      disable_defaults = false, -- Disable the default key bindings
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      view = {
        ["<tab>"] = cb "select_next_entry", -- Open the diff for the next file
        ["<s-tab>"] = cb "select_prev_entry", -- Open the diff for the previous file
        ["gf"] = cb "goto_file", -- Open the file in a new split in previous tabpage
        ["<C-w><C-f>"] = cb "goto_file_split", -- Open the file in a new split
        ["<C-w>gf"] = cb "goto_file_tab", -- Open the file in a new tabpage
        ["<leader>e"] = cb "focus_files", -- Bring focus to the files panel
        ["<leader>b"] = cb "toggle_files", -- Toggle the files panel.
      },
      file_panel = {
        ["j"] = cb "next_entry", -- Bring the cursor to the next file entry
        ["<down>"] = cb "next_entry",
        ["k"] = cb "prev_entry", -- Bring the cursor to the previous file entry.
        ["<up>"] = cb "prev_entry",
        ["<cr>"] = cb "select_entry", -- Open the diff for the selected entry.
        ["o"] = cb "select_entry",
        ["<2-LeftMouse>"] = cb "select_entry",
        ["<Space>"] = cb "toggle_stage_entry", -- Stage / unstage the selected entry.
        ["S"] = cb "stage_all", -- Stage all entries.
        ["U"] = cb "unstage_all", -- Unstage all entries.
        ["r"] = cb "restore_entry", -- Restore entry to the state on the left side.
        ["R"] = cb "refresh_files", -- Update stats and entries in the file list.
        ["<tab>"] = cb "select_next_entry",
        ["<s-tab>"] = cb "select_prev_entry",
        ["gf"] = cb "goto_file",
        ["<C-w><C-f>"] = cb "goto_file_split",
        ["<C-w>gf"] = cb "goto_file_tab",
        ["i"] = cb "listing_style", -- Toggle between 'list' and 'tree' views
        ["f"] = cb "toggle_flatten_dirs", -- Flatten empty subdirectories in tree listing style.
        ["<leader>e"] = cb "focus_files",
        ["<leader>b"] = cb "toggle_files",
      },
      file_history_panel = {
        ["g!"] = cb "options", -- Open the option panel
        ["<C-A-d>"] = cb "open_in_diffview", -- Open the entry under the cursor in a diffview
        ["y"] = cb "copy_hash", -- Copy the commit hash of the entry under the cursor
        ["zR"] = cb "open_all_folds",
        ["zM"] = cb "close_all_folds",
        ["j"] = cb "next_entry",
        ["<down>"] = cb "next_entry",
        ["k"] = cb "prev_entry",
        ["<up>"] = cb "prev_entry",
        ["<cr>"] = cb "select_entry",
        ["o"] = cb "select_entry",
        ["<2-LeftMouse>"] = cb "select_entry",
        ["<tab>"] = cb "select_next_entry",
        ["<s-tab>"] = cb "select_prev_entry",
        ["gf"] = cb "goto_file",
        ["<C-w><C-f>"] = cb "goto_file_split",
        ["<C-w>gf"] = cb "goto_file_tab",
        ["<leader>e"] = cb "focus_files",
        ["<leader>b"] = cb "toggle_files",
      },
      option_panel = {
        ["<tab>"] = cb "select",
        ["q"] = cb "close",
      },
    },
  }
end

return C
