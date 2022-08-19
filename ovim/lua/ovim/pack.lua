-- File: pack.lua
-- Author: Yiklek
-- Description: pack
-- Copyright (c) 2022 Yiklek
local sys = require("ovim.sys")

local this = {}
this.__index = this

local packer_config = {
    package_root = sys.g.ovim_cache_path .. "/pack",
    compile_path = sys.g.ovim_packer_compiled_path,
    opt_default = true,
    disable_commands = true,
    display = {
        open_fn = function()
            return require("packer.util").float({border = "single"})
        end
    }
}
function this.load_packer()
    if not packer then
        sys.cmd [[packadd packer.nvim]]
        _G.packer = require("packer")
    end
    packer.init(packer_config)
    packer.reset()
    local use = packer.use
    local config = require("ovim.config")
    local util = require("ovim.misc.util")
    local modules = util.detect_modules()

    for _, module in pairs(modules) do
        local m = require(module)
        local level = m.level or 0
        local condition = vim.fn.luaeval(m.condition or true)
        if level < 4 and condition then
            config.plugins = vim.tbl_deep_extend("force", config.plugins, m.plugins)
        end
    end
    for _, repo in pairs(config.plugins) do
        if (repo.level or 1) < 4 then
            use(repo)
        end
    end
end

function this.ensure_plugins()
    this.load_packer()
    packer.install()
end

function this.load_compile()
    if sys.fn.filereadable(packer_config.compile_path) == 1 then
        sys.cmd("source " .. packer_config.compile_path)
    else
        this.load_packer()
    end
    vim.cmd [[command! PackerCompile lua require("ovim.pack").compile()]]
    vim.cmd [[command! PackerInstall lua require("ovim.pack").install()]]
    vim.cmd [[command! PackerUpdate lua require("ovim.pack").update()]]
    vim.cmd [[command! PackerSync lua require("ovim.pack").sync()]]
    vim.cmd [[command! PackerClean lua require("ovim.pack").clean()]]
    --vim.cmd [[autocmd User PackerComplete lua require("ovim.pack").magic_compile()]]
    vim.cmd [[command! PackerStatus  lua require("ovim.pack").status()]]
    vim.g.ovim_packer_setup = 1
end

this =
    setmetatable(
    this,
    {
        __index = function(o, key)
            return function(...)
                this.load_packer()
                packer[key](...)
            end
        end
    }
)

return this
