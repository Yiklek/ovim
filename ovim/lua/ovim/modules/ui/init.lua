-- File: ui/init.lua
-- Author: Yiklek
-- Description: ui init
-- Copyright (c) 2022 Yiklek
local plugins = {
    ["glepnir/indent-guides.nvim"] = {
        "glepnir/indent-guides.nvim",
        event = "VimEnter",
        opt = true,
        config = [[require("ovim.misc.safe_require")("ovim.modules.ui.config").indent_guides()]]
    }
}
local features = require("ovim.modules.ui.features")
local config_features = require("ovim.config").modules.ui.features
require("ovim.misc.features").setup_module_features(plugins, config_features, features)
return {
    name = "ui",
    level = 1,
    features = features,
    plugins = plugins
}
