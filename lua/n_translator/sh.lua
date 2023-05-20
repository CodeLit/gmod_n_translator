local pairs = pairs
local GetConVar = GetConVar
--- Global singleton class for working with languages
---@module Language
---@usage local text = nlang.l('my long story text','ru') -- will translate this text to russian
---translations must be added to folder cyber-langs using CWLang:AddTranslation() function.
---@see Language:AddTranslation
module('nlang', package.seeall)
List = List or {}

---Translates text
---@param text string
---@param langCode string
---@return string Translated text
function t(text, langCode)
    if CLIENT then
        langCode = GetLocalLang()
    end

    local langData = List[langCode]
    if langData and langData[text] then return langData[text] end
    if nlang.Translate then return nlang.Translate(text, langCode) end -- перенаправляем на внешний переводчик, если не находит слово

    return text
end

---Adds translation to language. Can be used anywhere.
---@param lang string 2-char lang
---@param tbl table translations from english (key-value)
---@usage Lang:AddTranslation('ru',{
---     ['Save items'] = 'Сохранить предметы',
---     ['Add items'] = 'Добавить предметы'
--- })
---@see Translator
function Add(lang, prefix, tbl)
    List[lang] = List[lang] or {}

    for k, v in pairs(tbl) do
        List[lang][prefix .. '.' .. k] = v
    end
end

---Formats language to 2-chars code
---@param lang string
---@return string formatted lang
function Format(lang)
    return nlib:formatToTwoCharsLang(lang)
end