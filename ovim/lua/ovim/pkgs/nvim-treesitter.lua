require "nvim-treesitter.configs".setup {
    ensure_installed = {'c', 'cpp',
        'python', 'rust', 'vim', 'javascript',
        'lua', 'toml', 'json'
    },
    indent = {
      enable = true
    },
    highlight = {
        enable = true,
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    }
}
