-- "addons\\zlib-1.3\\lua\\zlib\\sh_addons.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
	zlib - (SH) Cache

	- Cache handling (creation, deletion, fetching, etc.)
]]

zlib.addons = (zlib.addons or {})

--[[
    zlib.addons:Register(name [string], data [table = null])

    - Registers an addon
]]
function zlib.addons:Register(name, data)
    local addon = {}

    zlib.object:SetMetatable("zlib.AddonMeta", addon)

    addon:SetUniqueName(name)

    if (data) then
        for k,v in pairs(data) do
            addon:setData(k,v)
        end
    end

    -- Add to cache
    local cache = zlib.cache:Get("zlib.Addons")

    if (cache) then
        cache:addEntry(addon, name)

        return cache:getEntry(name)
    end

    return addon
end

--[[
    zlib.addons:Get(name [string])

    - Returns an addon or nil
]]
function zlib.addons:Get(name)
    local cache = zlib.cache:Get("zlib.Addons")

    if !(cache) then return end
    
    return cache:getEntry(name)
end

--[[
	Addon cache
]]
local addonCache = zlib.cache:Register("zlib.Addons")

--[[
    Addon Metastructure
]]
local fAddonMtbl = zlib.object:Create("zlib.AddonMeta")
fAddonMtbl:setData("Name", "NIL", {shouldSave = false})
fAddonMtbl:setData("UniqueName", "NIL", {shouldSave = false})
fAddonMtbl:setData("Description", "NIL", {shouldSave = false})
fAddonMtbl:setData("AddonID", nil, {shouldSave = false})
fAddonMtbl:setData("Table", nil, {shouldSave = false})
fAddonMtbl:setData("InitMethod", "Init", {shouldSave =false})
fAddonMtbl:setData("VersionString", "_version", {shouldSave =false})

function fAddonMtbl:Init()
	local addonTbl, initMethod
	addonTbl = self:GetTable()
	initMethod = self:GetInitMethod()

	if (istable(addonTbl) && initMethod) then
		return addonTbl[initMethod]()
	end

	return false
end

function fAddonMtbl:GetVersion()
	local addonTbl = self:GetTable()

	if (istable(addonTbl)) then
		return addonTbl[self:GetVersionString()]
	end

	return false
end

function fAddonMtbl:__tostring()
	return ("addon[" .. (self:GetName() || "NIL") .. "]")
end

function fAddonMtbl:__eq(c1, c2) 
	local c1Name = (c1 && c1.getData && c1:getData("Name") || nil)
	local c2Name = (c2 && c2.getData && c2:getData("Name") || nil)

	return (c1Name && c2Name && c1Name == c2Name)
end

function fAddonMtbl:__concat()
	return tostring(self)
end