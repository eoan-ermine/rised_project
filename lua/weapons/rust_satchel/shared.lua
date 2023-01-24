-- "lua\\weapons\\rust_satchel\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_cssnade_base"
SWEP.Category = "TFA Rust Weapons"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false

SWEP.Author = "Darky"
SWEP.PrintName = "Satchel Charge"

SWEP.ViewModel = "models/weapons/darky_m/rust/c_satchel.mdl"
SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/darky_m/rust/w_satchel.mdl"
SWEP.HoldType = "slam"

SWEP.ViewModelFOV = 60
SWEP.Weight = 100
SWEP.DrawCrosshair = false
SWEP.Type = "Throwable Explosive"


SWEP.Idle_Mode = TFA.Enum.IDLE_LUA

-- SWEP.IronInSound = Sound("darky_rust.combat-deploy") --Sound to play when ironsighting in?  nil for default
-- SWEP.IronOutSound = Sound("TFA_INS2.IronOut") --Sound to play when ironsighting out?  nil for default

SWEP.Primary.Ammo		= "rust_satchel"
SWEP.Primary.Damage		= 475
SWEP.Primary.Delay		= 9
SWEP.Primary.Radius		= 210
SWEP.Primary.NumShots	= 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic			= true
SWEP.Primary.RPM				= 68
SWEP.FiresUnderwater = true
SWEP.Primary.Force = 10
SWEP.AllowSprintAttack = true

SWEP.EventTable = {}

SWEP.Primary.Projectile = "rust_charge"
SWEP.Primary.ProjectileModel = "models/weapons/darky_m/rust/w_satchel.mdl"

SWEP.AllowSprintAttack = false
SWEP.AllowUnderhanded = false 
SWEP.Slot = 4
SWEP.SlotPos = 74

SWEP.RunSightsPos = Vector(1, 0, 1)
SWEP.RunSightsAng = Vector(-18, 0, 0)


function SWEP:SecondaryAttack()
	-- ParticleEffect( "rust_big_explosion", self:GetOwner():GetEyeTrace().HitPos, Angle( 0, 0, 0 ) )
end

function SWEP:ShootBulletInformation()
	if SERVER then
		if not self:IsValid() then return end
		self:GetOwner():EmitSound("darky_rust.throw-item-small")
		local ent = ents.Create(self:GetStat("Primary.Projectile"))
		local ang = self:GetOwner():EyeAngles()

		ang:RotateAroundAxis(ang:Right(), math.Rand(0, 0.5) - 0.25)
		ang:RotateAroundAxis(ang:Up(), math.Rand(0, 0.5) - 0.25)

		local dir = ang:Forward()

		if ent:IsValid() then
			ang:RotateAroundAxis(ang:Right(), 90)
			ang:RotateAroundAxis(ang:Up(), 180)
			ent:SetPos(self:GetOwner():GetShootPos())
			ent:SetAngles(ang)
			ent:SetModel(self:GetStat("Primary.ProjectileModel"))
			ent:SetPhysicsAttacker(self:GetOwner())
			ent:SetOwner(self:GetOwner())
			ent.damage = self:GetStat("Primary.Damage")
			ent.radius = self:GetStat("Primary.Radius")
			ent.delay = self:GetStat("Primary.Delay")
			ent.owner = self:GetOwner()
			ent.sound = "darky_rust.satchel-charge-explosion-00"
			ent.randomturnoff = true
			ent:Spawn()

			local phys = ent:GetPhysicsObject()

			if IsValid(phys) then
				phys:SetVelocity(dir * 500)
			end
				
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)

			ent:SetNW2String("ClassName", self:GetClass())
		end
	end
end
