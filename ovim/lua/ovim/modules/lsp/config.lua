-- File: lsp/config.lua
-- Author: Yiklek
-- Description: lsp config
-- Copyright (c) 2022 Yiklek
local function nvim_lsp()
    require("ovim.misc.safe_require")("ovim.modules.lsp.lsp_config")
end
local function trouble()
    require("trouble").setup {}
end
return {
    nvim_lsp = nvim_lsp,
    trouble = trouble
}
