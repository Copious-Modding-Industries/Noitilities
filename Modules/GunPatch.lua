function PatchGunSystem()
    -- check if patch is actually applied
    if not ModSettingGet("Noitilities.GunSystemPatched") then
        ModSettingSet("Noitilities.GunSystemPatched", true)
        -- apply patch
        ModLuaFileAppend( "data/scripts/gun/gun.lua", "NL_PATH/Assets/GunPatch/GunPatches.lua" );
    end
end