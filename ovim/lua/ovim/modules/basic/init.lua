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
    }
}
return {
    plugins = plugins
}
