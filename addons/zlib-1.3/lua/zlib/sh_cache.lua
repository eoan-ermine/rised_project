-- "addons\\zlib-1.3\\lua\\zlib\\sh_cache.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
	zlib - (SH) Cache

	- Cache handling (creation, deletion, fetching, etc.)
]]

zlib.cache = (zlib.cache or {})
zlib.cache._caches = (zlib.cache._caches or {})

--[[
	zlib.cache:Load()
]]
function zlib.cache:Load()
	return self:GetAll()
end

--[[
	zlib.cache:GetMetaTable()

	- Returns a copy of the cache metatable
]]
function zlib.cache:GetMetaTable()
	return table.Copy(zlib.object:Get("zlib.CacheMeta") or self._metatable or {})
end

--[[
	zlib.cache:GetAll()

	- Returns the entire table of caches
]]
function zlib.cache:GetAll()
	return self._caches
end

--[[
	zlib.cache:Register(name [string], data [table] (OPTIONAL))

	- Registers a cache
]]
function zlib.cache:Register(name, data)
	if !(name) then return end

	local prevCache = self:Get(name)
	local prevEntries = (prevCache && !prevCache:GetClearOnReload() && prevCache:GetEntries())

	-- Register cache
	self._caches[name] = {}

	zlib.object:SetMetatable("zlib.CacheMeta", self._caches[name])

	if (data) then
		for k,v in pairs(data) do
			self._caches[name]:setData(k,v)
		end
	end

	self._caches[name]:SetName(name)
	self._caches[name]:SetEntries(prevEntries or {})

	return self._caches[name]
end

--[[
	zlib.cache:Get(name [string], ...)

	- Accepts single/multiple cache names
	- Returns the cache(s) in a table UNLESS there is only one cache requested
]]
function zlib.cache:Get(...)
	local args, results = {...}, {}

	if (#args == 1) then
		local cName = args[1]

		results = (cName && self._caches[cName] || false)
	else
		for k,v in pairs(args) do
			if (self._caches[v]) then
				results[v] = self._caches[v]
			end
		end
	end

	return results
end

--[[
	Character Metastructure
]]
local fCacheMeta, fCacheMetaID = zlib.object:Create("zlib.CacheMeta")

fCacheMeta:setData("Name", "NIL", {shouldSave = false})
fCacheMeta:setData("Description", "NIL", {shouldSave = false})
fCacheMeta:setData("ClearOnReload", false, {shouldSave = false})
fCacheMeta:setData("Entries", {}, {shouldSave = false})

function fCacheMeta:__tostring()
	local cName, cEntries = (self:getData("Name") || nil), (self:getData("Entries") || {})

	return ("cache[" .. (cName || "NIL") .. "] (Total entries/values: " .. (table.Count(cEntries) || 0) .. ")")
end

function fCacheMeta:__eq(c1, c2)
	local c1Name = (c1 && c1.getData && c1:getData("Name") || nil)
	local c2Name = (c2 && c2.getData && c2:getData("Name") || nil)

	return (c1Name && c2Name && c1Name == c2Name)
end

function fCacheMeta:__concat()
	return "Cache(" .. (self:getData("Name") or "NIL") .. ")"
end

function fCacheMeta:addEntry(data, id)
	local entries = self:GetEntries()

	if (id) then
		entries[id] = data
	else
		id = table.insert(entries, data)
	end

	self:SetEntries(entries)

	return id, self:getEntry(id)
end

function fCacheMeta:getEntry(id)
	return self:GetEntries()[id]
end

function fCacheMeta:removeEntry(id)
	local entries = self:GetEntries()
	local result = self:getEntry(id)

	if !(result) then return false end

	entries[id] = nil

	self:SetEntries(entries)

	return result
end

function fCacheMeta:sendToPlayer(ply, modifyData, sendAmt)
	if (istable(ply) && table.Count(ply) <= 0) then
		return
	end

	local entries = self:GetEntries()

	if (modifyData) then
		entries = modifyData(entries)
	end

	zlib:DebugMessage(string.format("Sending cache %s to %s (%s total entries, %s per post)", self:GetName(), ply, table.Count(entries), sendAmt || 2))

	if (istable(ply)) then
		for k,v in pairs(ply) do
			zlib:DebugMessage(v:Name(), v:SteamID())
		end
	end

	netPoint:SendPayload("zlib.cache.Receive", ply, entries, (sendAmt || 2), self:GetName())
end

function fCacheMeta:onPlayerReceive(data) end -- called when a player receives the cache

function fCacheMeta:clear()
	self:SetEntries({})
end

zlib.cache._metatable = fCacheMeta

--[[
	Networking
]]

--[[Netpoints]]
if (CLIENT) then
	netPoint:ReceivePayload("zlib.cache.Receive",
	function(data,cacheName)
		local cache = zlib.cache:Get(cacheName)

		if !(cache) then return end
		if !(cache.onPlayerReceive) then return end

		cache:onPlayerReceive(data)
	end)
end
