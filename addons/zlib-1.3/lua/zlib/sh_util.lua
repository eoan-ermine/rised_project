-- "addons\\zlib-1.3\\lua\\zlib\\sh_util.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (SH) Util
    Developed by Zephruz
]]

zlib.util = (zlib.util or {})

--[[
	zlib.util:GetPlayerBySteamID(steamid [string])

	- Gets player by SteamID
		* Works for bots; only returns the first bot found
	- Works for both STID & STID64
]]
function zlib.util:GetPlayerBySteamID(steamid)
	if (steamid == "BOT") then
		for k,v in pairs(player.GetBots()) do
			return v
		end
	end

	return (player.GetBySteamID(steamid) || player.GetBySteamID64(steamid))
end

--[[
	zlib.util:FormatNumber(number [int])

	- Formats a number with
]]
function zlib.util:FormatNumber(number)
	local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

	int = int:reverse():gsub("(%d%d%d)", "%1,")

	return minus .. int:reverse():gsub("^,", "") .. fraction
end

--[[
	zlib.util:RecursiveFindFiles(...)

	- Recursively finds files in a folder
]]
function zlib.util:RecursiveFindFiles(folder, path, ext, cb, foundFiles)
	local files, folders = file.Find(folder .. "/*", path)

	foundFiles = (foundFiles || {})

	if !(files) then return end
	
	for _,fName in pairs(files) do
		if (ext) then
			if !(string.EndsWith(fName, ext)) then continue end
		end
		
		local fPath = folder .. "/" .. fName

		if (fPath) then
			table.insert(foundFiles, fPath)
		end
	end

	if (#folders <= 0) then cb(foundFiles) return end

	for _,fName in pairs(folders) do
		self:RecursiveFindFiles(folder .. "/" .. fName, path, ext, cb, foundFiles)
	end
end

--[[
	zlib.util:IncludeByPath(fName [string], fPath [string])

	- Includes any sv_, cl_, sh_ prefixed files to their correct realms
	- Auto-includes to server if it isn't prefixed
]]
function zlib.util:IncludeByPath(fName, fPath)
	local path = fPath .. fName

	local pfxs = {}
	pfxs["sv_"] = function() if (SERVER) then include(path) end end
	pfxs["cl_"] = function() if (SERVER) then AddCSLuaFile(path) else include(path) end end
	pfxs["sh_"] = function() if (SERVER) then AddCSLuaFile(path) end include(path) end
	pfxs["init.lua"] = pfxs["sv_"]
	pfxs["shared.lua"] = pfxs["sh_"]

	-- Check prefixes
	for k,v in pairs(pfxs) do
		if (fName:StartWith(k) or fName == k) then
			v()

			return
		end
	end

	-- Load shared if it doesn't have a prefix/name
	if (SERVER) then
		AddCSLuaFile(path)
	end

	include(path)
end

--[[
	zlib.util:DrawBlur()

	- Draws blur on the passed panel
]]
local blurMat = Material("pp/blurscreen")

function zlib.util:DrawBlur(panel,w,h,amt)
	local x, y = panel:LocalToScreen(0, 0)
	surface.SetDrawColor(0,0,0,255)
	surface.SetMaterial(blurMat)

	for i = 1, 4 do
		blurMat:SetFloat("$blur", (i / 3) * (amt or 6))
		blurMat:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
	end
end

--[[
	zlib.util:OpenURL(url [string], ply [player or table of players])

	- Opens a url (clientside) or opens a url for the specified player (serverside)
]]
function zlib.util:OpenURL(url, ply)
	if (CLIENT) then
		gui.OpenURL(url)
	elseif (ply) then
		netPoint:SendCompressedNetMessage("zlib.util.functionRequest", ply, {
			func = "OpenURL", 
			args = {url},
		})
	end
end

--[[
	zlib.util:GetPrintNameByClass(
		* class [string]
	)

	- Attempts to return a print name by the passed class
		* If a print name cannot be determined it returns false
]]
function zlib.util:GetPrintNameByClass(class)
	if (class == nil) then return false end

	for k,v in pairs({ "Weapon", "SpawnableEntities" }) do
		local classList = list.Get(v)
		local classData = (classList && classList[class])

		if (classData != nil && classData.PrintName != nil) then
			return classData.PrintName
		end
	end

	return false
end

--[[
	zlib.util:GetTextSize(text [string], font [string])

	- Returns the size of the text
]]
function zlib.util:GetTextSize(text, font)
	if !(CLIENT) then return false end

	surface.SetFont(font or "DermaDefault")

    return surface.GetTextSize(text)
end

--[[
	zlib.util:ContainsProfanity(text [string], callback [function], filter [table (OPTIONAL)], useApi [boolean (OPTIONAL)])

	- Checks if text contains profanity
]]
function zlib.util:ContainsProfanity(text, callback, filter, useApi)
	if (istable(filter)) then
		for k,v in pairs(filter) do
			local sPos, ePos, mStr = string.find(text, v)

			if (sPos) then
				if (callback) then callback(true) end

				return true
			end
		end
	end
	
	if (useApi == false) then 
		if (callback) then callback(false) end

		return false 
	end

	zlib.http:Get("https://www.purgomalum.com/service/containsprofanity?text=" .. http.URLEncode(text),
	function(...)
		local data = {...}
		local result = (istable(data) && data[1])
		local hasProf = (result && result == "true")

		if (callback) then callback(hasProf) end
	end,
	function(...)
		if (callback) then callback(false) end
	end)
end

--[[
	zlib.util:ConcatTable(tbl [table], concatenator [bool = false])

	- Safely concatenates passed table
]]
function zlib.util:ConcatTable(tbl, concatenator)
	local outTbl = {}

	for k,v in pairs(tbl) do
		if (!v or isbool(v) or istable(v)) then continue end // Filter out specific types

		table.insert(outTbl, v)
	end

	return table.concat(outTbl, concatenator)
end

--[[
	zlib.util:SetUserGroup(ply [player], group [string])

	- Sets a users group based on the installed administration mod.
]]
function zlib.util:SetUserGroup(ply, group)
	if (CLIENT) then return false end

	local oldGroup = ply:GetUserGroup()

	// Set group/rank
	if serverguard then
        serverguard.player:SetRank(ply, group)
	elseif (xAdmin && xAdmin.SetUserRank != nil) then
		xAdmin.SetUserRank(ply, group)
	elseif (ulx) then
		RunConsoleCommand("ulx", "adduserid", ply:SteamID(), group)
	else
		ply:SetUserGroup(group)
	end

	// CAMI
	if CAMI then
		CAMI.SignalUserGroupChanged(ply, oldGroup, group, "zlib")
	else
		hook.Call("CAMI.PlayerUsergroupChanged", nil, ply, oldGroup, group, "zlib")
	end
	
	return true
end

--[[
	zlib.util:CleanString(val [string], removeVals [OPTIONAL - table])

	Cleans a string of all potential characters that could cause issues w/(de)serialization
]]
function zlib.util:CleanString(val, removeVals)
	removeVals = (removeVals || { 
		["\n"] = "", 
		["\\"] = "",
		["\""] = ""
	})

	for k,v in pairs(removeVals) do
		val = string.Replace(val, k, v)
	end

	return val
end

--[[
	zlib.util:UnJavascriptSafe(str [string])

	- Removes escape characters from a string that was escaped using the "JavascriptSafe" method
		* May not work well strings that contained unsafe characters prior to being escaped
]]
local javascript_escape_replacements = {
	["\\\""] = "\"",
	["\\\'"] = "\'",
	["\\"] = "",
	["\\\\"] = "\\"
}

function zlib.util:UnJavascriptSafe(str)
	if (str == nil) then return "" end

	local strCopy = str

	for k,v in pairs(javascript_escape_replacements) do
		if (str == nil) then 
			return strCopy
		end

		str = str:gsub( k , v )
	end

	-- U+2028 and U+2029 are treated as line separators in JavaScript, handle separately as they aren't single-byte
	str = str:gsub( "\\\226\128\168", "\226\128\168" )
	str = str:gsub( "\\\226\128\169", "\226\128\169" )

	return str
end

/* SERIALIZERS */
zlib.util.dataSerializers = {
	["json"] = {
		order = 1,
		isValid = function() return true end,
		
		d = function(val)
			if (string.StartWith(val, "table: ")) then // Invalid data; somehow a table string was stored
				return true, {}
			end

			/*if (string.find(val, "\\\"") != nil || string.find(val, "\\") != nil) then // Escaped (w/JavascriptSafe method)
				val = zlib.util:UnJavascriptSafe(str)
			else*/

			val = util.JSONToTable(val)

			return istable(val), (istable(val) && val || {})
		end,
		s = function(val)
			return pcall(util.TableToJSON, val)
		end
	},
	["von"] = {
		order = 2,
		isValid = function() return von != nil end,
		d = function(val)
			if (val:match("^%[.*%]$") != nil || val:match("^{.*}$") != nil) then return false end

			return pcall(von.deserialize, val)
		end,
		s = function(val)
			return pcall(von.serialize, val)
		end
	},
}

--[[
	zlib.util:Serialize(tbl [table], overrideType [serializer type], suppressErrors [boolean])

	- Serializes a table into a storable string
]]
function zlib.util:Serialize(tbl, overrideType, suppressErrors)
	if !(istable(tbl)) then tbl = {} end

	local result, val

	overrideType = (overrideType && self.dataSerializers[overrideType] || false)

	if (overrideType) then
		if !(overrideType.isValid()) then return nil end

		local oResult, oVal = overrideType.s(tbl)

		result = oResult
		val = oVal
	else
		local jResult, jVal = self.dataSerializers.json.s(tbl)

		result = jResult
		val = jVal
	end

	if !(result) then 
		if (!suppressErrors && zlib._debugMode) then
			zlib:ConsoleMessage("Unable to serialize table! (" .. table.ToString(tbl, "TableToSerialize") .. ")")
		end

		return nil
	end

	return val
end

--[[
	zlib.util:Deserialize(str [string], suppressErrors [boolean])

	- Attempts to deserializes a string into a table
		* Will attempt to deserialize with all data serializers in the **zlib.util.dataSerializers** table
]]
function zlib.util:Deserialize(str, suppressErrors)
	if !(isstring(str)) then return nil end

	for k,v in SortedPairsByMemberValue(self.dataSerializers, order) do
		local result, val = v.d(str)

		if (result) then
			return val
		end
	end

	if !(suppressErrors) then
		zlib:ConsoleMessage("Unable to deserialize string! (" .. str .. ")")
	end

	return nil
end

--[[
	zlib.util:GetEntityData(ent [entity])

	* Returns a table of entity data
]]
function zlib.util:GetEntityData(ent)
    local data = {}

    if !(ent.GetNetworkVars) then return data end

    local dbgName, dTable = debug.getupvalue(ent.GetNetworkVars, 1)

    for k,v in pairs(dTable) do
        data[k] = v.GetFunc(ent, v.index)
    end

    return data
end

--[[
	zlib.util:SetEntityData(ent [entity], data [table])

	* Sets an entities data table; utilize the GetEntityData function result to set the table
]]
function zlib.util:SetEntityData(ent, data)
    for k,v in pairs(data) do
        local setFunc = ent["Set" .. k]
		
        if (setFunc) then
			setFunc(ent, v)
		else
			ent[k] = v
        end
    end

    return true
end

--[[--------------------------
	ICON SETS
	THANKS THREEBOW
	http://threebow.com
----------------------------]]
local function downloadFile(filename, url, callback, errorCallback)
    local path = "threebow/downloads/" .. filename
    local dPath = "data/" .. path

    if(file.Exists(path, "DATA")) then return callback(dPath) end
    if(!file.IsDir(string.GetPathFromFilename(path), "DATA")) then file.CreateDir(string.GetPathFromFilename(path)) end

    errorCallback = errorCallback || function(reason)
        error("zlib: File download failed ("..url..") ("..reason..")")
    end

    http.Fetch(url, function(body, size, headers, code)
        if(code != 200) then return errorCallback(code) end
        file.Write(path, body)
        callback(dPath)
    end, errorCallback)
end

function zlib.util:IconSet(iconUrls, path)
    local set = {}
    
    for name, url in pairs(iconUrls) do
        downloadFile((path || "")..util.CRC(name..url).."."..string.GetExtensionFromFilename(url), url, function(path)
            set[name] = Material(path, "unlitgeneric")
        end)
    end

    return set
end

--[[
	Networking
]]
if (SERVER) then
	util.AddNetworkString("zlib.util.functionRequest")
end

if (CLIENT) then
	net.Receive("zlib.util.functionRequest",
	function()
		local data, dataBInt = netPoint:DecompressNetData()

		if !(data) then return end
		
		local func, args = data.func, data.args
		func = zlib.util[func]

		if !(func) then return end

		func(zlib.util, unpack(args))
	end)
end