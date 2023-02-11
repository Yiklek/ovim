-- File: lsp/lspconfig.lua
-- Author: Yiklek
-- Description: lspconfig
-- Copyright (c) 2022 Yiklek

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_config = require("mason-lspconfig")

mason.setup(
    {
        install_root_dir = ovim.const.cache_path .. "/mason",
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
)

mason_config.setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.documentationFormat = {
    "markdown",
    "plaintext"
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = { 1 }
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" }
}

local function custom_attach()
    require("lsp_signature").on_attach(
        {
            bind = true,
            use_lspsaga = false,
            floating_window = true,
            fix_pos = true,
            hint_enable = true,
            hi_parameter = "Search",
            handler_opts = { "double" }
        }
    )
end

local servers = {
    sumneko_lua = require("ovim.modules.lsp.server.lua"),
    clangd = require("ovim.modules.lsp.server.clangd"),
    html = require("ovim.modules.lsp.server.html"),
}
require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        local server_config = servers[server_name]
        if server_config ~= nil and type(server_config) == "table" then
            server_config.on_setup(
                lspconfig[server_name],
                {
                    capabilities = capabilities,
                    flags = { debounce_text_changes = 500 },
                    on_attach = custom_attach
                }
            )
        else
            lspconfig[server_name].setup {}
        end
    end
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false
    }
)
local keymap = require("ovim.modules.lsp.keymap")
require("ovim.misc.keymap").load(keymap.lsp())
