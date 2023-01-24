-- "lua\\effects\\tfa_muzzlesmoke\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local ang
local limit_particle_cv = GetConVar("cl_tfa_fx_muzzlesmoke_limited")
local SMOKEDELAY = 1.5

function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	if not IsValid(self.WeaponEnt) then return end
	self.WeaponEntOG = self.WeaponEnt
	if limit_particle_cv:GetBool() and self.WeaponEnt:GetOwner() ~= LocalPlayer() then return end
	self.Attachment = data:GetAttachment()
	local smokepart = "smoke_trail_tfa"
	local delay = self.WeaponEnt.GetStatL and self.WeaponEnt:GetStatL("SmokeDelay") or self.WeaponEnt.SmokeDelay

	if self.WeaponEnt.SmokeParticle then
		smokepart = self.WeaponEnt.SmokeParticle
	elseif self.WeaponEnt.SmokeParticles then
		smokepart = self.WeaponEnt.SmokeParticles[self.WeaponEnt.DefaultHoldType or self.WeaponEnt.HoldType] or smokepart
	end

	self.Position = self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)

	if IsValid(self.WeaponEnt:GetOwner()) then
		if self.WeaponEnt:GetOwner() == LocalPlayer() then
			if not self.WeaponEnt:IsFirstPerson() then
				ang = self.WeaponEnt:GetOwner():EyeAngles()
				ang:Normalize()
				--ang.p = math.max(math.min(ang.p,55),-55)
				self.Forward = ang:Forward()
			else
				self.WeaponEnt = self.WeaponEnt.OwnerViewModel
			end
			--ang.p = math.max(math.min(ang.p,55),-55)
		else
			ang = self.WeaponEnt:GetOwner():EyeAngles()
			ang:Normalize()
			self.Forward = ang:Forward()
		end
	end

	if TFA.GetMZSmokeEnabled == nil or TFA.GetMZSmokeEnabled() then
		local e = self.WeaponEnt
		local w = self.WeaponEntOG
		local a = self.Attachment
		local tn = "tfasmokedelay_" .. w:EntIndex() .. "_" .. a
		local sp = smokepart

		if timer.Exists(tn) then
			timer.Remove(tn)
		end

		e.SmokePCF = e.SmokePCF or {}
		local _a = w:GetStatL("IsAkimbo") and a or 1

		if IsValid(e.SmokePCF[_a]) then
			e.SmokePCF[_a]:StopEmission()
		end

		timer.Create(tn, delay or SMOKEDELAY, 1, function()
			if not IsValid(e) then return end
			e.SmokePCF[_a] = CreateParticleSystem(e, sp, PATTACH_POINT_FOLLOW, a)

			if IsValid(e.SmokePCF[_a]) then
				e.SmokePCF[_a]:StartEmission()
			end
		end)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end