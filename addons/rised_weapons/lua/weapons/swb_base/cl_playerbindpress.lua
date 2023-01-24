-- "addons\\rised_weapons\\lua\\weapons\\swb_base\\cl_playerbindpress.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
local wep, CT

function SWEP.PlayerBindPress(ply, b, p)
	if p then
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.SWBWeapon then
			if wep.dt and wep.dt.State == SWB_AIMING then
				if wep.AdjustableZoom then
					CT = CurTime()
					
					if b == "invprev" then
						CT = CurTime()
						
						if CT > wep.ZoomWait then
							if wep.ZoomAmount > wep.MinZoom then
								wep.ZoomAmount = math.Clamp(wep.ZoomAmount - 15, wep.MinZoom, wep.MaxZoom)
								surface.PlaySound("weapons/zoom.wav")
								wep.ZoomWait = CT + 0.15

							end
						end
						
						return true
					elseif b == "invnext" then
						CT = CurTime()
						
						if CT > wep.ZoomWait then
							if wep.ZoomAmount < wep.MaxZoom then
								wep.ZoomAmount = math.Clamp(wep.ZoomAmount + 15, wep.MinZoom, wep.MaxZoom)
								surface.PlaySound("weapons/zoom.wav")
								wep.ZoomWait = CT + 0.15
							end
						end
						
						return true
					end
				end
			end
		end
	end
end

hook.Add("PlayerBindPress", "SWEP.PlayerBindPress (SWB)", SWEP.PlayerBindPress)