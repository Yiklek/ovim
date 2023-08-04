-- File: features.lua
-- Author: ovim
-- Description: ui features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim
local km = require "ovim.core.keymap"

return {
  basic = function(p, opts)
    p["stevearc/dressing.nvim"] = {
      "stevearc/dressing.nvim",
      event = "VeryLazy",
    }
    p["folke/noice.nvim"] = {
      "folke/noice.nvim",
      event = "VeryLazy",
      config = function()
        require "ovim.core.safe_require"("ovim.modules.ui.config").noice()
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    }
  end,
  statusline = function(p, opts)
    p["hoob3rt/lualine.nvim"] = {
      "hoob3rt/lualine.nvim",
      event = "VeryLazy",
      config = function()
        require "ovim.core.safe_require"("ovim.modules.ui.config").lualine()
      end,
      dependencies = {
        {
          "SmiteshP/nvim-navic",
          config = function()
            require "ovim.core.safe_require"("ovim.modules.ui.config").nvim_navic()
          end,
        },
      },
    }
  end,
  tabline = function(p, opts)
    p["akinsho/bufferline.nvim"] = {
      "akinsho/bufferline.nvim",
      event = "VeryLazy",
      config = function()
        require "ovim.core.safe_require"("ovim.modules.ui.config").bufferline()
      end,
    }
  end,
  treesitter = function(p, opts)
    p["nvim-treesitter/nvim-treesitter"] = {
      "nvim-treesitter/nvim-treesitter",
      event = "VeryLazy",
      config = function()
        require "ovim.core.safe_require"("ovim.modules.ui.config").nvim_treesitter()
      end,
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "p00f/nvim-ts-rainbow",
        "nvim-treesitter/nvim-treesitter-refactor",
      },
    }
  end,
  fileTree = function(p, opts)
    if require("ovim.config").modules.ui.features.fileTree.use == "NvimTree" then
      p["kyazdani42/nvim-tree.lua"] = {
        "kyazdani42/nvim-tree.lua",
        event = "VeryLazy",
        config = function()
          require "ovim.core.safe_require"("ovim.modules.ui.config").nvim_tree()
        end,
      }
    end
    if require("ovim.config").modules.ui.features.fileTree.use == "neo-tree" then
      p["nvim-neo-tree/neo-tree.nvim"] = {
        "nvim-neo-tree/neo-tree.nvim",
        event = "VeryLazy",
        branch = "v3.x",
        cmd = "NeoTree",
        init = function()
          km.load(require("ovim.modules.ui.keymap").neo_tree())
        end,
        config = function()
          vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
          vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
          vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
          vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
          require("neo-tree").setup { filesystem = { use_libuv_file_watcher = true } }
        end,
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
        },
      }
    end
  end,
  devicons = function(p, opts)
    p["kyazdani42/nvim-web-devicons"] = {
      "kyazdani42/nvim-web-devicons",
      event = "VeryLazy",
    }
    p["ryanoasis/vim-devicons"] = {
      "ryanoasis/vim-devicons",
      event = "VeryLazy",
    }
  end,
  indent = function(p, opts)
    if opts.use == nil or opts.use == "mini" then
      p["lukas-reineke/indent-blankline.nvim"] = {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function()
          require "ovim.core.safe_require"("ovim.modules.ui.config").indent_blankline()
        end,
      }
      p["echasnovski/mini.indentscope"] = {
        "echasnovski/mini.indentscope",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
          -- symbol = "▏",
          symbol = "│",
          options = { try_as_border = true },
          draw = {
            delay = 50,
          },
        },
        init = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = {
              "help",
              "alpha",
              "dashboard",
              "neo-tree",
              "Trouble",
              "lazy",
              "mason",
              "notify",
              "toggleterm",
              "lazyterm",
            },
            callback = function()
              vim.b.miniindentscope_disable = true
            end,
          })
        end,
      }
    end
    if opts.use == "guides" then
      p["glepnir/indent-guides.nvim"] = {
        "glepnir/indent-guides.nvim",
        event = "BufRead",
        config = function()
          require "ovim.core.safe_require"("ovim.modules.ui.config").indent_guides()
        end,
      }
    end
  end,
  which_key = function(p, opts)
    p["folke/which-key.nvim"] = {
      "folke/which-key.nvim",
      lazy = true,
      config = function()
        require "ovim.core.safe_require"("ovim.modules.ui.config").which_key()
      end,
      event = "VeryLazy",
    }
  end,
  terminal = function(p, opts)
    if opts.use ~= nil and opts.use == "toggleterm" then
      p["akinsho/toggleterm.nvim"] = {
        "akinsho/toggleterm.nvim",
        init = function()
          km.load(require("ovim.modules.ui.keymap").toggleterm())
        end,
        cmd = {
          "TermExec",
          "TermSelect",
          "ToggleTerm",
          "ToggleTermToggleAll",
          "ToggleTermSendCurrentLine",
          "ToggleTermSendVisualLines",
          "ToggleTermSendVisualSelection",
        },
        opts = {
          highlights = {
            Normal = { link = "Normal" },
            NormalNC = { link = "NormalNC" },
            NormalFloat = { link = "NormalFloat" },
            FloatBorder = { link = "FloatBorder" },
            StatusLine = { link = "StatusLine" },
            StatusLineNC = { link = "StatusLineNC" },
            WinBar = { link = "WinBar" },
            WinBarNC = { link = "WinBarNC" },
          },
          on_create = function()
            vim.opt.foldcolumn = "0"
            vim.opt.signcolumn = "no"
          end,
          size = 20,
          -- open_mapping = [[<leader>et<space>]],
          open_mapping = nil,
          hide_numbers = false,
          shade_filetypes = {},
          shade_terminals = true,
          shading_factor = 3,
          start_in_insert = true,
          insert_mappings = true,
          persist_size = false,
          persist_mode = true,
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
          winbar = {
            enabled = true,
            name_formatter = function(term) --  term: Terminal
              return term.name
            end,
          },
        },
      }
    elseif opts.use ~= nil and opts.use == "floaterm" then
      p["voldikss/vim-floaterm"] = {
        "voldikss/vim-floaterm",
        cmd = {
          "FloatermToggle",
          "FloatermPrev",
          "FloatermNext",
          "FloatermNew",
          "FloatermFirst",
          "FloatermLast",
          "FloatermKill",
          "FloatermShow",
          "FloatermHide",
          "FloatermUpdate",
        },
        init = function()
          require "ovim.core.safe_require"("ovim.modules.ui.config").floaterm()
        end,
      }
    end
  end,
  lsp_progress = function(p, opts)
    if opts.use == "fidget" then
      p["j-hui/fidget.nvim"] = {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function()
          require "ovim.core.safe_require"("fidget").setup()
        end,
        event = { "VeryLazy" },
      }
    elseif opts.use == "lualine-lsp-progress" then
      p["arkav/lualine-lsp-progress"] = {
        "arkav/lualine-lsp-progress",
        event = { "VeryLazy" },
      }
    end
  end,
  dashboard = function(p, opts)
    if opts.use == "dashboard-nvim" then
      p["glepnir/dashboard-nvim"] = {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        opts = {
          theme = "hyper",
          config = {
            header = {
              "",
              " ██████╗ ██╗   ██╗██╗███╗   ███╗",
              "██╔═══██╗██║   ██║██║████╗ ████║",
              "██║   ██║██║   ██║██║██╔████╔██║",
              "██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
              "╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
              " ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
              "",
            },
            week_header = {
              enable = false,
            },
            shortcut = {
              { desc = " Update", group = "@property", action = "Lazy update", key = "u" },
              {
                desc = " Files",
                group = "Label",
                action = "Telescope find_files",
                key = "f",
              },
              {
                desc = "Oldfiles",
                action = "Telescope oldfiles",
                key = "o",
              },
              {
                desc = "Project",
                action = "Telescope project",
                key = "p",
              },
            },
          },
        },
        dependencies = { { "nvim-web-devicons" } },
      }
    end
  end,
  window_picker = function(p, opts)
    p["s1n7ax/nvim-window-picker"] = {
      "s1n7ax/nvim-window-picker",
      event = "VeryLazy",
      version = "2.*",
      config = function()
        -- require("window-picker").setup()
        km.load {
          ["n|<leader>w<space>"] = km.map_f(function()
            local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
            vim.api.nvim_set_current_win(picked_window_id)
          end):with_display "Choose Window",
        }
      end,
    }
  end,
}
