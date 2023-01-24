-- "lua\\tfa\\modules\\cl_tfa_projtex.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local ply = LocalPlayer()
local LocalPlayer = LocalPlayer

hook.Add("PreRender", "TFACleanupProjectedTextures", function()
	if not IsValid(ply) then
		ply = LocalPlayer()
		if not IsValid(ply) then return end
	end

	local wep = ply:GetActiveWeapon()

	if not IsValid(wep) or not wep.IsTFAWeapon then
		if IsValid(ply.TFAFlashlightGun) then
			ply.TFAFlashlightGun:Remove()
		end

		if IsValid(ply.TFALaserDot) then
			ply.TFALaserDot:Remove()
		end
	end
end)

hook.Add("PrePlayerDraw", "TFACleanupProjectedTextures", function(plyv)
	local wep = plyv:GetActiveWeapon()

	if not IsValid(wep) or not wep.IsTFAWeapon then
		if IsValid(plyv.TFAFlashlightGun) then
			plyv.TFAFlashlightGun:Remove()
		end

		if IsValid(plyv.TFALaserDot) then
			plyv.TFALaserDot:Remove()
		end
	end
end)
