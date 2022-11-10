--[[
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
]]
--- @param translation_table table An indexed table following this format:
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
function CSVGenFromLang(translation_table)
    local csv = ""
    local tr_by_key = {}
    for language, translations in ipairs(translation_table) do
        for key, value in ipairs(translations) do
            if tr_by_key[key] == nil then
                table.insert(tr_by_key, key)
            end
        end
    end
    return csv
end
--[[
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
]]

--- @param translation_table table An indexed table following this format:
--[[
```lua
local translations = {
    ["action_bomb"] = {
        ["en"] = "Bomb",
        ["ru"] = "Бомба",
    },
    ["actiondesc_bomb"] = {
        ["en"] = "Summons a bomb that destroys ground very efficiently",
        ["ru"] = "Призыв бомбы, которая очень эффективно разрушает землю",
    },
}
```
]]
--- ***
--- @return string csv The generated translation .CSV text file contents
function CSVGenFromKeys(translation_table)
    local csv = ""
    local languages = {"en","ru","pt-br","es-es","de","fr-fr","it","pl","zh-cn","jp","ko"}
    for key, translations in pairs(translation_table) do
        setmetatable(translations, {__index = function(_, _) return "" end})
        csv = csv .. key .. ","
        for language in pairs(languages) do
            csv = csv .. translations[language]
        end
        csv = csv .. "\n"
    end
    return csv
end

local keytrans = {
    ["action_bomb"] = {
        ["en"] = "Bomb",
        ["ru"] = "Бомба",
        ["pt-br"] = "Bomba",
    },
    ["actiondesc_bomb"] = {
        ["en"] = "Summons a bomb that destroys ground very efficiently",
        ["ru"] = "Призыв бомбы, которая очень эффективно разрушает землю",
        ["pt-br"] = "Evoca uma bomba que destrói o chão de forma muito eficiente.",
    },
    ["action_light_bullet"] = {
        ["en"] = "Spark bolt",
        ["ru"] = "Искровая молния",
        ["pt-br"] = "Fagulha",
    },
    ["actiondesc_light_bullet"] = {
        ["en"] = "A weak but enchanting sparkling projectile",
        ["ru"] = "Очаровательно сверкающий",
        ["pt-br"] = "Um projétil fraco, reluzente e encantador.",
    },
}

local csv = CSVGenFromKeys(keytrans)
print(csv)