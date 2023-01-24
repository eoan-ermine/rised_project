-- "addons\\zlib-1.3\\lua\\zlib\\sh_language.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZLib 2 - (SH) Language
    Developed by Zephruz
]]

zlib.lang = (zlib.lang or {})

--[[
	zlib.lang:SetupLanguage(name [string])

	- Sets a language up
]]
function zlib.lang:SetupLanguage(name)
	local lang = {}

	zlib.object:SetMetatable("zlib.Language", lang)

	lang:SetName(name)

	return lang
end

--[[
    zlib.lang:RegisterSet(name [string])

    - Registers a language set
	- This is used to register a set of languages for a specific addon
	- It helps consolidate and separate each addons languages while keeping them stored in the zlib namespace
]]
function zlib.lang:RegisterSet(name)
    local langSet = {}

	zlib.object:SetMetatable("zlib.LanguageSet", langSet)

	langSet:SetUniqueName(name)

    local cache = zlib.cache:Get("zlib.LanguageSets")

	if (cache) then
		cache:addEntry(langSet, name)

		return cache:getEntry(name)
	end

    return langSet
end

--[[
	zlib.lang:GetSet(name [string])

    - Returns a language set
]]
function zlib.lang:GetSet(name)
	local cache = zlib.cache:Get("zlib.LanguageSets")

	if !(cache) then return end

	return cache:getEntry(name)
end

--[[
	Language cache
]]
zlib.cache:Register("zlib.LanguageSets")

--[[
	Language metastructure(s)
]]

-- Language set
local langSetMtbl = zlib.object:Create("zlib.LanguageSet")
langSetMtbl:setData("UniqueName", false, {shouldSave = false})
langSetMtbl:setData("CurrentLanguage", false, {
	shouldSave = false,
	onSet = function(s,val,oVal)
		if (isstring(val)) then
			return self:getLanguage(val)
		end

		return (val or oVal)
	end,
})
langSetMtbl:setData("Languages", {}, {
    shouldSave = false,
    onSet = function(s,val,oVal)
        if (isstring(val)) then
            oVal = (oVal or {})
            oVal[val] = zlib.lang:SetupLanguage(val)

            return oVal
        end
    end,
    onGet = function(s,val,langName)
        if !(langName) then return val end

        return (val[langName] or false)
    end,
})

function langSetMtbl:getLanguage(name)
    return self:GetLanguages(name)
end

function langSetMtbl:registerLanguage(name)
    self:SetLanguages(name)

    return self:getLanguage(name)
end

-- Language
local langMtbl = zlib.object:Create("zlib.Language")

langMtbl:setData("Name", "LANG.NAME", {shouldSave = false})
langMtbl:setData("Translations", {}, {
	shouldSave = false,
	onSet = function(s,tname,oVal,tval)
		if (!tname or !tval) then return val end

		local oVal = (oVal or {})
		
		oVal[tname] = tval

		return oVal
	end,
	onGet = function(s,val,tname,...)
		if !(tname) then return val end

		local trans = (val[tname] or tname)

		return (#{...} > 0 && string.format(trans,...) || trans)
	end
})

function langMtbl:addTranslation(name,val)
	self:SetTranslations(name, val)
end

function langMtbl:getTranslation(name, ...)
	return self:GetTranslations(name, ...)
end