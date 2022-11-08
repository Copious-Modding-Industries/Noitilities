-- PolyUtils Library, this module provides PolyTools style manipulation of entities.
--- @class PolyUtils
PolyUtils = {}

local function polymorph_fixes(entity_id)
    if entity_id == nil or not EntityGetIsAlive(entity_id) then
        print("Attempted to polymorph an entity that doesn't exist")
        return false
    end
    local proj = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
    if proj then
        if ComponentGetValue2(proj, "on_death_explode") then
            ComponentSetValue2(proj, "on_death_explode", false)
            EntityAddComponent2(entity_id, "LuaComponent", {
                script_source_file = "NL_PATH/Assets/fix_explode_death.lua",
                execute_every_n_frame = 1,
                remove_after_executed = true
            })
        end
        if ComponentGetValue2(proj, "on_lifetime_out_explode") then
            ComponentSetValue2(proj, "on_lifetime_out_explode", false)
            EntityAddComponent2(entity_id, "LuaComponent", {
                script_source_file = "NL_PATH/Assets/fix_explode_lifetime.lua",
                execute_every_n_frame = 1,
                remove_after_executed = true
            })
        end
    end
    return true
end

--- @param entity_id integer The *Entity ID* of the entity you wish to polymorph from.
--- @param target_path string The *File Path* of the entity you wish to polymorph to.
--- @param duration integer The *Frames* you wish to polymorph the entity to.
--- @param keep_ui boolean Wether the game's UI should be kept while polymorphed.
--- @param components_file string `[I DONT KNOW THIS]`
--- @param end_on_death boolean Wether the entity should stop being polymorphed on death.
--- ***
--- @return integer|nil effect The effect entity.
function PolyUtils.EntityPolymorphToEntity( entity_id, target_path, duration, keep_ui, components_file, end_on_death)
    if polymorph_fixes(entity_id) then
        local effect = LoadGameEffectEntityTo(entity_id, "NL_PATH/Assets/effect.xml")
        local effect_component = EntityGetFirstComponentIncludingDisabled(entity_id, "GameEffectComponent")
        if effect_component ~= nil then
            ComponentSetValue2(effect_component, "polymorph_target", target_path)
            ComponentSetValue2(effect_component, "duration", duration)
            EntityAddComponent2(entity_id, "VariableStorageComponent", { name = "keep_ui",          var_bool = keep_ui })
            EntityAddComponent2(entity_id, "VariableStorageComponent", { name = "end_on_death",     var_bool = end_on_death })
            EntityAddComponent2(entity_id, "VariableStorageComponent", { name = "components_file",  var_string = components_file })
        end
        return effect
    end
end
