-- Module Loader file, this will dofile_once the requested modules.
CL_ModuleCache = {}
---@alias Modules "Vec2"|"ECS"|"PolyUtils"
--- @param module Modules
--- @return any . Return type is specified by overloads
--- @overload fun(module: "Vec2"): Vec2
--- @overload fun(module: "ECS"): ECS
--- @overload fun(module: "PolyUtils"): PolyUtils
local function getModule(module)
    local data = CL_ModuleCache[module]
    if data == nil then
        data = dofile_once("CL_PATHModules/" .. module .. ".lua")
        CL_ModuleCache[module] = data
    end
    return data
end

return getModule