-- File: ui/config.lua
-- Author: Yiklek
-- Description: ui config
-- Copyright (c) 2022 Yiklek

local C = {}
local km = require("ovim.misc.keymap")
local keymap = require("ovim.modules.debug.keymap")

function C.dap_install()
    local dap_install = require "dap-install"
    dap_install.setup {
        installation_path = ovim.config.cache_path .. "/dapinstall/",
    }

    local dap_breakpoint = {
        error = {
            text = "🛑",
            texthl = "LspDiagnosticsSignError",
            linehl = "",
            numhl = "",
        },
        rejected = {
            text = "",
            texthl = "LspDiagnosticsSignHint",
            linehl = "",
            numhl = "",
        },
        stopped = {
            text = "⭐️",
            texthl = "LspDiagnosticsSignInformation",
            linehl = "DiagnosticUnderlineInfo",
            numhl = "LspDiagnosticsSignInformation",
        },
    }

    vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
    vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

end

function C.dap()
    local dap = require "dap"
    -- TODO: wait dap-ui for fixing temrinal layout
    -- the "30" of "30vsplit: doesn't work
    dap.defaults.fallback.terminal_win_cmd = '30vsplit new' -- this will be overrided by dapui
    dap.set_log_level("DEBUG")

    -- load from json file
    require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'cpp' } })
    -- config per launage
    require("ovim.modules.debug.dap.cpp")

    km.load(keymap.dap())
end

function C.dap_ui()
    local dap, dapui = require "dap", require "dapui"

    local debug_open = function()
        dapui.open()
        vim.api.nvim_command("DapVirtualTextEnable")
        vim.api.nvim_command("NvimTreeClose")
    end
    local debug_close = function()
        dap.repl.close()
        dapui.close()
        vim.api.nvim_command("DapVirtualTextDisable")
        -- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
    end

    dap.listeners.after.event_initialized["dapui_config"]  = function()
        debug_open()
    end
    dap.listeners.before.event_terminated["dapui_config"]  = function()
        debug_close()
    end
    dap.listeners.before.event_exited["dapui_config"]      = function()
        debug_close()
    end
    dap.listeners.before.event_invalidated["dapui_config"] = function()
        debug_close()
    end
    dap.listeners.before.disconnect["dapui_config"]        = function()
        debug_close()
    end
    dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "o", "<2-LeftMouse>", "<CR>" },
            open = "O",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        layouts = {
            {
                -- You can change the order of elements in the sidebar
                elements = {
                    -- Provide as ID strings or tables with "id" and "size" keys
                    {
                        id = "scopes",
                        size = 0.35, -- Can be float or integer > 1
                    },
                    { id = "stacks", size = 0.35 },
                    { id = "watches", size = 0.15 },
                    { id = "breakpoints", size = 0.15 },
                },
                size = 40,
                position = "left", -- Can be "left", "right", "top", "bottom"
            },
            {
                elements = { "repl" },
                size = 5,
                position = "bottom", -- Can be "left", "right", "top", "bottom"
            },
        },
        floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            border = "single", -- Border style. Can be "single", "double" or "rounded"
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
    })
end

function C.dap_virtual_text()
    require("nvim-dap-virtual-text").setup {
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        -- experimental features:
        virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    }

end

return C
