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
        require "ovim.misc.safe_require"("ovim.modules.editor.config").nvim_autopairs()
      end,
    }
  end,
  comment = function(p, opts)
    if opts.use ~= nil and opts.use == "nvim-comment" then
      p["terrortylor/nvim-comment"] = {
        "terrortylor/nvim-comment",
        event = "BufReadPost",
        config = function()
          require "ovim.misc.safe_require"("ovim.modules.editor.config").nvim_comment()
        end,
      }
    end
    if opts.use ~= nil and opts.use == "Comment.nvim" then
      p["numToStr/Comment.nvim"] = {
        "numToStr/Comment.nvim",
        event = "BufReadPost",
        config = function()
          require "ovim.misc.safe_require"("ovim.modules.editor.config").comment_dot_nvim()
        end,
      }
    end
  end,
  vcs = function(p, opts)
    p["lewis6991/gitsigns.nvim"] = {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPost",
      config = function()
        require "ovim.misc.safe_require"("ovim.modules.editor.config").gitsigns()
      end,
    }
    p["sindrets/diffview.nvim"] = {
      "sindrets/diffview.nvim",
      config = function()
        require "ovim.misc.safe_require"("ovim.modules.editor.config").diffview()
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
        vim.cmd [[nnoremap <expr><silent> ;' ZFVimIME_keymap_next_n()\ninoremap <expr><silent> ;' ZFVimIME_keymap_next_i()\nvnoremap <expr><silent> ;' ZFVimIME_keymap_next_v()]]
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
    p["ggandor/leap.nvim"] = {
      "ggandor/leap.nvim",
      event = "BufRead",
      config = require("ovim.modules.editor.config").leap,
    }
    p["ggandor/flit.nvim"] = {
      "ggandor/flit.nvim",
      event = "BufRead",
      config = function()
        require("flit").setup {
          keys = { f = "f", F = "F", t = "t", T = "T" },
          -- A string like "nv", "nvo", "o", etc.
          labeled_modes = "v",
          multiline = true,
          opts = {},
        }
      end,
      dependencies = {
        "ggandor/leap.nvim",
      },
    }
  end,
}
