-- File: util.lua
-- Author: Yiklek
-- Description: util
-- Copyright (c) 2022 Yiklek
local obj = {}
local detect_modules = function()
  local list = {}
  local modules_dir = ovim.const.root_path .. "/lua/ovim/modules"
  local plugins_pattern = "*/init.lua"
  local modules = vim.fn.globpath(modules_dir, plugins_pattern, 0, 1)
  for _, f in ipairs(modules) do
    list[#list + 1] = string.match(f, "lua/(.+)/init.lua$")
  end
  return list
end

obj.detect_modules = detect_modules

function obj.has_win()
  return vim.fn.has "win64" == 1 or vim.fn.has "win32" == 1 or vim.fn.has "win16" == 1 or vim.fn.has "win95" == 1
end
return obj
