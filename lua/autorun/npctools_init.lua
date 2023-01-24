-- "lua\\autorun\\npctools_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
game.AddParticles("particles/plate_green.pcf")
PrecacheParticleSystem("plate_green")
if(SERVER) then
	AddCSLuaFile("includes/modules/json.lua")
	AddCSLuaFile("autorun/client/cl_npctools_relationships.lua")
end