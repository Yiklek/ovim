-- File: ui/config.lua
-- Author: Yiklek
-- Description: ui config
-- Copyright (c) 2022 Yiklek

local C = {}
local keymap = require("ovim.modules.ui.keymap")

function C.nvim_treesitter()
    vim.api.nvim_command('set foldmethod=expr')
    vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
    require "nvim-treesitter.configs".setup {
        ensure_installed = {
            "c",
            "cpp",
            "python",
            "rust",
            "vim",
            "javascript",
            --"lua",
            "toml",
            "json",
            "go",
            "gomod"
        },
        indent = {
            enable = true
        },
        highlight = {
            enable = true,
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = true
        }
    }
end

function C.indent_guides()
    require("indent_guides").setup(
        {
            exclude_filetypes = {
                "help",
                "dashboard",
                "dashpreview",
                "NvimTree",
                "vista",
                "sagahover",
                "coc-explorer",
                "floaterm",
                "packer"
            }
        }
    )
end

function C.nvim_gps()
    require("nvim-gps").setup(
        {
            icons = {
                ["class-name"] = " ", -- Classes and class-like objects
                ["function-name"] = " ", -- Functions
                ["method-name"] = " " -- Methods (functions inside class-like objects)
            },
            languages = {
                -- You can disable any language individually here
                ["c"] = true,
                ["cpp"] = true,
                ["go"] = true,
                ["java"] = true,
                ["javascript"] = true,
                ["lua"] = true,
                ["python"] = true,
                ["rust"] = true
            },
            separator = " > "
        }
    )
end

function C.lualine()
    -- ovim.pack.load({ "nvim-treesitter", "nvim-gps" })
    local gps = require("nvim-gps")
    local ui_config = require("ovim.config").modules.ui
    local lualine_c = ""
    if ui_config.features.lsp_progress.enable == true
        and ui_config.features.lsp_progress.use == "lualine-lsp-progress" then
        ovim.pack.load("lualine-lsp-progress")
        lualine_c = "lsp_progress"
    end
    local function gps_content()
        if gps.is_available() then
            return gps.get_location()
        else
            return ""
        end
    end

    local simple_sections = {
        lualine_a = { "mode" },
        lualine_b = { "filetype" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" }
    }
    local aerial = {
        sections = simple_sections,
        filetypes = { "aerial" }
    }
    local dapui_scopes = {
        sections = simple_sections,
        filetypes = { "dapui_scopes" }
    }

    local dapui_breakpoints = {
        sections = simple_sections,
        filetypes = { "dapui_breakpoints" }
    }

    local dapui_stacks = {
        sections = simple_sections,
        filetypes = { "dapui_stacks" }
    }

    local dapui_watches = {
        sections = simple_sections,
        filetypes = { "dapui_watches" }
    }

    require("lualine").setup(
        {
            options = {
                icons_enabled = true,
                theme = "auto",
                disabled_filetypes = {},
                component_separators = "|",
                section_separators = { left = "", right = "" }
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { { "branch" }, { "diff" } },
                lualine_c = {
                    { lualine_c },
                    { gps_content, cond = gps.is_available }
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " " }
                    }
                },
                lualine_y = {
                    {
                        "filetype",
                        "encoding"
                    },
                    {
                        "fileformat",
                        icons_enabled = true,
                        symbols = {
                            unix = "LF",
                            dos = "CRLF",
                            mac = "CR"
                        }
                    }
                },
                lualine_z = { "progress", "location" }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            extensions = {
                "quickfix",
                "nvim-tree",
                "toggleterm",
                "fugitive",
                aerial,
                dapui_scopes,
                dapui_breakpoints,
                dapui_stacks,
                dapui_watches
            }
        }
    )
end

function C.bufferline()
    require("bufferline").setup {
        options = {
            numbers = "both",
            offsets = {
                {
                    filetype = "coc-explorer",
                    text = "File Explorer",
                    text_align = "left"
                },
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "left"
                },
                {
                    filetype = "vista",
                    text = "Vista",
                    text_align = "right"
                },
                {
                    filetype = "vista_kind",
                    text = "Vista",
                    text_align = "right"
                }
            },
            always_show_bufferline = false,
            diagnostics = "nvim_lsp"
        }
    }
    require("ovim.misc.keymap").load(keymap.bufferline())
end

function C.nvim_tree()
    local keymap_list = {
        { key = "l", action = "edit" },
        { key = "e", action = "edit_in_place" },
        { key = "v", action = "vsplit" },
        { key = "x", action = "split" },
        { key = "t", action = "tabnew" },
        { key = "h", action = "close_node" },
    }
    require("ovim.misc.safe_require")("nvim-tree").setup {
        disable_netrw = true,
        hijack_netrw = true,
        open_on_setup = false,
        ignore_ft_on_setup = {},
        open_on_tab = false,
        hijack_cursor = true,
        update_cwd = false,
        diagnostics = {
            enable = false,
            icons = { hint = "", info = "", warning = "", error = "" }
        },
        system_open = { cmd = nil, args = {} },
        filters = { dotfiles = false, custom = {} },
        git = { enable = true, ignore = true, timeout = 500 },
        view = {
            width = 40,
            hide_root_folder = false,
            side = "left",
            mappings = { custom_only = false, list = keymap_list },
            number = false,
            relativenumber = false,
            signcolumn = "yes"
        },
        trash = { cmd = "trash", require_confirm = true }
    }
    require("ovim.misc.keymap").load(keymap.nvim_tree())
end

