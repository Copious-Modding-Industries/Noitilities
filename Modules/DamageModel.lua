--- @class DamageModel

--[[
SetDamageMultipliers in:table 
GetDamageMultipliers out:table
SetMaterialDamage
GetMaterialDamage



mDamageMaterials
mDamageMaterialsHowMuch
]]

local matdamageplayer = {
    ["acid"] = 0.005,
    ["lava"] = 0.003,
    ["blood_cold_vapour"] = 0.0006,
    ["blood_cold"] = 0.0009,
    ["poison"] = 0.001,
    ["radioactive_gas"] = 0.001,
    ["radioactive_gas_static"] = 0.001,
    ["rock_static_radioactive"] = 0.001,
    ["rock_static_poison"] = 0.001,
    ["ice_radioactive_static"] = 0.001,
    ["ice_radioactive_glass"] = 0.001,
    ["ice_acid_static"] = 0.001,
    ["ice_acid_glass"] = 0.001,
    ["rock_static_cursed"] = 0.005,
    ["magic_gas_hp_regeneration"] = -0.005,
    ["gold_radioactive"] = 0.0002,
    ["gold_static_radioactive"] = 0.0002,
    ["rock_static_cursed_green"] = 0.004,
    ["cursed_liquid"] = 0.0005,
    ["poo_gas"] = 0.00001,
}