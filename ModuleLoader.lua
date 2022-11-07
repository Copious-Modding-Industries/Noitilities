-- Module Loader file, this will dofile_once the requested modules.

--- @param modules table A table of string module names, will call `dofile_once()` on each requested module.
--- ***
--- -@return -- Maybe return a table of return values? 
function DofileModules( modules )
    for _, module_name in ipairs(modules) do
        dofile_once("#COPI_LIB_PATH#/" .. module_name)
    end
end