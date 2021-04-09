print("ovim lua init start")

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
-- 打印错误信息
local function __TRACKBACK__(errmsg)
    local track_text = debug.traceback(tostring(errmsg), 6);
    print("---------------------------------------- TRACKBACK ----------------------------------------");
    print(track_text, "LUA ERROR");
    print("---------------------------------------- TRACKBACK ----------------------------------------");
    local exception_text = "LUA EXCEPTION\n" .. track_text;
    return false;
end

if tonumber(_VERSION:split_lite(" ")[2]) > 5.1 then
    compat_unpack = table.unpack
else 
    compat_unpack = unpack
end
--[[ 尝试调一个function 这个function可以带可变参数
如果被调用的函数有异常 返回false，退出此方法继续执行其他代码并打印出异常信息；]]
function trycall(func, ...)
    local args = { ... };
    return xpcall(function() func(compat_unpack(args)) end, __TRACKBACK__);
end
--测试代码：
return trycall(function() return require('packer').startup(empty) end , __TRACKBACK__)
