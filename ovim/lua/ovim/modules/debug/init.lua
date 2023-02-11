-- File: debug/init.lua
-- Author: Yiklek
-- Description: ui init
-- Copyright (c) 2022 Yiklek
local plugins = {}
local features = require("ovim.misc.features").setup_module_features("debug", plugins)
return {
  name = "debug",
  level = 1,
  features = features,
  plugins = plugins,
}
