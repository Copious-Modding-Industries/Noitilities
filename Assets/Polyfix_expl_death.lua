local entity_id = GetUpdatedEntityID()
local proj = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
if proj then
    ComponentSetValue2(proj, "on_death_explode", true)
end