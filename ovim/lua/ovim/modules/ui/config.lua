-- File: ui/config.lua
-- Author: Yiklek
-- Description: ui config
-- Copyright (c) 2022 Yiklek


local keymap = require("ovim.modules.ui.keymap")

local function nvim_treesitter()
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
local function indent_guides()
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
local function nvim_gps()
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
local function lualine()
    local gps = require("nvim-gps")

    local function gps_content()
        if gps.is_available() then
            return gps.get_location()
        else
            return ""
        end
    end
    local simple_sections = {
        lualine_a = {"mode"},
        lualine_b = {"filetype"},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {"location"}
    }
    local aerial = {
        sections = simple_sections,
        filetypes = {"aerial"}
    }
    local dapui_scopes = {
        sections = simple_sections,
        filetypes = {"dapui_scopes"}
    }

    local dapui_breakpoints = {
        sections = simple_sections,
        filetypes = {"dapui_breakpoints"}
    }

    local dapui_stacks = {
        sections = simple_sections,
        filetypes = {"dapui_stacks"}
    }

    local dapui_watches = {
        sections = simple_sections,
        filetypes = {"dapui_watches"}
    }

    require("lualine").setup(
        {
            options = {
                icons_enabled = true,
                theme = "auto",
                disabled_filetypes = {},
                component_separators = "|",
                section_separators = {left = "", right = ""}
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {{"branch"}, {"diff"}},
                lualine_c = {
                    {"lsp_progress"},
                    {gps_content, cond = gps.is_available}
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = {"nvim_diagnostic"},
                        symbols = {error = " ", warn = " ", info = " "}
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
                lualine_z = {"progress", "location"}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {"filename"},
                lualine_x = {"location"},
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
local function bufferline()
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
                }
            },
            always_show_bufferline = false,
            diagnostics = "nvim_lsp"
        }
    }
    require("ovim.misc.keymap").nvim_load_mapping(keymap.bufferline())
end

local function nvim_tree()
    local keymap_list = {
        { key = "l", action = "edit" },
        { key = "e", action = "edit_in_place" },
        { key = "v", action = "vsplit" },
        { key = "x", action = "split" },
        { key = "t", action = "tabnew" },
        { key = "h", action = "close_node" },
    }
    require("ovim.misc.safe_require")("nvim-tree").setup{
        disable_netrw = true,
        hijack_netrw = true,
        open_on_setup = false,
        ignore_ft_on_setup = {},
        open_on_tab = false,
        hijack_cursor = true,
        update_cwd = false,
        update_to_buf_dir = {enable = true, auto_open = true},
        diagnostics = {
            enable = false,
            icons = {hint = "", info = "", warning = "", error = ""}
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {}
        },
        system_open = {cmd = nil, args = {}},
        filters = {dotfiles = false, custom = {}},
        git = {enable = true, ignore = true, timeout = 500},
        view = {
            width = 40,
            height = 30,
            hide_root_folder = false,
            side = "left",
            auto_resize = false,
            mappings = {custom_only = false, list = keymap_list },
            number = false,
            relativenumber = false,
            signcolumn = "yes"
        },
        trash = {cmd = "trash", require_confirm = true}
    }
    require("ovim.misc.keymap").nvim_load_mapping(keymap.nvim_tree())
end
local function indent_blankline()
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
            buftype_exclude = {"terminal", "nofile"},
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
local function luasaga()
    local saga = require("lspsaga")
    saga.init_lsp_saga(
        {
            error_sign = "",
            warn_sign = "",
            hint_sign = "",
            infor_sign = ""
        }
    )
end
return {
    nvim_treesitter = nvim_treesitter,
    indent_guides = indent_guides,
    nvim_gps = nvim_gps,
    lualine = lualine,
    bufferline = bufferline,
    nvim_tree = nvim_tree,
    indent_blankline = indent_blankline,
    luasaga = luasaga
}
