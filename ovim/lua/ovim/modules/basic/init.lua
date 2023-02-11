-- File: config.lua
-- Author: Yiklek
-- Description: global config
-- Copyright (c) 2022 Yiklek
local plugins = {
  ["tweekmonster/startuptime.vim"] = {
    "tweekmonster/startuptime.vim",
    level = 0,
    cmd = "StartupTime",
  },
  ["lambdalisue/suda.vim"] = {
    "lambdalisue/suda.vim",
    level = 0,
    cmd = { "SudaRead", "SudaWrite" },
  },
}
return {
  plugins = plugins,
}
