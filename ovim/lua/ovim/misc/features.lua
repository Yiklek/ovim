-- File: features.lua
-- Author: ovim
-- Description: features
-- Last Modified: 02 18, 2022
-- Copyright (c) 2022 ovim

local function setup_module_features_internal(plugins, config_features, registered_features)
    for key, value in pairs(config_features) do
        if registered_features[key] == nil then
            print("feature " .. key .. " has not registered.")
        elseif value ~= nil and value.enable then
            registered_features[key](plugins, value)
        end
    end
end

local function setup_module_features(module, plugins)
    local full_module = string.format("ovim.modules.%s.features", module)
    local features = require(full_module)
    local config_features = require("ovim.config").modules[module].features
    setup_module_features_internal(plugins, config_features, features)
    return features
end
return {
    setup_module_features = setup_module_features
}
