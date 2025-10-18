local M = {}
local function lazyvim()
  -- lazyvim_json must be set as early as possible
  vim.fn.mkdir(ovim.util.path_concat { ovim.const.cache_path, "lazyvim" }, "p")
  vim.g.lazyvim_json = ovim.util.path_concat { ovim.const.cache_path, "lazyvim/config.json" }
  vim.g.lazyvim_picker = "telescope"
  -- vim.g.lazyvim_cmp = "blink.cmp"
  vim.g.lazyvim_cmp = "nvim-cmp"
  vim.g.autoformat = false
  vim.g.deprecation_warnings = true
  vim.g.snacks_animate = false
  package.loaded["lazyvim.config.options"] = true
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "LazyVimKeymaps",
    callback = M.keymaps,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "LazyVimOptions",
    callback = M.options,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "LazyVimAutocmds",
    callback = M.autocmds,
  })
end

function M.keymaps()
  require("ovim.core.keymap").load(require("ovim.keymap").basic())
end

function M.options() end

function M.autocmds() end

function M.setup()
  lazyvim()
end

function M.ovim_opts()
  return {
    modules = {
      ui = {
        features = {
          basic = {
            enable = false,
          },
          which_key = {
            enable = false,
          },
        },
      },
      -- lsp = { enable = false },
      debug = {
        enable = false,
        features = {
          dap = {
            enable = false,
          },
        },
      },
    },
  }
end

return M
