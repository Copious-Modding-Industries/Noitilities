-- Module Loader file, this will dofile_once the requested modules.
NL_ModuleCache = {}
return setmetatable({
    Load = function (modules)
        local loaded = {}
        for _, v in ipairs(modules) do
            NL_ModuleCache[v] = NL_ModuleCache[v] or dofile_once("NL_PATH/Modules/" .. v .. ".lua")
            table.insert(loaded, NL_ModuleCache[v])
        end
        return table.unpack(loaded)
    end
}, {
    __index = function (_, k)
        NL_ModuleCache[k] = NL_ModuleCache[k] or dofile_once("NL_PATH/Modules/" .. k .. ".lua")
        return NL_ModuleCache[k]
    end
})
