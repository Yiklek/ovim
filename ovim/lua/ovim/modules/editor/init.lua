-- File: editor/init.lua
-- Author: Yiklek
-- Description: editor init
-- Copyright (c) 2022 Yiklek
local plugins = {
}
local features = require("ovim.misc.features").setup_module_features("editor", plugins)
return {
    name = "editor",
    level = 1,
    features = features,
    plugins = plugins
}
