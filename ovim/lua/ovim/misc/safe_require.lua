-- File: safe_require.lua
-- Author: Yiklek
-- Description: safe require
-- Copyright (c) 2022 Yiklek
local function safe_require(module)
    return try {
        function()
            return require(module)
        end,
        function(e)
            if ovim.debug then
                print('require '..module..' failed.')
                print(e)
                print(debug.traceback("safe_require"))
            end
        end
    }
end
return safe_require
