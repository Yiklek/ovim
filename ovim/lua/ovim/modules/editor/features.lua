-- File: features.lua
-- Author: ovim
-- Description: editor features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

return {
    autopairs = function(p, opts)
        p["windwp/nvim-autopairs"] = {
"windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = [[require("ovim.misc.safe_require")("ovim.modules.editor.config").nvim_autopairs()]]
        }
    end
}
