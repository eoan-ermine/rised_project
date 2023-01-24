-- "addons\\rised_forcefields\\lua\\entities\\fieldterminal_locker\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.PrintName		= "Локер барьера";
ENT.Category 		= "A - Rised - [Альянс]";
ENT.Author			= "D-Rised";

ENT.Contact    		= "";
ENT.Purpose 		= "";
ENT.Instructions 	= "" ;

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;

if CLIENT then
	local glowMaterial = Material("sprites/glow04_noz")

	function ENT:Draw()
		self:DrawModel()
		
		local smokeChargeTime = self:GetDTFloat(0)
		local r, g, b, a = self:GetColor()
		local flashTime = self:GetDTFloat(1)
		local position = self:GetPos()
		local forward = self:GetForward() * -4
		local curTime = CurTime()
		local right = self:GetRight() * -6
		local up = self:GetUp() * -9
		
		if (smokeChargeTime > curTime) then
			local glowColor = Color(255, 0, 0, a)
			local timeLeft = smokeChargeTime - curTime
			
			if (!self.nextFlash or curTime >= self.nextFlash or (self.flashUntil and self.flashUntil > curTime)) then
				cam.Start3D( EyePos(), EyeAngles() )
					render.SetMaterial(glowMaterial)
					render.DrawSprite(position + forward + right + up, 20, 20, glowColor)
				cam.End3D()
				
				if (!self.flashUntil or curTime >= self.flashUntil) then
					self.nextFlash = curTime + (timeLeft / 4)
					self.flashUntil = curTime + (FrameTime() * 4)
					
					self:EmitSound("hl1/fvox/beep.wav")
				end
			end
		else
			local glowColor = Color(0, 255, 0, a)
			
			if self:GetNWBool("TERMIsBroken") then
				glowColor = Color(255, 255, 255, 155)
			elseif self:GetNWBool("ForcefieldActivated") then
				glowColor = Color(255, 0, 0, a)
			elseif !self:GetNWBool("ForcefieldActivated") then
				glowColor = Color(255, 150, 0, a)
			end
			
			cam.Start3D( EyePos(), EyeAngles() )
				render.SetMaterial(glowMaterial)
				render.DrawSprite(position + forward + right + up, 20, 20, glowColor)
			cam.End3D()
		end
	end
end