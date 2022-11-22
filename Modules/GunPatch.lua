function PatchGunSystem()
    -- check if patch is actually applied
    if not ModSettingGet("Noitilities.GunSystemPatched") then
        ModSettingSet("Noitilities.GunSystemPatched", true)

        -- apply gun.lua patch
        ModLuaFileAppend( "data/scripts/gun/gun.lua", "NL_PATH/Assets/GunPatch/GunPatches.lua" );
        
        -- apply reflection patch
        local filetext = ModTextFileGetContent("data/scripts/gun/gun_collect_metadata.lua")
        filetext = filetext:gsub(
            [[for i,action in ipairs(actions) do]],
            [[for i,action in ipairs(actions) do
if not action.progress_hidden then
]])
        filetext = filetext:gsub(
            [[register_action( c )]],
            [[register_action( c )
end]])
    --ModTextFileSetContent("data/scripts/gun/gun_collect_metadata.lua", filetext)
    end
end