-- "addons\\atlaschat\\lua\\autorun\\atlaschat_load.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if (SERVER) then

	AddCSLuaFile("atlaschat/cl_init.lua")
	
	include("atlaschat/init.lua")

else

	include("atlaschat/cl_init.lua")

end