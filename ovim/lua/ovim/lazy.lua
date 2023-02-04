-- File: pack.lua
-- Author: Yiklek
-- Description: pack
-- Copyright (c) 2022 Yiklek
local sys = require("ovim.sys")

local this = {}
this.__index = this

local lazy_opts = {
    root = vim.g.ovim_cache_path .. "/lazy/plugins",
    defaults = {
        lazy = true,
    },
    lockfile = vim.g.ovim_cache_path .. "/lazy/lazy-lock.json",
    readme = { root = vim.g.ovim_cache_path .. "/lazy/readme" },
    state = vim.g.ovim_cache_path .. "/lazy/state.json",
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
    -- print(vim.inspect(vim.tbl_values(config.plugins)))
    ovim.lazy.setup(vim.tbl_values(config.plugins), lazy_opts)
end

-- function this.ensure_plugins()
--     this.load_packer()
--     packer.install()
-- end
--
-- function this.load_compile()
--     if sys.fn.filereadable(packer_config.compile_path) == 1 then
--         sys.cmd("source " .. packer_config.compile_path)
--     else
--         this.load_packer()
--     end
--     vim.cmd [[command! PackerCompile lua require("ovim.pack").compile()]]
--     vim.cmd [[command! PackerInstall lua require("ovim.pack").install()]]
--     vim.cmd [[command! PackerUpdate lua require("ovim.pack").update()]]
--     vim.cmd [[command! PackerSync lua require("ovim.pack").sync()]]
--     vim.cmd [[command! PackerClean lua require("ovim.pack").clean()]]
--     --vim.cmd [[autocmd User PackerComplete lua require("ovim.pack").magic_compile()]]
--     vim.cmd [[command! PackerStatus  lua require("ovim.pack").status()]]
--     vim.g.ovim_packer_setup = 1
-- end
--
--
-- function this.load(plugins)
--     if type(plugins) == "string" then
--         plugins = {plugins}
--     end
--     require("packer.load")(plugins, {}, packer_plugins)
-- end

-- this =
--     setmetatable(
--     this,
--     {
--         __index = function(o, key)
--             return function(...)
--                 this.load_packer()
--                 packer[key](...)
--             end
--         end
--     }
-- )

return this
