-- File: lua.lua
-- Author: Yiklek
-- Description: server.lua
-- Last Modified: 12 03, 2022
-- Copyright (c) 2022 Yiklek

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local opts = {
  -- capabilities = common.capabilities,
  -- flags = common.flags,
  -- on_attach = function(client, bufnr)
  --   common.disableFormat(client)
  --   common.keyAttach(bufnr)
  -- end,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "packer_plugins" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

return {
  on_setup = require("ovim.modules.lsp.server").on_setup(opts),
}

