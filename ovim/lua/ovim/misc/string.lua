-- File: string.lua
-- Author: Yiklek
-- Description: string util
-- Copyright (c) 2022 Yiklek
function string:split_lite(sep)
    local splits = {}

    if sep == nil then
        -- return table with whole str
        table.insert(splits, self)
    elseif sep == "" then
        -- return table with each single character
        local len = #self
        for i = 1, len do
            table.insert(splits, self:sub(i, i))
        end
    else
        -- normal split use gmatch
        local pattern = "[^" .. sep .. "]+"
        for str in string.gmatch(self, pattern) do
            table.insert(splits, str)
        end
    end

    return splits
end


return string
