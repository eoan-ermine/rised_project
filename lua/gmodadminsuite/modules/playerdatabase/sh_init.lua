-- "lua\\gmodadminsuite\\modules\\playerdatabase\\sh_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if (SERVER) then
	AddCSLuaFile("gmodadminsuite/modules/playerdatabase/sh_playerdatabase.lua")
end

GAS:hook("gmodadminsuite:LoadModule:playerdatabase", "LoadModule:playerdatabase", function()
	include("gmodadminsuite/modules/playerdatabase/sh_playerdatabase.lua")
end)