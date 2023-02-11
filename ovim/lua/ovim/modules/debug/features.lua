-- File: features.lua
-- Author: ovim
-- Description: ui features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

local function dap(p, opts)
  if opts.enable == true then
    p["mfussenegger/nvim-dap"] = {
      "mfussenegger/nvim-dap",
      config = function()
        require "ovim.misc.safe_require"("ovim.modules.debug.config").dap()
      end,
      event = "VeryLazy",
      dependencies = {
        {
          "ravenxrz/DAPInstall.nvim",
          config = function()
            require "ovim.misc.safe_require"("ovim.modules.debug.config").dap_install()
          end,
        },
        {
          "theHamsta/nvim-dap-virtual-text",
          config = function()
            require "ovim.misc.safe_require"("ovim.modules.debug.config").dap_virtual_text()
          end,
        },
        {
          "rcarriga/nvim-dap-ui",
          config = function()
            require "ovim.misc.safe_require"("ovim.modules.debug.config").dap_ui()
          end,
        },
        {
          "nvim-telescope/telescope-dap.nvim",
        },
      },
    }
  end
end

return {
  dap = dap,
}
