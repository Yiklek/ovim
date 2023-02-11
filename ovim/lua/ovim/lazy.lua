-- File: pack.lua
-- Author: Yiklek
-- Description: pack
-- Copyright (c) 2022 Yiklek
local sys = require("ovim.sys")

local this = {}
this.__index = this

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
            reset = false
        }
    },
}

function this.init()
    if not ovim.lazy then
        sys.cmd [[packadd lazy.nvim]]
        ovim.lazy = require("lazy")
    end
    local config = require("ovim.config")
    local util = require("ovim.misc.util")
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
end

return this
