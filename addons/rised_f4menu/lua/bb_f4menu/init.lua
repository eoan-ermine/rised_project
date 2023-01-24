-- "addons\\rised_f4menu\\lua\\bb_f4menu\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {}; 

// Config Include
if (SERVER) then
	AddCSLuaFile(_blackberry.f4menu.dir.."/config.lua");
	AddCSLuaFile(_blackberry.f4menu.dir.."/lang.lua");
	AddCSLuaFile(_blackberry.f4menu.dir.."/derma.lua");
end
include(_blackberry.f4menu.dir.."/config.lua");
include(_blackberry.f4menu.dir.."/lang.lua");
include(_blackberry.f4menu.dir.."/derma.lua");

// Derma Init
_blackberry.f4menu.derma.init();

if (SERVER) then
	SetGlobalInt("_blackberry.f4menu.globalmoney", GetGlobalInt("_blackberry.f4menu.globalmoney"))
	hook.Add("PlayerSpawn", "_blackberry.f4menu.globalmoney", function(ply)
		timer.Simple(5,function()
			if (!IsValid(ply)) then return false; end;
			SetGlobalInt("_blackberry.f4menu.globalmoney", 0);
			for k,v in pairs(player.GetAll()) do
				SetGlobalInt("_blackberry.f4menu.globalmoney", GetGlobalInt("_blackberry.f4menu.globalmoney") + v:getDarkRPVar("money"));
			end
		end)
	end)
end;  