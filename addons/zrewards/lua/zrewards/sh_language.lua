-- "addons\\zrewards\\lua\\zrewards\\sh_language.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) language
    Developed by Zephruz
]]

zrewards.lang = (zrewards.lang or {})

--[[
    zrewards.lang:Register(name [string])

    - Registers a language and returns it
]]
function zrewards.lang:Register(name)
    local langSet = zlib.lang:GetSet("zrewards.Language")

    if !(langSet) then return false end

    return langSet:registerLanguage(name)
end

--[[
    zrewards.lang:Get(name [string])

    - Returns a language or false
]]
function zrewards.lang:Get(name)
    local langSet = zlib.lang:GetSet("zrewards.Language")

    if !(langSet) then return false end

    return langSet:getLanguage(name)
end

--[[
    zrewards.lang:GetTranslation(name [string], ...)

    - Pass the translation name as the first argument, as the rest you can use replacement values
	- Returns the translation with the current language
]]
function zrewards.lang:GetTranslation(name, ...)
    local curLang = self:GetCurrent()

    return (curLang && curLang:getTranslation(name, ...) || name)
end

--[[
	zrewards.lang:SetCurrent(name [string])

	- Sets the currently used language
]]
function zrewards.lang:SetCurrent(name)
    local langSet = zlib.lang:GetSet("zrewards.Language")

    if (!langSet or !name) then return false end

    local lang = (self:Get(name) or self:Get("en"))

    langSet:SetCurrentLanguage(lang)
end

--[[
	zrewards.lang:GetCurrent()

	- Gets the currently used language
]]
function zrewards.lang:GetCurrent()
    local langSet = zlib.lang:GetSet("zrewards.Language")

    if !(langSet) then return false end

	return langSet:GetCurrentLanguage()
end

--[[
    Language set
]]
zlib.lang:RegisterSet("zrewards.Language")

--[[
    Load Languages
]]
local files, dirs = file.Find("zrewards/languages/zrew_lang_*", "LUA")

for k,v in pairs(files) do
    zlib.util:IncludeByPath(v, "languages/")
end

-- Set current language
zrewards.lang:SetCurrent(zrewards.config.defaultLanguage or "en")