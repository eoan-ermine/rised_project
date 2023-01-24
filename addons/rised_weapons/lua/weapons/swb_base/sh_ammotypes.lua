-- "addons\\rised_weapons\\lua\\weapons\\swb_base\\sh_ammotypes.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
function SWB_AddAmmoType(name)
	game.AddAmmoType({name = name,
	dmgtype = DMG_BULLET})
	
	if CLIENT then
		language.Add(name .. "_ammo", name .. " Ammo")
	end
end

SWB_AddAmmoType("Rifle")
SWB_AddAmmoType("Sniper Rifle")