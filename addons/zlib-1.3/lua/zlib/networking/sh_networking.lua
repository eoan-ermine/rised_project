-- "addons\\zlib-1.3\\lua\\zlib\\networking\\sh_networking.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (SH) Networking
    Developed by Zephruz
]]

zlib.network = (zlib.network or {})
zlib.network._actions = (zlib.network._actions or {})

function zlib.network:RegisterAction(name, data)
	data = (data or {})

	self._actions[name] = data

	local actionID = "zlib.Action[" .. name .. "]"

	netPoint:CreateEndPoint(actionID .. ".receiveRequest", {
		request = function(ply,val)
			local adminGroups = (data.adminOnly || data.adminGroups)

			// Block any users who aren't within the group
			if (adminGroups && !table.HasValue(adminGroups, ply:GetUserGroup())) then return false end

			local name, id = val.name, val.id
			val = (val.data or {})

			if (data.onReceive) then
				data.onReceive(ply, val,
				function(val)
					netPoint:SendCompressedNetMessage("zlib.Action.receiveResult", ply, { name = name, id = id, data = val })
				end)

				return true
			end
		end,
	})
end

function zlib.network:GetAction(name)
	return self._actions[name]
end

--[[
    Networking
]]
if (SERVER) then 
    util.AddNetworkString("zlib.Action.receiveResult") 
end

--[[
    Includes
]]
AddCSLuaFile("cl_networking.lua")
if (CLIENT) then include("cl_networking.lua") end