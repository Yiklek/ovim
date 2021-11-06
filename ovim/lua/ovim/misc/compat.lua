require('ovim.misc.string')
local obj = {}
function compat_unpack()
    if tonumber(_VERSION:split_lite(" ")[2]) > 5.1 then
        return table.unpack
    else 
        return unpack
    end
end

obj.unpack = compat_unpack()

return obj
