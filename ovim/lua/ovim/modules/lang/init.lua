-- File: lang/init.lua
-- Author: Yiklek
-- Description: lang module
-- Copyright (c) 2023 Yiklek

local plugins = {
  ["lervag/vimtex"] = {
    "lervag/vimtex",
    level = 0,
    ft = { "markdown", "latex", "tex" },
  },
  ["iamcco/markdown-preview.nvim"] = {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && yarn install",
  },
}
return {
  plugins = plugins,
}
