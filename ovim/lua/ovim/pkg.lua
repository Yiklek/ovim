local sys = require("ovim.sys")

local pkg = {}
pkg.__index = pkg

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
function pkg.load_packer()
    if not packer then
        sys.cmd [[packadd packer.nvim]]
        packer = require("packer")
    end
    packer.init(packer_config)
    packer.reset()
    local use = packer.use
    local config = require("ovim.config")
    for i, repo in pairs(config.plugins) do
        use(repo)
    end
end

function pkg.ensure_plugins()
    pkg.load_packer()
    packer.install()
end

function pkg.check_and_require(plugin, module)
    if packer_plugins[plugin] and packer_plugins[plugin].loaded then
        require(module)
    end
end
function pkg.require(plugin, module)
    return function()
        pkg.check_and_require(plugin, module)
    end
end

function pkg.check_and_call(plugin, callback)
    if packer_plugins[plugin] and packer_plugins[plugin].loaded then
        callback()
    end
end

function pkg.load_compile()
    if sys.fn.filereadable(packer_config.compile_path) == 1 then
        sys.cmd("source " .. packer_config.compile_path)
    else
        pkg.load_packer()
    end
    vim.cmd [[command! PackerCompile lua require('ovim.pkg').compile()]]
    vim.cmd [[command! PackerInstall lua require('ovim.pkg').install()]]
    vim.cmd [[command! PackerUpdate lua require('ovim.pkg').update()]]
    vim.cmd [[command! PackerSync lua require('ovim.pkg').sync()]]
    vim.cmd [[command! PackerClean lua require('ovim.pkg').clean()]]
    --vim.cmd [[autocmd User PackerComplete lua require('ovim.pkg').magic_compile()]]
    vim.cmd [[command! PackerStatus  lua require('ovim.pkg').status()]]
    vim.g.ovim_packer_setup = 1
end

pkg =
    setmetatable(
    pkg,
    {
        __index = function(o, key)
            return function(...)
                pkg.load_packer()
                packer[key](...)
            end
        end
    }
)

return pkg
