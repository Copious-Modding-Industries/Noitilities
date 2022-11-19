--[[
    Patch data/scripts/perks/perk_reflect.lua to allow perk hiding:
    === BEFORE ===
    dofile( "data/scripts/perks/perk_list.lua" )

    for i,perk in ipairs(perk_list) do
        RegisterPerk( 
            perk.id,
            perk.ui_name,
            perk.ui_description,
            perk.ui_icon,
            perk.perk_icon
            )
    end
    === AFTER ===
    dofile( "data/scripts/perks/perk_list.lua" )

    for i,perk in ipairs(perk_list) do
        if not perk.progress_hidden then
            RegisterPerk( 
                perk.id,
                perk.ui_name,
                perk.ui_description,
                perk.ui_icon,
                perk.perk_icon
                )
        end
    end
    =========
    Users will need to add the value "progress_hidden = true" to their perk but it will be hidden
]]

function PatchPerkReflection()
    -- check to see if patch is applied
    if not ModSettingGet("Noitilities.PerkReflectionPatched") then
        -- flag to make sure it doesn't re-patch
        ModSettingSet("Noitilities.PerkReflectionPatched", true)
        -- get old file contents
        local filetext = ModTextFileGetContent("data/scripts/perks/perk_reflect.lua")
        -- apply patch
        filetext = filetext:gsub(
            [[	RegisterPerk( ]],
            [[	RegisterPerk( 
    if not perk.progress_hidden then]])
        filetext = filetext:gsub(
            [[end]],
            [[	end
end]])
    ModTextFileSetContent("data/scripts/perks/perk_reflect.lua", filetext)
    end
end