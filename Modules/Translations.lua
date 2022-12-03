---@alias langs "en"|"ru"|"pt-br"|"es-es"|"de"|"fr-fr"|"it"|"pl"|"zh-cn"|"jp"|"ko"
---@alias translationTable table<langs, table<string, string>>
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
--- @param translation_table translationTable An indexed table following this format:
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
function CSVGenFromTable(translation_table)
    -- Assume the table is indexed by language
    if translation_table["en"] ~= nil then
        local sorted = {}
        for key, value in pairs(translation_table) do
            for k, v in pairs(value) do
                sorted[k] = sorted[k] or {}
                sorted[k][key] = v
            end
        end
        translation_table = sorted
    end
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

function AppendTranslationFile(fileOrTable)
    if not ModTextFileGetContent then
        error("AppendTranslationFile can only be called when ModTextFileGet/SetContent is available", 2)
    end
    if type(fileOrTable) == "string" then
        local csv = ModTextFileGetContent(fileOrTable)
        ModTextFileSetContent("data/translations/common.csv", ModTextFileGetContent("data/translations/common.csv") .. "\n" .. csv)
    else 
        local csv = CSVGenFromTable(fileOrTable)
        ModTextFileSetContent("data/translations/common.csv", ModTextFileGetContent("data/translations/common.csv") .. "\n" .. csv)
    end
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