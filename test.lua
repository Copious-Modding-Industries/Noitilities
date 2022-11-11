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
        csv = csv .. key .. ","
        for _, language in pairs(languages) do
            csv = csv .. ("[%s],"):format(translations[language] or "")
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
        ["en"] = "Jim's Spark bolt",
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