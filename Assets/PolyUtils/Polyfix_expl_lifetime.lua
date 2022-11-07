local entity_id = GetUpdatedEntityID()
local proj = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
if proj then
    ComponentSetValue2(proj, "on_lifetime_out_explode", true)
end