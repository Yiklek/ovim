-- File: lsp/config.lua
-- Author: Yiklek
-- Description: lsp config
-- Copyright (c) 2022 Yiklek
local C = {}
function C.nvim_lsp()
    require("ovim.misc.safe_require")("ovim.modules.lsp.lsp_config")
end
function C.trouble()
    require("trouble").setup {}
end
return C
