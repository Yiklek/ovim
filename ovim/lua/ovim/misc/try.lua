-- File: try.lua
-- Author: Yiklek
-- Description: try
-- Copyright (c) 2022 Yiklek
local function try(body)
    -- body
    if body == nil or body[1] == nil then
       return
    end
    local catch = body['catch'] or body[2] or nil
    local finally = body['finally'] or body[3] or nil
    local final_result = nil
    local err_dict = {}
    local catch_success, catch_result = nil ,nil
    local final_success, final_result = nil ,nil
    local error_process = function(err_store)
        return function(err)
            err_dict[err_store] = debug.traceback(err,2)
        end
    end
    local call_success, call_result = xpcall(body[1], error_process("call"))
    if not call_success and catch ~= nil then
        catch_success, catch_result = xpcall(function(e) return catch(e) end, error_process("catch"))
    end
    if finally ~= nil then
        final_success, final_result = xpcall(function(e) return finally(e) end, error_process("final"))
    end


    if call_success and catch_success ~= false and final_success ~= false  then
        return final_result or catch_result or call_result
    elseif not call_success and catch_success and final_success ~= false  then
        return final_result or catch_result or call_result
    end
    if final_success == false then
        error('\nfinally:' .. err_dict.final .. '\ncatch:' .. tostring(err_dict.catch) .. '\ncall:' .. tostring(err_dict.call), 2)
    end
    if catch_success == false then
        error('\ncatch:' .. err_dict.catch.. '\ncall:'.. tostring(err_dict.call), 2)
    end
    if call_success == false then
        error('\ncall:' .. err_dict.call, 2)
    end
end



return try
