-- File: ui/config.lua
-- Author: Yiklek
-- Description: ui config
-- Copyright (c) 2022 Yiklek
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
		lualine_a = { "mode" },
		lualine_b = { "filetype" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	}
	local aerial = {
		sections = simple_sections,
		filetypes = { "aerial" },
	}
	local dapui_scopes = {
		sections = simple_sections,
		filetypes = { "dapui_scopes" },
	}

	local dapui_breakpoints = {
		sections = simple_sections,
		filetypes = { "dapui_breakpoints" },
	}

	local dapui_stacks = {
		sections = simple_sections,
		filetypes = { "dapui_stacks" },
	}

	local dapui_watches = {
		sections = simple_sections,
		filetypes = { "dapui_watches" },
	}

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			disabled_filetypes = {},
			component_separators = "|",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "branch" }, { "diff" } },
			lualine_c = {
				{ "lsp_progress" },
				{ gps_content, cond = gps.is_available },
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " " },
				},
			},
			lualine_y = {
				{
					"filetype",
					"encoding",
				},
				{
					"fileformat",
					icons_enabled = true,
					symbols = {
						unix = "LF",
						dos = "CRLF",
						mac = "CR",
					},
				},
			},
			lualine_z = { "progress", "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
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
			dapui_watches,
		},
	})
end
return {
    nvim_treesitter = nvim_treesitter,
    indent_guides = indent_guides,
    nvim_gps = nvim_gps,
    lualine = lualine
}
