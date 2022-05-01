-- File: util.lua
-- Author: Yiklek
-- Description: util
-- Copyright (c) 2022 Yiklek
local obj = {}
local detect_modules = function()
    local list = {}
    local modules_dir = vim.g.ovim_root_path .. '/lua/ovim/modules'
    local plugins_pattern = "*/init.lua"
    local modules = vim.fn.globpath(modules_dir, plugins_pattern, 0, 1)
    for _, f in ipairs(modules) do
        list[#list + 1] =  f:sub(#modules_dir + 2, -#plugins_pattern)
    end
    return list
end
local module = function(module)
    return string.format('ovim.modules.%s', module)
end

obj.detect_modules = detect_modules
obj.module = module
function obj.has_win()
    return vim.fn.has("win64") == 1
            or vim.fn.has("win32") == 1
            or vim.fn.has("win16") == 1
            or vim.fn.has("win95") == 1
end
return obj
