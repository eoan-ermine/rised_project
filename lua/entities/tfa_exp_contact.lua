-- "lua\\entities\\tfa_exp_contact.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

ENT.Base = "tfa_exp_base"
ENT.PrintName = "Contact Explosive"

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		self.killtime = -1
	end
end