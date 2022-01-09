local function nvim_lsp()
    require("ovim.modules.lsp.lspconfig")
end
return {
    nvim_lsp = nvim_lsp,
}
