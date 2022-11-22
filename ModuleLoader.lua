-- Module Loader file, this will dofile_once the requested modules.
NL_ModuleCache = {}
return setmetatable({}, {
    __index = function (_, k)
        NL_ModuleCache[k] = NL_ModuleCache[k] or dofile_once("NL_PATH/Modules/" .. k .. ".lua")
        return NL_ModuleCache[k]
    end
})