DataStorage = {}

function DataStorage:GetEntityStore(name)
    local store = EntityGetWithName("noitilities_table_store_" .. name)
    if store == nil then
        store = EntityCreateNew("noitilities_table_store_" .. name)
    end
    return setmetatable({}, {
        __index = function(_, k)
            local s = EntityGetFirstComponent(store, "VariableStorageComponent", k)
            if s == nil then return nil end
            local value = ComponentGetValue2(s, "value_string")
            value = value or ComponentGetValue2(s, "value_bool")
            value = value or ComponentGetValue2(s, "value_float")
            if value == "__SUBTABLE__" then return self:GetEntityStore(k) end
            return value
        end,
        __newindex = function(_, k, v)
            local s = EntityGetFirstComponent(store, "VariableStorageComponent", k)
            if s == nil then s = EntityAddComponent2(store, "VariableStorageComponent", { _tags = k .. "," })
                if type(v) == "nil" then
                    EntityRemoveComponent(store, s)
                    return
                end
                if type(v) == "number" then
                    ComponentSetValue2(s, "value_float", v)
                    ComponentSetValue2(s, "value_bool", nil)
                    ComponentSetValue2(s, "value_string", nil)
                    return
                end
                if type(v) == "boolean" then
                    ComponentSetValue2(s, "value_bool", v)
                    ComponentSetValue2(s, "value_float", nil)
                    ComponentSetValue2(s, "value_string", nil)
                    return
                end
                if type(v) == "string" then 
                    ComponentSetValue2(s, "value_string", v)
                    ComponentSetValue2(s, "value_bool", nil)
                    ComponentSetValue2(s, "value_float", nil)
                    return
                end
                if type(v) == "table" then 
                    ComponentSetValue2(s, "value_string", "__SUBTABLE__")
                    ComponentSetValue2(s, "value_bool", nil)
                    ComponentSetValue2(s, "value_float", nil)
                    local newstore = DataStorage:GetEntityStore(("noitilities_subtable_%s_%s"):format(name, k))
                    for key, value in pairs(v) do
                        newstore[key] = value
                    end
                    return
                end
            end
        end
    })
end
