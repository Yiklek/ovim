-- File: lazy.lua
-- Author: Yiklek
-- Description: lazy
-- Copyright (c) 2023 Yiklek

local this = {}
this.__index = this

local lazy_path = ovim.const.cache_path .. "/lazy/plugins/lazy.nvim"
local lazy_opts = {
  root = ovim.const.cache_path .. "/lazy/plugins",
  defaults = {
    lazy = true,
  },
  lockfile = ovim.const.cache_path .. "/lazy/lazy-lock.json",
  readme = { root = ovim.const.cache_path .. "/lazy/readme" },
  state = ovim.const.cache_path .. "/lazy/state.json",
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
    vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazy_path }
  end
  if not ovim.lazy then
    vim.opt.rtp:prepend(lazy_path)
    ovim.lazy = require("lazy")
  end
  local config = require("ovim.config")
  local util = require("ovim.core.util")
  local modules = util.detect_modules()

  for _, module in pairs(modules) do
    local m = require(module)
    local level = m.level or 0
    local condition = true
    if m.condition ~= nil and type(m.condition) == "string" then
      condition = condition and vim.fn.luaeval(m.condition) or false
    end
    if level < config.level and condition then
      config.plugins = vim.tbl_deep_extend("force", config.plugins, m.plugins)
    end
  end

  ovim.lazy.setup(vim.tbl_values(config.plugins), lazy_opts)
end

return this
