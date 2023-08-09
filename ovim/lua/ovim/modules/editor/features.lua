-- File: features.lua
-- Author: ovim
-- Description: editor features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

return {
  autopairs = function(p, opts)
    p["windwp/nvim-autopairs"] = {
      "windwp/nvim-autopairs",
      event = "BufReadPost",
      config = function()
        require("ovim.core.safe_require")("ovim.modules.editor.config").nvim_autopairs()
      end,
    }
  end,
  comment = function(p, opts)
    if opts.use ~= nil and opts.use == "nvim-comment" then
      p["terrortylor/nvim-comment"] = {
        "terrortylor/nvim-comment",
        event = "BufReadPost",
        config = function()
          require("ovim.core.safe_require")("ovim.modules.editor.config").nvim_comment()
        end,
      }
    end
    if opts.use ~= nil and opts.use == "Comment.nvim" then
      p["numToStr/Comment.nvim"] = {
        "numToStr/Comment.nvim",
        event = "BufReadPost",
        config = function()
          require("ovim.core.safe_require")("ovim.modules.editor.config").comment_dot_nvim()
        end,
      }
    end
  end,
  vcs = function(p, opts)
    p["lewis6991/gitsigns.nvim"] = {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPost",
      config = function()
        require("ovim.core.safe_require")("ovim.modules.editor.config").gitsigns()
      end,
    }
    p["sindrets/diffview.nvim"] = {
      "sindrets/diffview.nvim",
      config = function()
        require("ovim.core.safe_require")("ovim.modules.editor.config").diffview()
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
      config = function()
        vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
        vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
      end,
    }
  end,
  commit = function(p, opts)
    p["rhysd/committia.vim"] = {
      "rhysd/committia.vim",
      ft = { "gitcommit", "gitrebase" },
      event = "BufReadPre",
    }
  end,
  ime = function(p, opts)
    p["ZSaberLv0/ZFVimIM"] = {
      "ZSaberLv0/ZFVimIM",
      event = "InsertEnter",
      init = function()
        vim.g.ZFVimIM_cloudAsync_enable = 1
        vim.g.ZFVimIM_cloudSync_enable = 0
        vim.g.ZFVimIM_cachePath = ovim.const.cache_path .. "/ZFVimIM"
      end,
      config = function()
        vim.cmd(
          [[nnoremap <expr><silent> ;' ZFVimIME_keymap_next_n()\ninoremap <expr><silent> ;' ZFVimIME_keymap_next_i()\nvnoremap <expr><silent> ;' ZFVimIME_keymap_next_v()]]
        )
      end,
      dependencies = {
        "ZSaberLv0/ZFVimJob",
        "ZSaberLv0/ZFVimIM_pinyin_base",
        "ZSaberLv0/ZFVimIM_openapi",
        "Yiklek/ZFVimIM_openfly",
      },
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
}
