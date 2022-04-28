-- File: config.lua
-- Author: Yiklek
-- Description: global config
-- Copyright (c) 2022 Yiklek
local plugins = {
    ["wbthomason/packer.nvim"] = {"wbthomason/packer.nvim", opt = true},
    ["tweekmonster/startuptime.vim"] = {
        "tweekmonster/startuptime.vim",
        level = 0,
        cmd = "StartupTime",
        opt = true
    },
    ["nvim-lua/plenary.nvim"] = {
        "nvim-lua/plenary.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewRefresh",
            "DiffviewFileHistory",
            "Telescope",
        }
    }
}
return {
    plugins = plugins
}
