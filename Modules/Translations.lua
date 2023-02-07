---@alias langs "en"|"ru"|"pt-br"|"es-es"|"de"|"fr-fr"|"it"|"pl"|"zh-cn"|"jp"|"ko"
---@alias translationTable table<langs, table<string, string>>
local Translations = {}
--- @param translation_table translationTable An indexed table following this format:
function Translations.CSVGenFromTable(translation_table)
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
    local languages = { "en", "ru", "pt-br", "es-es", "de", "fr-fr", "it", "pl", "zh-cn", "jp", "ko" }
    for key, translations in pairs(translation_table) do
        setmetatable(translations, { __index = function(_, _) return "" end })
        csv = csv .. key .. ","
        for _, language in ipairs(languages) do
            csv = csv .. translations[language]
        end
        csv = csv .. "\n"
    end
    return csv
end

function Translations.AppendTranslationFile(fileOrTable)
    if not ModTextFileGetContent then
        error("AppendTranslationFile can only be called when ModTextFileGet/SetContent is available", 2)
    end
    if type(fileOrTable) == "string" then
        local csv = ModTextFileGetContent(fileOrTable)
        ModTextFileSetContent("data/translations/common.csv",
            ModTextFileGetContent("data/translations/common.csv") .. "\n" .. csv)
    else
        local csv = Translations.CSVGenFromTable(fileOrTable)
        ModTextFileSetContent("data/translations/common.csv",
            ModTextFileGetContent("data/translations/common.csv") .. "\n" .. csv)
    end
end

local function strsplit(delimiter, text)
    ---@diagnostic disable-next-line: unbalanced-assignments
    local list, pos, first, last = {}, 1
    while true do
        first, last = text:find(delimiter, pos, true)
        if first then -- found?
            table.insert(list, text:sub(pos, first - 1))
            pos = last + 1
        else
            table.insert(list, text:sub(pos))
            break
        end
    end
    return list
end

function Translations.AddKey(name, translations)
    local csv = name .. ","
    local languages = { "en", "ru", "pt-br", "es-es", "de", "fr-fr", "it", "pl", "zh-cn", "jp", "ko" }
    for _, language in ipairs(languages) do
        csv = csv .. (translations[language] or "") .. ","
    end
    ModTextFileSetContent("data/translations/common.csv",
    ModTextFileGetContent("data/translations/common.csv").. csv .. "\n")
end

function Translations.EditKey(name, translations)
    local csv = ModTextFileGetContent("data/translations/common.csv")
    local defaults = strsplit(",", csv:match(name .. ",([^\n]+)\n"))
    local languages = { "en", "ru", "pt-br", "es-es", "de", "fr-fr", "it", "pl", "zh-cn", "jp", "ko" }
    for i=1, #defaults do local v = defaults[i]
        defaults[languages[i]] = v
    end
    csv = csv:gsub(name .. "[^\n]+\n", "")
    local newCsv = name .. ","
    for language in pairs(languages) do
        newCsv = newCsv .. (translations[language] or defaults[language]) .. ","
    end
    newCsv = newCsv .. "\n"
    csv = csv .. "\n" .. newCsv
    ModTextFileSetContent("data/translations/common.csv", csv)
end

function Translations.RemoveKey(name)
    local csv = ModTextFileGetContent("data/translations/common.csv")
    csv, e = csv:gsub(name .. "[^\n]*\n", "")
    ModTextFileSetContent("data/translations/common.csv", csv)
end

return Translations