-- File: compat.lua
-- Author: Yiklek
-- Description: compat util for different version lua
-- Copyright (c) 2022 Yiklek
require('ovim.misc.string')
local obj = {}
local function compat_unpack()
    if tonumber(_VERSION:split_lite(" ")[2]) > 5.1 then
        return table.unpack
    else
        return unpack
    end
end

obj.unpack = compat_unpack()

return obj
