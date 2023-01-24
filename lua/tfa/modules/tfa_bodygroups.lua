-- "lua\\tfa\\modules\\tfa_bodygroups.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local sp = game.SinglePlayer()

hook.Add("PlayerSwitchWeapon", "TFA_Bodygroups_PSW", function(ply, oldwep, wep)
	if not IsValid(wep) or not wep.IsTFAWeapon then return end

	timer.Simple(0, function()
		if not IsValid(ply) or ply:GetActiveWeapon() ~= wep then return end

		wep:ApplyViewModelModifications()

		if sp then
			wep:CallOnClient("ApplyViewModelModifications")
		end
	end)
end)
