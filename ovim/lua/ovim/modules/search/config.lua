-- File: search/config.lua
-- Author: Yiklek
-- Description: search config
-- Copyright (c) 2022 Yiklek
local C = {}
local km = require("ovim.misc.keymap")
local keymap = require("ovim.modules.search.keymap")
local config_features = require("ovim.config").modules.search.features
local function telescope_fzf_native()
    -- telescope-fzf-native
    local fzf = nil
    if config_features["telescope-fzf-native"].enable and vim.fn.executable("cmake") ~= 0 then
        local fzf_native_plugin_path = vim.g.ovim_cache_path .. "/lazy/plugins/telescope-fzf-native.nvim"
        local fzf_native_plugin_build_path = fzf_native_plugin_path .. "/build"
        if vim.fn.isdirectory(fzf_native_plugin_build_path) == 0 then
            vim.cmd(vim.fn.join({"silent !cmake", "-S", fzf_native_plugin_path, "-B", fzf_native_plugin_build_path}, " "))
            vim.cmd(vim.fn.join({"silent !cmake", "--build", fzf_native_plugin_build_path, "--config Release"}, " "))
            vim.cmd(vim.fn.join({"silent !cmake", "--install", fzf_native_plugin_build_path , "--install", fzf_native_plugin_build_path}, " "))
        end
        -- require("packer.load")({"telescope-fzf-native.nvim"}, {}, _G.packer_plugins)
        require("telescope").load_extension("fzf")
        fzf = {
            fuzzy = false, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    end
    return fzf
end

local function telescope_frecency()
    local use_frecency = false
    local frecency = nil
    if config_features["telescope-frecency"].enable then
        if vim.fn.has("osx")
            and (vim.fn.filereadable("/opt/homebrew/opt/sqlite/lib/libsqlite3.dylib")
                or vim.fn.filereadable("/usr/local/opt/sqlite3/lib/libsqlite3.dylib")) ~= 0 then
            use_frecency = true
        elseif vim.fn.has("linux")
            and tonumber(vim.trim(vim.split(
                    vim.api.nvim_exec([[!ldconfig -p | grep libsqlite | tr ' ' '\n' | grep / | wc -l]], true),
                "\r\n")[2])) ~= 0 then
            use_frecency = true
        elseif require("ovim.misc.util").has_win()
            and (vim.g.sqlite_clib_path ~= nil and vim.fn.filereadable(vim.g.sqlite_clib_path) ~= 0) then
            use_frecency = true
        end
    end
    if use_frecency then
        local telescope_db = vim.g.ovim_cache_path .. "/plugins/telescope"
        vim.fn.mkdir(telescope_db, "p")
        -- require("packer.load")({"sqlite.lua", "telescope-frecency.nvim"}, {}, _G.packer_plugins)
        require("telescope").load_extension("frecency")
        frecency = {
            db_root = telescope_db,
            show_scores = true,
            show_unindexed = true,
            ignore_patterns = {"*.git/*", "*/tmp/*"}
        }
    end
    return frecency
end

function C.telescope()
    -- ovim.pack.load {"plenary.nvim", "telescope-project.nvim", "telescope-zoxide", "telescope-lsp-handlers.nvim"}
    require("telescope").load_extension("project")
    require("telescope").load_extension("zoxide")
    require("telescope").load_extension("lsp_handlers")

    -- telescope-fzf-native
    local fzf = telescope_fzf_native()

    -- telescope-frecency
    local frecency = telescope_frecency()
    local action_layout = require("telescope.actions.layout")
    require("telescope").setup(
        {
            defaults = {
                mappings = {
                    i = {
                        ["<C-o>"] = action_layout.toggle_preview
                    }
                },
                prompt_prefix = "🔎 ",
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
            pickers = {
                find_files = {
                    previewer = false
                },
                oldfiles = {
                    previewer = false
                }
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
