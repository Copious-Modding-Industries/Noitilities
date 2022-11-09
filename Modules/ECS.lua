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

--- @class Entity
--- @field entityID number
local Entity = {}

function Entity:New(id)
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
    return Entity[k]
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
end

function Entity:AddChild(child)
    if type(child) == "number" then
        EntityAddChild(self.entityID, child)
    else
        EntityAddChild(self.entityID, child.entityID)
    end
end

function Entity:Deparent()
    EntityRemoveFromParent(self.entityID)
end

function Entity:Kill()
    EntityKill(self.entityID)
end

--- @class Component
--- @field entityID number
--- @field compID number
local Component = {}

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