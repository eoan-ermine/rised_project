-- "lua\\tfa\\modules\\tfa_darkrp.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local TFA_PocketBlock = {}
TFA_PocketBlock["tfa_ammo_357"] = true
TFA_PocketBlock["tfa_ammo_ar2"] = true
TFA_PocketBlock["tfa_ammo_buckshot"] = true
TFA_PocketBlock["tfa_ammo_c4"] = true
TFA_PocketBlock["tfa_ammo_frags"] = true
TFA_PocketBlock["tfa_ammo_ieds"] = true
TFA_PocketBlock["tfa_ammo_nervegas"] = true
TFA_PocketBlock["tfa_ammo_nuke"] = true
TFA_PocketBlock["tfa_ammo_pistol"] = true
TFA_PocketBlock["tfa_ammo_proxmines"] = true
TFA_PocketBlock["tfa_ammo_rockets"] = true
TFA_PocketBlock["tfa_ammo_smg"] = true
TFA_PocketBlock["tfa_ammo_smg1_grenade"] = true
TFA_PocketBlock["tfa_ammo_smg1_grenade_large"] = true
TFA_PocketBlock["tfa_ammo_sniper_rounds"] = true
TFA_PocketBlock["tfa_ammo_stickynades"] = true
TFA_PocketBlock["tfa_ammo_winchester"] = true

local function TFA_PockBlock(ply, wep) --Get it, because cockblock, hehe.....  so mature.
	if not IsValid(wep) then return end
	local class = wep:GetClass()
	if TFA_PocketBlock[class] then return false end
end

hook.Add("canPocket", "TFA_PockBlock", TFA_PockBlock)
