-- File: ui/init.lua
-- Author: Yiklek
-- Description: ui init
-- Copyright (c) 2022 Yiklek
local plugins = {
  ["rebelot/kanagawa.nvim"] = {
    "rebelot/kanagawa.nvim",
    lazy = false,
  },
  ["rmehri01/onenord.nvim"] = {
    "rmehri01/onenord.nvim",
    lazy = false,
  },
  ["sainnhe/everforest"] = {
    "sainnhe/everforest",
    lazy = false,
  },
  ["EdenEast/nightfox.nvim"] = {
    "EdenEast/nightfox.nvim",
    lazy = false,
  },
  ["sainnhe/sonokai"] = {
    "sainnhe/sonokai",
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("custom_highlights_sonokai", {}),
        pattern = "sonokai",
        callback = function()
          local config = vim.fn["sonokai#get_configuration"]()
          local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
          vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = palette.bg4[1] })
        end,
      })
    end,
  },
  ["navarasu/onedark.nvim"] = {
    "navarasu/onedark.nvim",
    lazy = false,
  },
  ["scottmckendry/cyberdream.nvim"] = {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      saturation = 0.7,
    },
  },
}
local features = require("ovim.core.features").setup_module_features("ui", plugins)
return {
  name = "ui",
  level = 1,
  features = features,
  plugins = plugins,
}
