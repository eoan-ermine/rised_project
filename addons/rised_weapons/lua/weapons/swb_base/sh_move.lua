-- "addons\\rised_weapons\\lua\\weapons\\swb_base\\sh_move.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
local reg = debug.getregistry()
local GetActiveWeapon = reg.Player.GetActiveWeapon
local GetDTFloat = reg.Entity.GetDTFloat
local GetRunSpeed = reg.Player.GetRunSpeed
local GetWalkSpeed = reg.Player.GetWalkSpeed
local GetCrouchedWalkSpeed = reg.Player.GetCrouchedWalkSpeed
local Crouching = reg.Player.Crouching

local wep

function SWB_Move(ply, m)
	if Crouching(ply) then
		m:SetMaxSpeed(GetWalkSpeed(ply) * GetCrouchedWalkSpeed(ply))
	else
		wep = GetActiveWeapon(ply)
		
		if IsValid(wep) and wep.SWBWeapon then
			if wep.dt and wep.dt.State == SWB_AIMING then
				m:SetMaxSpeed(GetWalkSpeed(ply) * 0.75)
			else
				m:SetMaxSpeed((GetRunSpeed(ply) - wep.SpeedDec))
			end
		else
			m:SetMaxSpeed(GetRunSpeed(ply))
		end
	end
end

//hook.Add("Move", "SWB_Move", SWB_Move)