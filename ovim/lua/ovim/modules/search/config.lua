-- File: search/config.lua
-- Author: Yiklek
-- Description: search config
-- Copyright (c) 2022 Yiklek
local C = {}
local km = require("ovim.misc.keymap")
local keymap = require("ovim.modules.search.keymap")
function C.telescope()
    require("packer.load")({"plenary.nvim", "telescope-project.nvim", "telescope-zoxide"}, {}, _G.packer_plugins)
    require("telescope").load_extension("project")
    require("telescope").load_extension("zoxide")

    -- telescope-fzf-native
    local fzf = nil
    if (vim.fn.executable("gcc") and vim.fn.executable("fzf")) ~= 0 then
        require("packer.load")({"telescope-fzf-native.nvim"}, {}, _G.packer_plugins)
        require("telescope").load_extension("fzf")
        fzf = {
            fuzzy = false, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    end

    -- telescope-frecency
    local telescope_db = vim.g.ovim_cache_path .. "/plugins/telescope"
    vim.fn.mkdir(telescope_db, "p")
    require("packer.load")({"sqlite.lua", "telescope-frecency.nvim"}, {}, _G.packer_plugins)
    require("telescope").load_extension("frecency")
    local frecency = {
        db_root = telescope_db,
        show_scores = true,
        show_unindexed = true,
        ignore_patterns = {"*.git/*", "*/tmp/*"}
    }
    if require("ovim.misc.util").has_win()
        and (vim.g.sqlite_clib_path == nil or vim.fn.filereadable(vim.g.sqlite_clib_path) == 0) then
        frecency = nil
    end

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
                fzf = fzf,
                frecency = frecency
            }
        }
    )

    km.load(keymap.telescope())
end

function C.sqlite()
    local sqlite_dir = vim.g.ovim_cache_path .. "/plugins/sqlite"
    if require("ovim.misc.util").has_win() then
        local sqlite_dll = sqlite_dir .. "/sqlite3.dll"
        vim.g.sqlite_clib_path = sqlite_dll
        if vim.fn.filereadable(sqlite_dll) == 0 then
            vim.fn.mkdir(sqlite_dir, "p")
            local sqlite_zip = sqlite_dir .. "/sqlite-dll-win64.zip"
            print("download sqlite3.dll...")
            vim.cmd(vim.fn.join({"silent !curl.exe", "https://www.sqlite.org/2022/sqlite-dll-win64-x64-3380300.zip", "-o", sqlite_zip}, " "))
            vim.cmd(vim.fn.join({"silent !unzip.exe -d ", sqlite_dir, sqlite_zip}, " "))
        end
    end

end

return C
