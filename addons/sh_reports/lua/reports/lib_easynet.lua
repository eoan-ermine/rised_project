-- "addons\\sh_reports\\lua\\reports\\lib_easynet.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
/************************
	easynet by Shendow
	http://steamcommunity.com/id/shendow/

	Copyright (c) 2017

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
************************/

AddCSLuaFile()

EASYNET_STRING = 1
EASYNET_FLOAT = 2
EASYNET_BOOL = 3
EASYNET_UINT8 = 4
EASYNET_UINT16 = 5
EASYNET_UINT32 = 6
EASYNET_STRUCTURES = 7
EASYNET_PLAYER = 8

module("easynet", package.seeall)

local Structures = {}
local Creating

function Start(id)
	Creating = {
		id = id,
		nid = #Structures + 1,
		args = {},
	}
end

function Add(name, type)
	Creating.args[name] = {id = table.Count(Creating.args) + 1, type = type}
end

function Register()
	local id = Creating.id
	Structures[id] = table.Copy(Creating)

	if (SERVER) then
		util.AddNetworkString(id)
	end
end

local function read(typ, name)
	if (typ == EASYNET_STRING) then
		return net.ReadString()
	elseif (typ == EASYNET_FLOAT) then
		return net.ReadFloat()
	elseif (typ == EASYNET_BOOL) then
		return net.ReadBool()
	elseif (typ == EASYNET_UINT8) then
		return net.ReadUInt(8)
	elseif (typ == EASYNET_UINT16) then
		return net.ReadUInt(16)
	elseif (typ == EASYNET_UINT32) then
		return net.ReadUInt(32)
	elseif (typ == EASYNET_STRUCTURES) then
		local t = {}
		local struct = Structures[name]

		for i = 1, net.ReadUInt(16) do
			t[i] = {}

			for n, arg in SortedPairsByMemberValue (struct.args, "id") do
				t[i][n] = read(arg.type, n)
			end
		end

		return t
	elseif (typ == EASYNET_PLAYER) then
		return Player(net.ReadUInt(16))
	end
end

function Callback(id, cb)
	net.Receive(id, function(len, ply)
		if (_EASYNET_DEBUG) then
			print("[EasyNet][Rcv][" .. id .. "] " .. (len / 8) .. " bytes")
		end

		local struct = Structures[id]

		local data = {}
		for name, arg in SortedPairsByMemberValue (struct.args, "id") do
			data[name] = read(arg.type, name)
		end

		cb(data, ply)
	end)
end

local function write(val, typ, name)
	if (typ == EASYNET_STRING) then
		net.WriteString(val)
	elseif (typ == EASYNET_FLOAT) then
		net.WriteFloat(val)
	elseif (typ == EASYNET_BOOL) then
		net.WriteBool(val)
	elseif (typ == EASYNET_UINT8) then
		if (isstring(val)) then
			val = tonumber(val) or 0
		end

		net.WriteUInt(val, 8)
	elseif (typ == EASYNET_UINT16) then
		net.WriteUInt(val, 16)
	elseif (typ == EASYNET_UINT32) then
		net.WriteUInt(val, 32)
	elseif (typ == EASYNET_STRUCTURES) then
		local struct = Structures[name]

		net.WriteUInt(table.Count(val), 16)

		for k, v in pairs (val) do
			for n, arg in SortedPairsByMemberValue (struct.args, "id") do
				write(v[n], arg.type, n)
			end
		end
	elseif (typ == EASYNET_PLAYER) then
		net.WriteUInt(IsValid(val) and val:UserID() or 0, 16)
	end
end

local function prepare(id, data)
	local struct = Structures[id]

	net.Start(id)
		for name, arg in SortedPairsByMemberValue (struct.args, "id") do
			write(data[name], arg.type, name)
		end

		if (_EASYNET_DEBUG) then
			print("[EasyNet][Send][" .. id .. "] " .. net.BytesWritten() .. " bytes")
		end
end

if (SERVER) then
	function Send(rec, id, data)
		prepare(id, data)
		net.Send(rec)
	end
else
	function SendToServer(id, data)
		prepare(id, data)
		net.SendToServer()
	end
end