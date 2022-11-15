-- Entity Component System Module, this module provides functions and content to allow easier use and manipulation of the ECS.
-- Compatibility: Lua-5.1
local function split(str, pat)
    local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
          table.insert(t, cap)
       end
       last_end = e+1
       s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
       cap = str:sub(last_end)
       table.insert(t, cap)
    end
    return t
 end

 --- @class Component
--- @field entityID number
--- @field compID number
local Component = {}
--- @class Entity
--- @field entityID number
local Entity = {}

function Entity:New(id)
    id = id or GetUpdatedEntityID()
    if id == nil then error("Can't create an entity without a specified ID if GetUpdatedEntityID does not work in the context", 2) end
    local o = {}
    o.entityID = id
    setmetatable(o, Entity)
    return o;
end

function Entity:__index(k)
    if k == "transform" then
        local x, y, r, sx, sy = EntityGetTransform(self.entityID)
        return {
            x = x,
            y = y,
            rotation = r,
            scale_x = sx,
            scale_y = sy
        }
    end
    if k == "name" then
        return EntityGetName(self.entityID)
    end
    if k == "tags" then
        return split(EntityGetTags(self.entityID), ",")
    end
    if k == "filepath" then
        return EntityGetFilename(self.entityID)
    end
    if k == "parent" then
        local id = EntityGetParent(self.entityID)
        return (id ~= nil and Entity:New(id)) or nil
    end
    if k == "children" then
        local c = EntityGetAllChildren(self.entityID)
        if c == nil then return nil end
        local e = {}
        for _, v in ipairs(c) do
            table.insert(e, Entity:New(v))
        end
        return e
    end

    if Entity[k] ~= nil then
        return Entity[k]
    end   
    -- Assume the user is trying to get a component
    local comps = EntityGetComponentIncludingDisabled(self.entityID, k)
    if comps == nil then
        return nil
    end
    local firstComp = Component:New(self.entityID, comps[1])
    function firstComp:__index(f)
        if f == "disabled" then
            return ComponentGetIsEnabled(self.compID)
        end
        if type(f) == "number" then
            return Component:New(self.entityID, comps[f])
        end
        return ComponentGetValue2(self.compID, f)
    end
    return firstComp
end

function Entity:__newindex(k, v)
    if k == "name" then
        EntitySetName(self.entityID, v)
    end
end

function Entity:SetTransform(nt)
    local x, y, r, sx, sy = EntityGetTransform(self.entityID)
    if nt.x ~= nil then x = nt.x end
    if nt.y ~= nil then y = nt.y end
    if nt.rotation ~= nil then r = nt.rotation end
    if nt.scale_x ~= nil then sx = nt.scale_x end
    if nt.scale_y ~= nil then sy = nt.scale_y end
    EntitySetTransform(self.entityID, x, y, r, sx, sy)
    return self
end

function Entity:AddChild(child)
    if type(child) == "number" then
        EntityAddChild(self.entityID, child)
    else
        EntityAddChild(self.entityID, child.entityID)
    end
    return self
end

function Entity:Deparent()
    EntityRemoveFromParent(self.entityID)
    return self
end

function Entity:Kill()
    EntityKill(self.entityID)
end

function Entity:AddComponent(type, data)
    EntityAddComponent2(self.entityID, type, data)
    return self
end

function Entity:Damage(amount, type, desc, rag_fx, imp_x, imp_y, entity_responsible, pos_x, pos_y, knockback_force)
    EntityInflictDamage(self.entityID, amount, type, desc, rag_fx, imp_x, imp_y, entity_responsible, pos_x, pos_y, knockback_force)
end

function Entity:Ingest(material, amount)
    if type(material) == "number" then
        EntityIngestMaterial(self.entityID, material, amount)
    else 
        EntityIngestMaterial(self.entityID, CellFactory_GetType(material), amount)
    end
end

function Component:New(eid, cid)
    local o = {}
    o.entityID = eid
    o.compID = cid
    setmetatable(o, Component)
    return o;
end

function Component:__index(k)
    if k == "disabled" then
        return ComponentGetIsEnabled(self.compID)
    end
    return ComponentGetValue2(self.compID, k)
end

function Component:__newindex(k ,v)
    if k == "disabled" then
        EntitySetComponentIsEnabled(self.entityID, self.compID, v)
    end
    ComponentSetValue2(self.compID, k, v)
end

function Component:Remove()
    EntityRemoveComponent(self.entityID, self.compID)
end

--- @class ECS
local ECS = {}
function ECS:__index(k)
    if k == "Player" then
        return Entity:New(EntityGetWithTag("player_unit")[1])
    end
end

function ECS:FromID(id)
    return Entity:New(id)
end

function ECS:Load(file, x, y)
    return Entity:New(EntityLoad(file, x, y))
end

function ECS:LoadCameraBound(file, x, y)
    return Entity:New(EntityLoad(file, x, y))
end

function ECS:WithTag(tag)
    local entities = EntityGetWithTag(tag)
    local i = {}
    for _, v in ipairs(entities) do 
        table.insert(i, Entity:New(v))
    end
    return i
end

function ECS:WithName(name)
    return Entity:New(EntityGetWithName(name))
end

function ECS:InRadius(x, y, radius, tag)
    if tag ~= nil then 
        local entities = EntityGetInRadiusWithTag(x, y, radius, tag)
        local i = {}
        for _, v in ipairs(entities) do 
            table.insert(i, Entity:New(v))
        end
        return i
    else 
        local entities = EntityGetInRadius(x, y, radius)
        local i = {}
        for _, v in ipairs(entities) do 
            table.insert(i, Entity:New(v))
        end
        return i
    end
end

function ECS:Closest(x, y, tag)
    if tag ~= nil then 
        return Entity:New(EntityGetClosest(x, y))
    else 
        return Entity:New(EntityGetClosestWithTag(x, y, tag))
    end
end

setmetatable(ECS, ECS)
return ECS