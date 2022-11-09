--- @param key string The translation key you wish to write to"]
--- @param value string The value you will assign to the key
--- @param translation string|nil An existing formatted translation line, will generate if nil
--- @param language string|nil The language you will assign the value to, defaults to `"en"`
--- ***
--- @return string translation The formatted translation line
function FormatTranslation(key, value, translation, language)
    if not translation then
        translation = ""
    end
    return translation
end

--- @param translations table An indexed table following this format:
--[[
```lua
local translations = {
    ["en"] = {
        ["action_bomb"] = "Bomb",
        ["actiondesc_bomb"] = "Summons a bomb that destroys ground very efficiently",
    },
    ["ru"] = {
        ["action_bomb"] = "Бомба",
        ["actiondesc_bomb"] = "Призыв бомбы, которая очень эффективно разрушает землю",
    },
}
```
]]
--- ***
--- @return string csv The generated translation .CSV text file contents
function GenerateCSV(translation_table)
    local csv = ""
    for language, translations in ipairs(translation_table) do
        for key, value in ipairs(translations) do
            -- SOMETHING
        end
    end
    return csv
end

local translations = {
    ["en"] = {
        ["action_bomb"] = "Bomb",
        ["actiondesc_bomb"] = "Summons a bomb that destroys ground very efficiently",
        ["action_light_bullet"] = "Spark bolt",
        ["actiondesc_light_bullet"] = "A weak but enchanting sparkling projectile",
    },
    ["ru"] = {
        ["action_bomb"] = "Бомба",
        ["actiondesc_bomb"] = "Призыв бомбы, которая очень эффективно разрушает землю",
        ["action_light_bullet"] = "Искровая молния",
        ["actiondesc_light_bullet"] = "Очаровательно сверкающий",
    },
    ["pt-br"] = {
        ["action_bomb"] = "Bomba",
        ["actiondesc_bomb"] = "Evoca uma bomba que destrói o chão de forma muito eficiente.",
        ["action_light_bullet"] = "Fagulha",
        ["actiondesc_light_bullet"] = "Um projétil fraco, reluzente e encantador.",
    }
}
