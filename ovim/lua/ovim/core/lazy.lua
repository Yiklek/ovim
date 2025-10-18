-- File: lazy.lua
-- Author: Yiklek
-- Description: lazy
-- Copyright (c) 2023 Yiklek

local this = {}
this.__index = this

local lazy_path = ovim.util.path_concat { ovim.const.cache_path, "lazy/plugins/lazy.nvim" }
local lazy_opts = {
  root = ovim.util.path_concat { ovim.const.cache_path, "lazy/plugins" },
  defaults = {
    lazy = true,
  },
  lockfile = ovim.util.path_concat { ovim.const.cache_path, "lazy/lock.json" },
  readme = { root = ovim.util.path_concat { ovim.const.cache_path, "lazy/readme" } },
  state = ovim.util.path_concat { ovim.const.cache_path, "lazy/state.json" },
  performance = {
    rtp = {
      reset = false,
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

function this.init()
  if not vim.loop.fs_stat(lazy_path) then
    -- bootstrap lazy.nvim
    vim.notify("bootstrap lazy.nvim...")
    vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazy_path }
  end
  if not ovim.lazy then
    vim.opt.rtp:prepend(lazy_path)
    ovim.lazy = require("lazy")
  end
  local config = require("ovim.config")
  local util = require("ovim.core.util")
  local modules = util.detect_modules()
  require("ovim.lazyvim").setup()

  for _, module in pairs(modules) do
    local m = require(module)
    local level = m.level or 0
    local condition = true
    local config_cond = true
    if m.condition ~= nil and type(m.condition) == "string" then
      condition = condition and vim.fn.luaeval(m.condition) and config_cond or false
    end
    local m_path = vim.split(module, "/")
    local m_name = m_path[#m_path]
    if config.modules[m_name] ~= nil then
      config_cond = config.modules[m_name].enable ~= false
    end
    if level < config.level and condition and config_cond then
      config.plugins = vim.tbl_deep_extend("force", config.plugins, m.plugins)
    end
  end
  local specs = {}
  if config.lazyvim then
    vim.list_extend(specs, require("ovim.lazyvim.plugins"))
  end
  vim.list_extend(specs, vim.tbl_values(config.plugins))
  ovim.lazy.setup(specs, lazy_opts)
end

return this
