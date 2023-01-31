-- File: features.lua
-- Author: ovim
-- Description: ui features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

local function dap(p, opts)
    if opts.enable == true then
        p["ravenxrz/DAPInstall.nvim"] = {
            "ravenxrz/DAPInstall.nvim",
            config = [[require("ovim.misc.safe_require")("ovim.modules.debug.config").dap_install()]],
            opt = true,
            event = { "VimEnter" }
        }
        p["mfussenegger/nvim-dap"] = {
            "mfussenegger/nvim-dap",
            config = [[require("ovim.misc.safe_require")("ovim.modules.debug.config").dap()]],
            opt = true,
            after = "DAPInstall.nvim",
            -- event = { "VimEnter" }
        }
        p["theHamsta/nvim-dap-virtual-text"] = {
            "theHamsta/nvim-dap-virtual-text",
            config = [[require("ovim.misc.safe_require")("ovim.modules.debug.config").dap_virtual_text()]],
            opt = true,
            after = "nvim-dap"
        }
        p["rcarriga/nvim-dap-ui"] = {
            "rcarriga/nvim-dap-ui",
            config = [[require("ovim.misc.safe_require")("ovim.modules.debug.config").dap_ui()]],
            opt = true,
            after = "nvim-dap"
        }
        p["nvim-telescope/telescope-dap.nvim"] = {
            "nvim-telescope/telescope-dap.nvim",
            -- config = [[require("ovim.misc.safe_require")("fidget").setup()]],
            opt = true,
            event = { "VimEnter" }
        }
    end
end

return {
    dap = dap,
}
