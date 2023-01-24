-- "addons\\realistichandcuffs\\lua\\tbfy_rhandcuffs\\sh_rhandcuffs_languages.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

for k, v in pairs(file.Find("tbfy_rhandcuffs/languages/*.lua","LUA")) do 
	include("tbfy_rhandcuffs/languages/" .. v);
	if SERVER then
		AddCSLuaFile("tbfy_rhandcuffs/languages/" .. v);
	end
end