function C.indent_blankline()
    vim.opt.termguicolors = true
    vim.opt.list = true
    require("indent_blankline").setup(
        {
            char = "│",
            show_first_indent_level = true,
            filetype_exclude = {
                "startify",
                "dashboard",
                "dotooagenda",
                "log",
                "fugitive",
                "gitcommit",
                "packer",
                "vimwiki",
                "markdown",
                "json",
                "txt",
                "vista",
                "help",
                "todoist",
                "NvimTree",
                "peekaboo",
                "git",
                "TelescopePrompt",
                "undotree",
                "flutterToolsOutline",
                "" -- for all buffers without a file type
            },
            buftype_exclude = { "terminal", "nofile" },
            show_trailing_blankline_indent = false,
            show_current_context = true,
            context_patterns = {
                "class",
                "function",
                "method",
                "block",
                "list_literal",
                "selector",
                "^if",
                "^table",
                "if_statement",
                "while",
                "for",
                "type",
                "var",
                "import"
            },
            space_char_blankline = " "
        }
    )
    -- because lazy load indent-blankline so need readd this autocmd
    vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
end

function C.which_key()
    require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<Plug>", "<plug>" }, -- hide mapping boilerplate
        key_labels = {
            -- override the label used to display some keys. It doesn't effect WK in any other way.
            -- For example:
            ["<space>"] = "SPC",
            ["<cr>"] = "RET",
            ["<tab>"] = "TAB",
        },
    }
    require("ovim.misc.keymap").register_which_key()
end

function C.toggleterm()
    local toggleterm = require("toggleterm")
    toggleterm.setup {
        size = 20,
        open_mapping = [[<leader>et<space>]],
        hide_numbers = false,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 3,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
            winblend = 3,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
    }
end

function C.floaterm()
    vim.cmd "source $OVIM_ROOT_PATH/plugins/floaterm.vim"
end

function C.dressing()
    require('dressing').setup({
        input = {
            -- Set to false to disable the vim.ui.input implementation
            enabled = true,

            -- Default prompt string
            default_prompt = "Input:",

            -- Can be 'left', 'right', or 'center'
            prompt_align = "left",

            -- When true, <Esc> will close the modal
            insert_only = true,

            -- When true, input will start in insert mode.
            start_in_insert = true,

            -- These are passed to nvim_open_win
            anchor = "SW",
            border = "rounded",
            -- 'editor' and 'win' will default to being centered
            relative = "editor",

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            prefer_width = 40,
            width = nil,
            -- min_width and max_width can be a list of mixed types.
            -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
            max_width = { 140, 0.9 },
            min_width = { 20, 0.2 },

            buf_options = {},
            win_options = {
                -- Window transparency (0-100)
                winblend = 10,
                -- Disable line wrapping
                wrap = false,
            },

            -- Set to `false` to disable
            mappings = {
                n = {
                    ["<Esc>"] = "Close",
                    ["<CR>"] = "Confirm",
                },
                i = {
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                    ["<Up>"] = "HistoryPrev",
                    ["<Down>"] = "HistoryNext",
                },
            },

            override = function(conf)
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                return conf
            end,

            -- see :help dressing_get_config
            get_config = nil,
        },
        select = {
            -- Set to false to disable the vim.ui.select implementation
            enabled = true,

            -- Priority list of preferred vim.select implementations
            backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

            -- Trim trailing `:` from prompt
            trim_prompt = true,

            -- Options for telescope selector
            -- These are passed into the telescope picker directly. Can be used like:
            -- telescope = require('telescope.themes').get_ivy({...})
            telescope = nil,

            -- Options for fzf selector
            fzf = {
                window = {
                    width = 0.5,
                    height = 0.4,
                },
            },

            -- Options for fzf_lua selector
            fzf_lua = {
                winopts = {
                    width = 0.5,
                    height = 0.4,
                },
            },

            -- Options for nui Menu
            nui = {
                position = "50%",
                size = nil,
                relative = "editor",
                border = {
                    style = "rounded",
                },
                buf_options = {
                    swapfile = false,
                    filetype = "DressingSelect",
                },
                win_options = {
                    winblend = 10,
                },
                max_width = 80,
                max_height = 40,
                min_width = 40,
                min_height = 10,
            },

            -- Options for built-in selector
            builtin = {
                -- These are passed to nvim_open_win
                anchor = "NW",
                border = "rounded",
                -- 'editor' and 'win' will default to being centered
                relative = "editor",

                buf_options = {},
                win_options = {
                    -- Window transparency (0-100)
                    winblend = 10,
                },

                -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- the min_ and max_ options can be a list of mixed types.
                -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
                width = nil,
                max_width = { 140, 0.8 },
                min_width = { 40, 0.2 },
                height = nil,
                max_height = 0.9,
                min_height = { 10, 0.2 },

                -- Set to `false` to disable
                mappings = {
                    ["<Esc>"] = "Close",
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                },

                override = function(conf)
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    return conf
                end,
            },

            -- Used to override format_item. See :help dressing-format
            format_item_override = {},

            -- see :help dressing_get_config
            get_config = nil,
        },
    })
end

function C.noice()
    require("noice").setup({
        lsp = {
            progress = {
                enabled = false
            },
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = false,
            },
            signature = {
                enabled = false
            }
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        messages = {
            view = "mini", -- default view for messages
        },
        popupmenu = {
            enabled = false
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    find = "%slines?%s",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "NvimTree",
                },
                opts = { skip = true },
            },
        },
    })
end

return C
