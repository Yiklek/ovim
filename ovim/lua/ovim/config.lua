local plugins = {
    ["wbthomason/packer.nvim"] = {"wbthomason/packer.nvim", opt = true},
    ["glepnir/indent-guides.nvim"] = {
        "glepnir/indent-guides.nvim",
        event = "VimEnter",
        opt = true,
        config = [[require("ovim.pack").require("ovim.pkgs.indent-guides")]]
    },
    ["nvim-treesitter/nvim-treesitter"] = {
        "nvim-treesitter/nvim-treesitter",
        event = "VimEnter",
        opt = true,
        config = [[require("ovim.pack").require("ovim.pkgs.nvim-treesitter")]]
    },
    ["nvim-treesitter/nvim-treesitter-textobjects"] = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        opt = true,
        after = "nvim-treesitter"
    },
    ["p00f/nvim-ts-rainbow"] = {
        "p00f/nvim-ts-rainbow",
        opt = true,
        after = "nvim-treesitter"
    },
    ["nvim-treesitter/nvim-treesitter-refactor"] = {
        "nvim-treesitter/nvim-treesitter-refactor",
        opt = true,
        after = "nvim-treesitter"
    }
}
return {
    plugins = plugins
}
