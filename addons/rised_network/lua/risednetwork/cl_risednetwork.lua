-- "addons\\rised_network\\lua\\risednetwork\\cl_risednetwork.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
net.Receive("RISEDNet:Client", function()
	local action = net.ReadString()
	local ent = net.ReadEntity()
	local key = net.ReadString()
	local value = nil

	if action == "string" then
		value = net.ReadString()
	elseif action == "int" then
		value = net.ReadInt(32)
	elseif action == "bool" then
		value = net.ReadBool()
	end
	
	ent[key] = value
end)