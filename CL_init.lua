---@diagnostic disable: undefined-global
-- Initialization file, this will initialize the Noitilities Library.
return {
    --- @param path string
    --- @return nil
    init = function(path)
        path = path:gsub("/$", "") .. "/"
        local files = {
            "ModuleLoader.lua",
            "Modules/ECS.lua",
            "Modules/PolyUtils.lua",
            "Modules/Vec2.lua",
            "Modules/Base64.lua"
        }
        for i, v in ipairs(files) do
            local m = ModTextFileGetContent(path .. v)
            m = m:gsub("NL_PATH/", path)
            ModTextFileSetContent(path .. v, m)
        end
    end
}