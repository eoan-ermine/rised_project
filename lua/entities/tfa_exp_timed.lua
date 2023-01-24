-- "lua\\entities\\tfa_exp_timed.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

ENT.Base = "tfa_exp_base"
ENT.PrintName = "Timed Explosive"

ENT.BounceSound = Sound("HEGrenade.Bounce")

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		if self.BounceSound then
			self:EmitSoundNet(self.BounceSound)
		end

		local impulse = (data.OurOldVelocity - 2 * data.OurOldVelocity:Dot(data.HitNormal) * data.HitNormal) * 0.25
		phys:ApplyForceCenter(impulse)
	end
end