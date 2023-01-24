-- "addons\\realistichandcuffs\\lua\\tbfy_rhandcuffs\\sh_rhandcuffs.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local PLAYER = FindMetaTable( "Player" )

function PLAYER:IsRHCWhitelisted()
    return GAMEMODE.MetropoliceJobs[self:Team()] or self:Team() == TEAM_REBELSPY01
end

hook.Add("canLockpick", "AllowCuffPicking", function(Player, CuffedP, Trace)
	if CuffedP:GetNWBool("rhc_cuffed", false) then
		return true
	end
end)

hook.Add("lockpickTime", "SetupCuffPickTime", function()
	return RHandcuffsConfig.CuffPickTime
end)