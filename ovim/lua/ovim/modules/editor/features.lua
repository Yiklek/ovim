-- File: features.lua
-- Author: ovim
-- Description: editor features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim
local km = require("ovim.core.keymap")
return {
  autopairs = function(p, opts)
    p["windwp/nvim-autopairs"] = {
      "windwp/nvim-autopairs",
      event = "BufReadPost",
      config = function()
        require("ovim.modules.editor.config").nvim_autopairs()
      end,
    }
  end,
  comment = function(p, opts)
    if opts.use ~= nil and opts.use == "nvim-comment" then
      p["terrortylor/nvim-comment"] = {
        "terrortylor/nvim-comment",
        event = "BufReadPost",
        config = function()
          require("ovim.modules.editor.config").nvim_comment()
        end,
      }
    end
    if opts.use ~= nil and opts.use == "Comment.nvim" then
      p["numToStr/Comment.nvim"] = {
        "numToStr/Comment.nvim",
        event = "BufReadPost",
        config = function()
          require("ovim.modules.editor.config").comment_dot_nvim()
        end,
      }
    end
  end,
  vcs = function(p, opts)
    p["lewis6991/gitsigns.nvim"] = {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPost",
      config = function()
        require("ovim.modules.editor.config").gitsigns()
      end,
    }
    p["sindrets/diffview.nvim"] = {
      "sindrets/diffview.nvim",
      config = function()
        require("ovim.modules.editor.config").diffview()
      end,
      cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
        "DiffviewRefresh",
        "DiffviewFileHistory",
      },
      -- require plenary in basic
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    }
  end,
  paste = function(p, opts)
    p["roxma/vim-paste-easy"] = {
      "roxma/vim-paste-easy",
      event = "InsertEnter",
    }
  end,
  accelerated_jk = function(p, opts)
    p["rainbowhxch/accelerated-jk.nvim"] = {
      "rainbowhxch/accelerated-jk.nvim",
      event = "VeryLazy",
      keys = {
        { "j", mode = { "n" }, "<Plug>(accelerated_jk_gj)", desc = "accelerated-up" },
        { "k", mode = { "n" }, "<Plug>(accelerated_jk_gk)", desc = "accelerated-down" },
      },
    }
  end,
  commit = function(p, opts)
    p["rhysd/committia.vim"] = {
      "rhysd/committia.vim",
      ft = { "gitcommit", "gitrebase" },
      event = "BufReadPre",
    }
  end,
  multi_cursor = function(p, opts)
    p["mg979/vim-visual-multi"] = {
      "mg979/vim-visual-multi",
      event = "BufReadPost",
    }
  end,
  movement = function(p, opts)
    p["folke/flash.nvim"] = {
      "folke/flash.nvim",
      event = "VeryLazy",
      vscode = true,
      opts = {},
      keys = {
        -- stylua: ignore start
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash", },
        { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o",               function() require("flash").remote() end,desc = "Remote Flash", },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end,desc = "Treesitter Search", },
        { "<c-s>", mode = { "c" },function() require("flash").toggle() end, desc = "Toggle Flash Search", }
,
        -- stylua: ignore end
      },
    }
  end,
  quickfix = function(p, opts)
    p["kevinhwang91/nvim-bqf"] = {
      "kevinhwang91/nvim-bqf",
      ft = "qf",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    }
  end,
  format = function(p, opts)
    p["nvimdev/guard.nvim"] = {
      "nvimdev/guard.nvim",
      config = function()
        local ft = require("guard.filetype")
        ft("c"):fmt("clang-format")
        ft("cpp"):fmt("clang-format")
        ft("lua"):fmt("stylua")
        ft("python"):fmt("black")
        -- ft("cmake"):fmt("cmake-format")
        ft("typescript,javascript,typescriptreact,json"):fmt("prettier")
      end,
      keys = km.to_lazy {
        ["n|<leader>xf"] = km.map_cmd("Guard fmt"):display("Format"),
      },
      dependencies = { "nvimdev/guard-collection" },
    }
  end,
}
