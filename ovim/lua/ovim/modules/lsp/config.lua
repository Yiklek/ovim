-- File: lsp/config.lua
-- Author: Yiklek
-- Description: lsp config
-- Copyright (c) 2022 Yiklek
local km = require("ovim.core.keymap")
local keymap = require("ovim.modules.lsp.keymap")
local C = {}
function C.nvim_lsp()
  require("ovim.modules.lsp.lsp_config")
end

function C.trouble()
  require("trouble").setup {}
  km.load(keymap.trouble())
end

-- function C.null_ls()
--   local null_ls = require("null-ls")
--   local formatting = null_ls.builtins.formatting
--   -- local completion = null_ls.builtins.completion
--   local opts = {
--     log_level = "error",
--     sources = {
--       formatting.stylua,
--       formatting.autopep8,
--       -- formatting.clang_format,
--       formatting.gofmt,
--       formatting.jq,
--       formatting.fixjson,
--     },
--   }
--   -- table.insert(opts.sources, formatting.prettierd)
--   null_ls.setup(opts)
-- end

return C
