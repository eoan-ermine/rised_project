-- "lua\\entities\\tfa_exp_base\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.PrintName = "Base Explosive"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local sp = game.SinglePlayer()

function ENT:EmitSoundNet(sound)
	if CLIENT or sp then
		if sp and not IsFirstTimePredicted() then return end

		self:EmitSound(sound)

		return
	end

	local filter = RecipientFilter()
	filter:AddPAS(self:GetPos())
	if IsValid(self:GetOwner()) then
		filter:RemovePlayer(self:GetOwner())
	end

	net.Start("tfaSoundEvent", true)
	net.WriteEntity(self)
	net.WriteString(sound)
	net.Send(filter)
end
