-- File: editor/config.lua
-- Author: Yiklek
-- Description: editor config
-- Copyright (c) 2022 Yiklek
local function nvim_autopairs()
   require("ovim.misc.safe_require")("nvim-autopairs").setup({})
end
return {
    nvim_autopairs = nvim_autopairs,
}
