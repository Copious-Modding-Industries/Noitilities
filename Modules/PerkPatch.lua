--- Applies a patch to `data/scripts/perks/perk_reflect.lua` so that perks with the value `progress_hidden` set to `true` will not show up in the progress menu. Will skip execution if the patch is already applied by another instance of Noitilities.
function PatchPerkReflection()
    -- check if patch is actually applied
    if not ModSettingGet("Noitilities.PerkReflectionPatched") then
        ModSettingSet("Noitilities.PerkReflectionPatched", true)
        -- apply patch
        local filetext = ModTextFileGetContent("data/scripts/perks/perk_reflect.lua")
        filetext = filetext:gsub(
            [[RegisterPerk(]],
            [[
if not perk.progress_hidden then
    RegisterPerk(]])
        filetext = filetext:gsub(
            [[end]],
            [[	end
end]])
    ModTextFileSetContent("data/scripts/perks/perk_reflect.lua", filetext)
    end
end