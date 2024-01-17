-- File: search/config.lua
-- Author: Yiklek
-- Description: search config
-- Copyright (c) 2022 Yiklek
local C = {}
local km = require("ovim.core.keymap")
local keymap = require("ovim.modules.search.keymap")
local config_features = require("ovim.config").modules.search.features
local function telescope_fzf_native()
  -- telescope-fzf-native
  local fzf = nil
  if config_features["telescope-fzf-native"].enable and vim.fn.executable("cmake") ~= 0 then
    local fzf_native_plugin_path = ovim.const.cache_path .. "/lazy/plugins/telescope-fzf-native.nvim"
    local fzf_native_plugin_build_path = fzf_native_plugin_path .. "/build"
    if vim.fn.isdirectory(fzf_native_plugin_build_path) == 0 then
      vim.cmd(vim.fn.join({ "silent !cmake", "-S", fzf_native_plugin_path, "-B", fzf_native_plugin_build_path }, " "))
      vim.cmd(vim.fn.join({ "silent !cmake", "--build", fzf_native_plugin_build_path, "--config Release" }, " "))
      vim.cmd(vim.fn.join({
        "silent !cmake",
        "--install",
        fzf_native_plugin_build_path,
        "--install",
        fzf_native_plugin_build_path,
      }, " "))
    end
    fzf = {
      fuzzy = false, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  end
  return fzf
end

local function telescope_frecency()
  local frecency = nil
  if config_features["telescope-frecency"].enable then
    local telescope_db = ovim.const.cache_path .. "/plugins/telescope"
    vim.fn.mkdir(telescope_db, "p")
    frecency = {
      db_root = telescope_db,
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = { "*.git/*", "*/tmp/*" },
    }
  end
  return frecency
end
local function telescope_undo()
  return {
    use_delta = true,
    use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
    side_by_side = true,
    diff_context_lines = vim.o.scrolloff,
    entry_format = "state #$ID, $STAT, $TIME",
    mappings = {
      i = {
        -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
        -- you want to replicate these defaults and use the following actions. This means
        -- installing as a dependency of telescope in it's `requirements` and loading this
        -- extension from there instead of having the separate plugin definition as outlined
        -- above.
        ["<cr>"] = require("telescope-undo.actions").yank_additions,
        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
        ["<C-cr>"] = require("telescope-undo.actions").restore,
      },
    },
  }
end
function C.telescope()
  -- telescope-fzf-native
  local fzf = telescope_fzf_native()

  -- telescope-frecency
  local frecency = telescope_frecency()
  local action_layout = require("telescope.actions.layout")

  -- telescope-undo
  local undo = telescope_undo()
  require("telescope").setup {
    defaults = {
      sorting_strategy = "ascending",
      mappings = {
        i = {
          ["<C-o>"] = action_layout.toggle_preview,
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
      prompt_prefix = "🔎 ",
      selection_caret = " ",
      layout_config = {
        horizontal = { prompt_position = "top", results_width = 0.8 },
        vertical = { mirror = false },
      },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      winblend = 10,
      border = {},
      borderchars = {
        "─",
        "│",
        "─",
        "│",
        "╭",
        "╮",
        "╯",
        "╰",
      },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" },
    },
    pickers = {
      find_files = {
        previewer = false,
      },
      oldfiles = {
        previewer = false,
      },
    },
    extensions = {
      fzf = fzf,
      frecency = frecency,
      undo = undo,
    },
  }
  require("telescope").load_extension("project")
  require("telescope").load_extension("zoxide")
  require("telescope").load_extension("lsp_handlers")
  require("telescope").load_extension("undo")
  require("telescope").load_extension("frecency")
  require("telescope").load_extension("fzf")
end

return C
