-- "lua\\gmodadminsuite\\modules\\fpsbooster\\sh_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if (SERVER) then
	AddCSLuaFile("cl_menu.lua")
else
	GAS:hook("gmodadminsuite:LoadModule:fpsbooster", "LoadModule:fpsbooster", function()
		include("gmodadminsuite/modules/fpsbooster/cl_menu.lua")
	end)
end