-- "addons\\combine_sniper\\lua\\weapons\\weapon_csniper.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.PrintName 				= "Combine Sniper"
SWEP.Author 				= "TankNut"

SWEP.RenderGroup 			= RENDERGROUP_BOTH

SWEP.Spawnable 				= true
SWEP.Category 				= "Half-Life 2"

SWEP.Slot 					= 3

SWEP.DrawWeaponInfoBox 		= false
SWEP.DrawCrosshair 			= false

SWEP.ViewModel 				= Model("models/tnb/weapons/c_cisr.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_cisr.mdl")

SWEP.ViewFOV 				= 54
SWEP.ZoomFOV 				= 20

SWEP.UseHands 				= true

SWEP.Primary.ClipSize 		= 1
SWEP.Primary.DefaultClip 	= 1000
SWEP.Primary.Ammo 			= "SniperRound"
SWEP.Primary.Automatic 		= false

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Ammo 		= ""
SWEP.Secondary.Automatic 	= false

SWEP.HoldType 				= "ar2"

local allow_lead = CreateConVar("csniper_lead_indicator", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether or not players can use lead indicators")
local infinite_ammo = CreateConVar("csniper_infinite_ammo", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Gives the combine sniper infinite ammo")

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)

	if CLIENT then
		hook.Add("PostDrawTranslucentRenderables", self, function()
			self:PostDrawTranslucentRenderables()
		end)

		self.PixVis = {}
		self.LeadVelocity = {}
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "InZoom")
	self:NetworkVar("Bool", 1, "InReload")
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
end

function SWEP:Holster()
	if self:GetInZoom() then
		self:ToggleZoom()
	end

	return true
end

function SWEP:OnRemove()
	if IsValid(self.Owner) and self:GetInZoom() then
		self:ToggleZoom()
	end
end

function SWEP:PrimaryAttack()
	if self:GetInReload() or not self:CanPrimaryAttack() then
		return
	end

	self:EmitSound("NPC_Sniper.FireBullet")

	if CLIENT then
		return
	end

	local ply = self.Owner

	ply:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	self:TakePrimaryAmmo(1)

	local ent = ents.Create("csniper_bullet")

	ent:SetPos(ply:GetShootPos())
	ent:SetAngles(self:GetAimDir())
	ent:SetOwner(ply)

	ent:Spawn()
	ent:Activate()
	
	timer.Simple(3, function()
		if IsValid(ent) then
			ent:Remove()
		end
	end)

	local kick = Angle(-0.5, math.Rand(-0.3, 0.3), 0)

	ply:SetEyeAngles(ply:EyeAngles() + kick)
	ply:ViewPunch(kick)

	self:SetNextPrimaryFire(CurTime() + 0.5)
end

function SWEP:SecondaryAttack()
	self:ToggleZoom()
end

function SWEP:Reload()
	if self:GetInReload() or self:Clip1() == self.Primary.ClipSize then
		return
	end

	local ply = self.Owner

	if ply:IsPlayer() and not infinite_ammo:GetBool() then
		local ammo = ply:GetAmmoCount(self.Primary.Ammo)

		if ammo <= 0 then
			return
		end
	end

	self.Owner:SetAnimation(PLAYER_RELOAD)

	self:EmitSound("NPC_Sniper.Reload")

	self:SetInReload(true)
	self:SetNextPrimaryFire(CurTime() + 2)
end

function SWEP:Think()
	if self:GetInReload() and CurTime() > self:GetNextPrimaryFire() then
		self:SetInReload(false)

		local amt = math.min(self.Owner:GetAmmoCount(self.Primary.Ammo), self.Primary.ClipSize)

		self:SetClip1(amt)

		if not infinite_ammo:GetBool() then
			self.Owner:RemoveAmmo(amt, self.Primary.Ammo)
		end
	end
end

function SWEP:ToggleZoom()
	local ply = self.Owner

	if self:GetInZoom() then
		ply:SetFOV(0, 0.2)

		self:SetInZoom(false)
	else
		ply:SetFOV(self.ZoomFOV, 0.1)

		self:SetInZoom(true)
	end
end

function SWEP:GetAimDir()
	local ply = self.Owner

	return ply:GetAimVector():Angle() + ply:GetViewPunchAngles()
end

function SWEP:GetAimTrace()
	local ply = self.Owner

	return util.TraceLine({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + (self:GetAimDir():Forward() * 8192),
		filter = {self.Owner, self},
		mask = MASK_SHOT
	})
end

function SWEP:GetTimeToTarget(pos)
	local speed = GetConVar("csniper_bullet_speed"):GetFloat()
	local dist = (pos - self.Owner:GetShootPos()):Length()

	return dist / speed
end

if CLIENT then
	local fov = GetConVar("fov_desired")
	local ratio = GetConVar("zoom_sensitivity_ratio")

	local lead_size = CreateConVar("csniper_lead_size", 5, FCVAR_ARCHIVE, "How big the lead indicator is, 0 disables the indicators alltogether")
	local lead_color = CreateConVar("csniper_lead_color", "1 0 0", FCVAR_ARCHIVE, "The color used for the lead indicator")

	function SWEP:AdjustMouseSensitivity()
		return (LocalPlayer():GetFOV() / fov:GetFloat()) * ratio:GetFloat()
	end

	function SWEP:ShouldDrawBeam()
		return CurTime() > self:GetNextPrimaryFire() and self:Clip1() > 0 and not self:GetInReload() and self:GetInZoom()
	end

	local beam = Material("effects/bluelaser1")
	local sprite = Material("effects/blueflare1")

	function SWEP:PreDrawViewModel(vm, wep, ply)
		self.ViewModelFOV = math.Remap(ply:GetFOV(), fov:GetFloat(), self.ZoomFOV, self.ViewFOV, fov:GetFloat())

		if self:ShouldDrawBeam() then
			local pos = vm:GetAttachment(1).Pos
			local tr = self:GetAimTrace()

			render.SetMaterial(beam)
			render.DrawBeam(pos, tr.HitPos, 1, 0, tr.Fraction * 10, Color(255, 0, 0))
			render.SetMaterial(sprite)
			render.DrawSprite(tr.HitPos, 2, 2, Color(50, 190, 255))
		end
	end

	function SWEP:PostDrawTranslucentRenderables()
		local ply = self.Owner

		if not IsValid(ply) then
			return
		end

		if ply == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() and not hook.Run("ShouldDrawLocalPlayer", ply) then
			return
		end

		if ply:InVehicle() then return end
		if ply:GetNoDraw() then return end

		if self:ShouldDrawBeam() then
			if IsValid(self:GetAttachment(1)) then
				local pos = self:GetAttachment(1).Pos
				local tr = self:GetAimTrace()

				render.SetMaterial(beam)
				render.DrawBeam(pos, tr.HitPos, 1, 0, tr.Fraction * 10, Color(255, 0, 0))
				render.SetMaterial(sprite)
				render.DrawSprite(tr.HitPos, 2, 2, Color(50, 190, 255))
			end
		end
	end
end