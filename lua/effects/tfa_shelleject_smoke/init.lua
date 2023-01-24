-- "lua\\effects\\tfa_shelleject_smoke\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local vector_origin = Vector()

EFFECT.SmokeParticle = "tfa_ins2_shell_eject"
local upVec = Vector(0, 0, 1)

function EFFECT:ComputeSmokeLighting(part, pos)
	if not IsValid(part) then return end
	local licht = render.ComputeLighting(pos + upVec * 2, upVec)
	local lichtFloat = math.Clamp((licht.r + licht.g + licht.b) / 3, 0, TFA.Particles.SmokeLightingClamp) / TFA.Particles.SmokeLightingClamp
	local lichtFinal = LerpVector(lichtFloat, TFA.Particles.SmokeLightingMin, TFA.Particles.SmokeLightingMax)
	lichtFinal.x = math.sqrt(math.Clamp(lichtFinal.x-0.2,0,0.8)) / 0.8
	lichtFinal.y = math.sqrt(math.Clamp(lichtFinal.y-0.2,0,0.8)) / 0.8
	lichtFinal.z = math.sqrt(math.Clamp(lichtFinal.z-0.2,0,0.8)) / 0.8
	part:SetControlPoint(1, lichtFinal)
end

function EFFECT:Init(data)
	if not TFA.GetEJSmokeEnabled() then return end
	self.WeaponEnt = data:GetEntity()
	if not IsValid(self.WeaponEnt) then return end
	self.WeaponEntOG = self.WeaponEnt
	self.Attachment = data:GetAttachment()
	local owent = self.WeaponEnt:GetOwner()

	if not IsValid(owent) then
		owent = self.WeaponEnt:GetParent()
	end

	if IsValid(owent) and owent:IsPlayer() then
		if owent ~= LocalPlayer() or owent:ShouldDrawLocalPlayer() then
			self.WeaponEnt = owent:GetActiveWeapon()
			if not IsValid(self.WeaponEnt) then return end
		else
			local theirweapon = owent:GetActiveWeapon()
			self.WeaponEnt = self.WeaponEnt.OwnerViewModel

			if IsValid(theirweapon) and theirweapon.ViewModelFlip or theirweapon.ViewModelFlipped then
				self.Flipped = true
			end

			if not IsValid(self.WeaponEnt) then return end
		end
	end

	if IsValid(self.WeaponEntOG) and self.WeaponEntOG.ShellAttachment then
		self.Attachment = self.WeaponEnt:LookupAttachment(self.WeaponEntOG.ShellAttachment)

		if not self.Attachment or self.Attachment <= 0 then
			self.Attachment = 2
		end

		if self.WeaponEntOG:GetStatL("IsAkimbo") then
			self.Attachment = 3 + self.WeaponEntOG:GetAnimCycle()
		end

		if self.WeaponEntOG.ShellAttachmentRaw then
			self.Attachment = self.WeaponEntOG.ShellAttachmentRaw
		end
	end

	local angpos = self.WeaponEnt:GetAttachment(self.Attachment)

	if not angpos or not angpos.Pos then
		angpos = {
			Pos = vector_origin,
			Ang = angle_zero
		}
	end

	local PCFSmoke = CreateParticleSystem(self.WeaponEnt, self.SmokeParticle, PATTACH_POINT_FOLLOW, self.Attachment)

	if IsValid(PCFSmoke) then
		self:ComputeSmokeLighting(PCFSmoke, angpos.Pos)
		PCFSmoke:StartEmission()

		timer.Simple(0.2, function()
			if IsValid(PCFSmoke) then
				PCFSmoke:StopEmission(false,true)
			end
		end)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end