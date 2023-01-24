-- "lua\\tfa\\modules\\tfa_snd_timescale.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local sv_cheats_cv = GetConVar("sv_cheats")
local host_timescale_cv = GetConVar("host_timescale")
local ts

local en_cvar = GetConVar("sv_tfa_soundscale")

hook.Add("EntityEmitSound", "zzz_TFA_EntityEmitSound", function(soundData)
	local ent = soundData.Entity
	local modified
	local weapon

	if ent:IsWeapon() then
		weapon = ent
	elseif ent:IsNPC() or ent:IsPlayer() then
		weapon = ent:GetActiveWeapon()
	end

	if IsValid(weapon) and weapon.IsTFA and weapon.IsTFAWeapon then
		if weapon.GonnaAdjuctPitch then
			soundData.Pitch = soundData.Pitch * weapon.RequiredPitch
			weapon.GonnaAdjuctPitch = false
			modified = true
		end

		if weapon.GonnaAdjustVol then
			soundData.Volume = soundData.Volume * weapon.RequiredVolume
			weapon.GonnaAdjustVol = false
			modified = true
		end
	end

	if not en_cvar then return modified end
	if not en_cvar:GetBool() then return modified end
	ts = game.GetTimeScale()

	if sv_cheats_cv:GetBool() then
		ts = ts * host_timescale_cv:GetFloat()
	end

	if engine.GetDemoPlaybackTimeScale then
		ts = ts * engine.GetDemoPlaybackTimeScale()
	end

	if ts ~= 1 then
		soundData.Pitch = math.Clamp(soundData.Pitch * ts, 0, 255)
		return true
	end

	return modified
end)
