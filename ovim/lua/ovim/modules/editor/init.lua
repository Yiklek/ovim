-- File: editor/init.lua
-- Author: Yiklek
-- Description: editor init
-- Copyright (c) 2022 Yiklek
local plugins = {
}
local features = require("ovim.modules.editor.features")
local config_features = require("ovim.config").modules.editor.features
require("ovim.misc.features").setup_module_features(plugins, config_features, features)
return {
    name = "editor",
    level = 1,
    features = features,
    plugins = plugins
}
