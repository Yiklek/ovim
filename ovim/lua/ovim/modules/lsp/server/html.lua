-- File: html.lua
-- Author: Yiklek
-- Description: server.html
-- Last Modified: 12 03, 2022
-- Copyright (c) 2022 Yiklek

local opts = {
  cmd = { "html-languageserver", "--stdio" },
  filetypes = { "html" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = { css = true, javascript = true },
  },
  settings = {},
  single_file_support = true,
}

return {
  on_setup = require("ovim.modules.lsp.server").on_setup(opts),
}
