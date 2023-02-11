-- File: clangd.lua
-- Author: Yiklek
-- Description: server.clangd
-- Last Modified: 12 03, 2022
-- Copyright (c) 2022 Yiklek

local lspconfig = require "lspconfig"

local function switch_source_header_splitcmd(bufnr, splitcmd)
  bufnr = lspconfig.util.validate_bufnr(bufnr)
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  vim.lsp.buf_request(bufnr, "textDocument/switchSourceHeader", params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      print "Corresponding file can’t be determined"
      return
    end
    vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
  end)
end

local opts = {
  -- capabilities = common.capabilities,
  -- flags = common.flags,
  -- on_attach = function(client, bufnr)
  --   common.disableFormat(client)
  --   common.keyAttach(bufnr)
  -- end,
  args = { "--background-index", "-std=c++20" },
  commands = {
    ClangdSwitchSourceHeader = {
      function()
        switch_source_header_splitcmd(0, "edit")
      end,
      description = "Open source/header in current buffer",
    },
    ClangdSwitchSourceHeaderVSplit = {
      function()
        switch_source_header_splitcmd(0, "vsplit")
      end,
      description = "Open source/header in a new vsplit",
    },
    ClangdSwitchSourceHeaderSplit = {
      function()
        switch_source_header_splitcmd(0, "split")
      end,
      description = "Open source/header in a new split",
    },
  },
}

return {
  on_setup = require("ovim.modules.lsp.server").on_setup(opts),
}
