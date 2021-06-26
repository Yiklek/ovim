local sys = require('ovim.sys')


local pkg = {}
pkg.__index = pkg

local packer_config = {
    package_root = sys.g.ovim_cache_path .. '/pack',
    compile_path = sys.g.ovim_cache_path .. '/packer/compiled.vim',
    opt_default = true,
    disable_commands = true,
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
}
function pkg.load_packer()
    if not packer then
        sys.cmd[[packadd packer.nvim]]
        packer = require('packer')
    end
    packer.init(packer_config)
    packer.reset()
    local use = packer.use
    use {"wbthomason/packer.nvim", opt = true }
    use {'glepnir/indent-guides.nvim', event = "VimEnter" , config = [[require('indent_guides').setup({exclude_filetypes = {'help','dashboard','dashpreview','NvimTree','vista','sagahover','coc-explorer','floaterm','packer'}})]]}
    use {
        "nvim-treesitter/nvim-treesitter",
        event = "VimEnter",
    }
    use {"nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter"}
    use {"p00f/nvim-ts-rainbow", after = "nvim-treesitter"}
    --for _,repo in ipairs(self.repos) do
    --    use(repo)
    --end 
end

function pkg.ensure_plugins()
   pkg.load_packer() 
   packer.install()
end

function pkg.load_compile()
    if sys.fn.filereadable(packer_config.compile_path) == 1 then
        sys.cmd('source '.. packer_config.compile_path)
    else
        assert('Missing packer compile file Run PackerCompile Or PackerInstall to fix')
    end
    vim.cmd [[command! PackerCompile lua require('ovim.pkg').compile()]]
    vim.cmd [[command! PackerInstall lua require('ovim.pkg').install()]]
    vim.cmd [[command! PackerUpdate lua require('ovim.pkg').update()]]
    vim.cmd [[command! PackerSync lua require('ovim.pkg').sync()]]
    vim.cmd [[command! PackerClean lua require('ovim.pkg').clean()]]
    --vim.cmd [[autocmd User PackerComplete lua require('ovim.pkg').magic_compile()]]
    vim.cmd [[command! PackerStatus  lua require('ovim.pkg').status()]]  
end

pkg = setmetatable(pkg,{ __index = function(o,key)
    return function(...)
        pkg.load_packer() 
        packer[key](...)
    end
end})


return pkg
