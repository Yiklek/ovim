-- File: ui/init.lua
-- Author: Yiklek
-- Description: ui init
-- Copyright (c) 2022 Yiklek
local plugins = {
    ["rebelot/kanagawa.nvim"] = {
        "rebelot/kanagawa.nvim",
        lazy = false
    }
}
local features = require("ovim.misc.features").setup_module_features("ui", plugins)
return {
    name = "ui",
    level = 1,
    features = features,
    plugins = plugins
}
