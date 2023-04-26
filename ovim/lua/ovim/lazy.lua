-- File: lazy.lua
-- Author: Yiklek
-- Description: lazy
-- Copyright (c) 2023 Yiklek
local sys = require "ovim.sys"

local this = {}
this.__index = this

local lazy_path = ovim.const.cache_path .. "/pack/ovim/opt/lazy.nvim"
local lazy_opts = {
  root = ovim.const.cache_path .. "/lazy/plugins",
  defaults = {
    lazy = true,
  },
  lockfile = ovim.const.cache_path .. "/lazy/lazy-lock.json",
  readme = { root = ovim.const.cache_path .. "/lazy/readme" },
  state = ovim.const.cache_path .. "/lazy/state.json",
  performance = {
    reset_packpath = false,
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
  if not ovim.lazy then
    sys.cmd [[packadd lazy.nvim]]
    ovim.lazy = require "lazy"
  end
  local config = require "ovim.config"
  local util = require "ovim.misc.util"
  local modules = util.detect_modules()

  for _, module in pairs(modules) do
    local m = require(module)
    local level = m.level or 0
    local condition = true
    if m.condition ~= nil and type(m.condition) == "string" then
      condition = condition and vim.fn.luaeval(m.condition)
    end
    if level < config.level and condition then
      config.plugins = vim.tbl_deep_extend("force", config.plugins, m.plugins)
    end
  end

  ovim.lazy.setup(vim.tbl_values(config.plugins), lazy_opts)
  vim.api.nvim_create_user_command("LazyUpdate", function()
    local Job = require "plenary.job"
    Job:new({
      command = "git",
      args = { "--work-tree", lazy_path, "pull" },
      on_exit = function(j, return_val)
        local level = vim.log.levels.INFO
        if return_val ~= 0 then
          level = vim.log.levels.WARN
        end
        vim.notify(j:result()[1] or "LazyUpdate failed.", level, {})
      end,
    }):start()
  end, {})
end

return this
