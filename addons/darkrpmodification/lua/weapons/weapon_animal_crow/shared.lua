-- "addons\\darkrpmodification\\lua\\weapons\\weapon_animal_crow\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

SWEP.PrintName = "Полет"
SWEP.Slot = 0
SWEP.SlotPos = 5
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize, SWEP.Secondary.ClipSize = -1, -1
SWEP.Primary.DefaultClip, SWEP.Secondary.DefaultClip = -1, -1
SWEP.Primary.Automatic, SWEP.Primary.Automatic = false, false
SWEP.Primary.Ammo, SWEP.Secondary.Ammo = "none", "none"
SWEP.ViewModel = Model("")
SWEP.WorldModel = Model("")

SWEP.Primary.Delay = 2



function SWEP:Deploy()
	self:GetOwner().SkipCrow = true
	return true
end

function SWEP:Initialize()
end

function SWEP:OnRemove()
	local owner = self:GetOwner()
	if owner and owner:IsValid() then
		if owner.Flapping then
			owner:StopSound("NPC_Crow.Flap")
		end
		owner.Flapping = nil
	end
end
SWEP.Holster = SWEP.OnRemove


function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Think()
end


function SWEP:SetPeckEndTime(time)
	self:SetDTFloat(0, time)
end

function SWEP:GetPeckEndTime()
	return self:GetDTFloat(0)
end

function SWEP:IsPecking()
	return CurTime() < self:GetPeckEndTime()
end

function SWEP:Holster()
	local owner = self:GetOwner()
	if owner:IsValid() then
		owner:StopSound("NPC_Crow.Flap")
		owner:SetAllowFullRotation(false)
	end
end
SWEP.OnRemove = SWEP.Holster

function SWEP:Think()
	local owner = self:GetOwner()

	local fullrot = not owner:OnGround()
	if owner:GetAllowFullRotation() ~= fullrot then
		owner:SetAllowFullRotation(fullrot)
	end

	if owner:IsOnGround() or not owner:KeyDown(IN_JUMP) or not owner:KeyDown(IN_FORWARD) then
		if self.PlayFlap then
			owner:StopSound("NPC_Crow.Flap")
			self.PlayFlap = nil
		end
	else
		if not self.PlayFlap then
			owner:EmitSound("NPC_Crow.Flap")
			self.PlayFlap = true
		end
	end

	local peckend = self:GetPeckEndTime()
	if peckend == 0 or CurTime() < peckend then return end
	self:SetPeckEndTime(0)

	local trace = owner:TraceLine(14, MASK_SOLID)
	local ent = NULL
	if trace.Entity then
		ent = trace.Entity
	end

	owner:ResetSpeed()

end

function SWEP:PrimaryAttack()
	if CurTime() < self:GetNextPrimaryFire() or not self:GetOwner():IsOnGround() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:GetOwner():EmitSound("NPC_Crow.Squawk")
	self:GetOwner().EatAnim = CurTime() + 2

	self:SetPeckEndTime(CurTime() + 1)

end

function SWEP:SecondaryAttack()
	if CurTime() < self:GetNextSecondaryFire() then return end
	self:SetNextSecondaryFire(CurTime() + 1.6)

	self:GetOwner():EmitSound("NPC_Crow.Alert")
end

function SWEP:Reload()
	self:SecondaryAttack()
	return false
end

hook.Add("CalcMainActivity", 'KarKarKarKar', function(ply, velocity)

	if ply:HasWeapon('weapon_animal_crow') or ply:GetModel() == 'models/crow.mdl' then

		if ply:OnGround() then
			local wep = ply:GetActiveWeapon()
			if wep:IsValid() and wep.IsPecking and wep:IsPecking() then
				return 1, 5
			end

			if velocity:Length2DSqr() > 1 then
				return ACT_RUN, -1
			end

			return ACT_IDLE, -1
		end

		if velocity:LengthSqr() > 122500 then --350^2
			return ACT_FLY, -1
		end

		return 1, 7

	end
		
end)

hook.Add("CalcView", "CrowBlyatYletela", function(ply, pos, angles, fov)

	if (!IsValid(ply)) then return end
 
	if (!ply:HasWeapon('weapon_animal_crow')) then return end

	local crow_eye = {}

	crow_eye.origin = pos - angles:Up() * 50 - angles:Forward() * 25
	crow_eye.angles = angles
	crow_eye.fov = fov
	crow_eye.drawviewer = true

	return crow_eye

end)

function SWEP:Think()

	if self.Owner:KeyDown(IN_JUMP) then

		self.Owner:SetWalkSpeed(150)

		self.Owner:SetMoveType(4)


	else

		self.Owner:SetMoveType(2)

		self.Owner:SetWalkSpeed(100)


	end

end