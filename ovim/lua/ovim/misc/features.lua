local function setup_module_features(plugins, config_features, registered_features)
    for key, value in pairs(config_features) do
        if registered_features[key] == nil then
            print("feature " .. key .. " has not registered.")
        end
        if value ~= nil and value.enable then
            registered_features[key](plugins, value)
        end
    end
end

return {
    setup_module_features = setup_module_features
}
