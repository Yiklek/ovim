local dap = require('dap')

local dbg_path = require("dap-install.config.settings").options["installation_path"] .. "ccppr_vsc/"
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = "executable",
  command = dbg_path .. "extension/debugAdapters/bin/OpenDebugAD7",
}

-- require lldb-vscode in cache bin
dap.adapters.lldb = {
  id = 'lldb',
  type = "executable",
  command = ovim.config.cache_path .. "/bin/lldb-vscode",
}

dap.configurations.cpp = {
  -- launch
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    args = function()
      local input = vim.fn.input("Input args: ")
      return require("ovim.modules.debug.dap.util").str2argtable(input)
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
      {
        description = 'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
  },
  {
    name = "Launch file lldb",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    args = function()
      local input = vim.fn.input("Input args: ")
      return require("ovim.modules.debug.dap.util").str2argtable(input)
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
      {
        description = 'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
  },
  -- attach process
  {
    name = "Attach process",
    type = "cppdbg",
    request = "attach",
    processId = require('ovim.modules.debug.dap.util').pick_process,
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    setupCommands = {
      {
        description = 'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
  },
  -- attach server
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb', cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
}

-- setup other language
dap.configurations.c = dap.configurations.cpp
