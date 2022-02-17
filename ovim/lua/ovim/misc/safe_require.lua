local function safe_require(module)
    return try {
        function()
            return require(module)
        end,
        function(e)
            print('require '..module..'failed.')
        end
    }
end
return safe_require
