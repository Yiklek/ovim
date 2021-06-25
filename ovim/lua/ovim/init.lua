ovim = {}
ovim.compat = require('ovim.compat')
ovim.sys = require('ovim.sys')
ovim.pkg = require('ovim.pkg')
-- 打印错误信息
local function __TRACKBACK__(errmsg)
    local track_text = debug.traceback(tostring(errmsg), 6);
    print("---------------------------------------- TRACKBACK ----------------------------------------");
    print(track_text, "LUA ERROR");
    print("---------------------------------------- TRACKBACK ----------------------------------------");
    local exception_text = "LUA EXCEPTION\n" .. track_text;
    return false;
end


ovim.pkg:ensure_plugins()
ovim.pkg:load_compile()
--[[ 尝试调一个function 这个function可以带可变参数
如果被调用的函数有异常 返回false，退出此方法继续执行其他代码并打印出异常信息；]]
function trycall(func, callback, ...)
    local args = { ... };
    return xpcall(function() func(ovim.compat.unpack(args)) end, callback);
end
--测试代码：
--trycall(function() return require('packer').startup({packer_startup,config = packer_config}) end, __TRACKBACK__)
return 1
