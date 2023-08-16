-- File: config.lua
-- Author: Yiklek
-- Description: global config
-- Copyright (c) 2022 Yiklek
return {
  level = 4,
  plugins = {},
  root_markers = {
    ".git",
    ".hg",
    ".svn",
    ".root",
    ".project",
    "compile_commands.json",
    "CMakeLists.txt",
    "Makefile",
    "makefile",
  },
  modules = {
    ui = {
      opts = {},
      features = {
        basic = {
          enable = true,
        },
        statusline = {
          enable = true,
          use = "lualine",
        },
        tabline = {
          enable = true,
          use = "bufferline",
        },
        treesitter = {
          enable = true,
        },
        fileTree = {
          enable = true,
          use = "neo-tree",
        },
        devicons = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        which_key = {
          enable = true,
        },
        terminal = {
          use = "toggleterm",
          enable = true,
        },
        lsp_progress = {
          enable = true,
          use = "fidget",
          -- use = "noice",
          -- use = "lualine-lsp-progress",
        },
        dashboard = {
          use = "dashboard-nvim",
          enable = true,
        },
        window_picker = {
          enable = true,
        },
        window_focus = {
          enable = true,
        },
      },
    },
    editor = {
      remove_space = {
        ignore_filetypes = {
          "diff",
          "markdown",
        },
      },
      features = {
        autopairs = {
          enable = true,
        },
        comment = {
          enable = true,
          use = "Comment.nvim",
          -- use = "nvim-comment",
        },
        vcs = {
          enable = true,
        },
        paste = {
          enable = true,
        },
        accelerated_jk = {
          enable = true,
        },
        commit = {
          enable = true,
        },
        ime = {
          enable = false,
        },
        multi_cursor = {
          enable = true,
        },
        movement = {
          enable = true,
        },
        quickfix = {
          enable = true,
        },
        format = {
          enable = true,
        },
      },
    },
    lsp = {
      features = {
        lspsaga = {
          enable = true,
        },
      },
    },
    debug = {
      features = {
        dap = {
          enable = true,
        },
      },
    },
    search = {
      features = {
        ["telescope-fzf-native"] = {
          enable = true,
        },
        ["telescope-frecency"] = {
          enable = true,
        },
      },
    },
  },
}
