-- File: search/config.lua
-- Author: Yiklek
-- Description: search config
-- Copyright (c) 2022 Yiklek
local function telescope()
    vim.cmd([[packadd sqlite.lua]])
    vim.cmd([[packadd telescope-fzf-native.nvim]])
    vim.cmd([[packadd telescope-project.nvim]])
    vim.cmd([[packadd telescope-frecency.nvim]])
    vim.cmd([[packadd telescope-zoxide]])

    local telescope_db = vim.g.ovim_cache_path .. "/plugins/telescope"
    vim.fn.mkdir(telescope_db, "p")

    require("telescope").setup(
        {
            defaults = {
                prompt_prefix = "🔭 ",
                selection_caret = " ",
                layout_config = {
                    horizontal = {prompt_position = "bottom", results_width = 0.6},
                    vertical = {mirror = false}
                },
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = {},
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                path_display = {"absolute"},
                winblend = 0,
                border = {},
                borderchars = {
                    "─",
                    "│",
                    "─",
                    "│",
                    "╭",
                    "╮",
                    "╯",
                    "╰"
                },
                color_devicons = true,
                use_less = true,
                set_env = {["COLORTERM"] = "truecolor"}
            },
            extensions = {
                fzf = {
                    fuzzy = false, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                frecency = {
                    db_root = telescope_db,
                    show_scores = true,
                    show_unindexed = true,
                    ignore_patterns = {"*.git/*", "*/tmp/*"}
                }
            }
        }
    )

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("project")
    require("telescope").load_extension("zoxide")
    require("telescope").load_extension("frecency")
end

return {
    telescope = telescope
}
