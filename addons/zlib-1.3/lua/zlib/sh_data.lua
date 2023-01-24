-- "addons\\zlib-1.3\\lua\\zlib\\sh_data.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (SH) Data
    Developed by Zephruz
]]

zlib.data = (zlib.data or {})
zlib.data.types = (zlib.data.types or {})
zlib.data._connections = (zlib.data._connections or {})

--[[
	zlib.data:RegisterType(name [string], data [table])

	- Registers a new data type
]]
function zlib.data:RegisterType(name, data)
	self.types[name] = data

	zlib.object:SetMetatable("zlib.DataMeta", self.types[name])

	return self.types[name]
end

--[[
	zlib.data:LoadType(name [string], config [table = null])

	- Returns a temporary/disposable data type
]]
function zlib.data:LoadType(name, config)
	local dmeta = self.types[name]

	if !(dmeta) then
		zlib:ConsoleMessage("Invalid data type '" .. name .. "'!")

		return
	end

	local dmtbl = {
		_data = {
			Name = name or defType, 
			Config = config or {}
		}
	}

	setmetatable(dmtbl, { __index = dmeta })
	
	//dmtbl:SetName(name or defType)
	//dmtbl:SetConfig(config or {})

	return dmtbl
end

--[[
	zlib.data:GetMetaTable()

	- Returns the data metatable
]]
function zlib.data:GetMetaTable()
	return (zlib.object:Get("zlib.DataMeta") || self._metatable || nil)
end

--[[
	zlib.data:GetConnection(id [string])

	- Returns the connection from the conneciton pool
]]
function zlib.data:GetConnection(id)
	return self._connections[id]
end

--[[
	** DEPRECIATED **
	
	zlib.data:SetupConnection(id [string], dtype [data type meta])
]]
function zlib.data:SetupConnection(id, dtype)
	if !(dtype) then return end

	return self:CreateConnection(id, dtype:GetName())
end

--[[
	zlib.data:CreateConnection(id [string], dTypeName [string], config [table = {}])
]]
function zlib.data:CreateConnection(id, dTypeName, config)
	if !(id) then
		zlib:ConsoleMessage("Invalid ID passed to create connection.")

		return
	end

	// Disconnect from current connection
	local curCon = self:GetConnection(id)

	if (istable(curCon) && curCon.Disconnect) then 
		curCon:Disconnect()
	end

	// Create connection
	local dmeta = self:LoadType(dTypeName, config)

	if !(dmeta) then
		zlib:ConsoleMessage("Invalid data type '" .. dTypeName .. "'!")

		return
	end

	self._connections[id] = {}

	setmetatable(self._connections[id], { __index = dmeta })

	self._connections[id]:SetName(id)

	return self._connections[id]
end

--[[
	Data Metastructure
]]
local dataMeta, dataMetaID = zlib.object:Create("zlib.DataMeta")

dataMeta:setData("Name", "NO.DATATYPE.NAME")
dataMeta:setData("Config", {})
dataMeta:setData("IsLoaded", false)

function dataMeta:EscapeString(string)
	local escape = (self.escapeStr or self.escape or
		function(str)
			return sql.SQLStr(tostring(str))
		end)

	return escape(string)
end

function dataMeta:Connect(sucCb, errCb)
	if (self.connect) then
		return self:connect(sucCb, errCb)
	end
end

function dataMeta:Disconnect(sucCb, errCb)
	if (self.disconnect) then
		return self:disconnect(sucCb, errCb)
	end
end

function dataMeta:Query(query, sucCb, errCb)
	if (self.query) then
		return self:query(query, sucCb, errCb)
	end
end

zlib.data._metatable = dataMeta
zlib.data._metatable.__index = dataMeta

--[[
    Includes
]]
if (SERVER) then include("zlib/data/sv_data.lua") end

--[[Load Data Types]]
local files, dirs = file.Find("zlib/data/types/*", "LUA")

for k,v in pairs(files) do
    zlib.util:IncludeByPath(v, "data/types/")
end