-- "lua\\weapons\\rust_rocketlauncher\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Rust Weapons"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false

SWEP.Author = "Darky"
SWEP.PrintName = "Rocket Launcher"

SWEP.ViewModel = "models/weapons/darky_m/rust/c_rocketlauncher.mdl"
SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/darky_m/rust/w_rocketlauncher.mdl"
SWEP.HoldType = "rpg"

SWEP.ViewModelFOV = 60
SWEP.Weight = 100

SWEP.Type = "Rocket Launcher"

SWEP.Slot = 4
SWEP.SlotPos = 74
SWEP.Idle_Mode = TFA.Enum.IDLE_LUA

-- SWEP.IronInSound = Sound("darky_rust.combat-deploy") --Sound to play when ironsighting in?  nil for default
-- SWEP.IronOutSound = Sound("TFA_INS2.IronOut") --Sound to play when ironsighting out?  nil for default

SWEP.Primary.Ammo		= "RPG_Round"
SWEP.Primary.Damage		= 350
SWEP.Primary.Radius		= 256
SWEP.Primary.NumShots	= 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic			= true
SWEP.Primary.RPM				= 68
SWEP.FiresUnderwater = true
SWEP.Primary.Force = 10
SWEP.AllowSprintAttack = true
SWEP.DisableChambering = true

SWEP.MuzzleAttachment = "0" 
SWEP.Attachments = {
	[1] = {atts = {"darky_rust_rocket_hv", "darky_rust_rocket_inc"}},
}
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 4.6, ["type"] = "lua", ["value"] = function(wep, vm)
			local effectdata = EffectData()
			effectdata:SetEntity(vm)
			effectdata:SetAttachment(2)
			effectdata:SetScale(0.5)
			util.Effect("CrossbowLoad", effectdata)
		end, ["client"] = true, ["server"] = false },
	},
}

SWEP.Primary.Projectile = "rust_rocket"
SWEP.Primary.ProjectileModel = "models/weapons/darky_m/rust/rocket.mdl"
SWEP.Primary.ProjectileVelocity = 3000

SWEP.AllowSprintAttack = false
SWEP.AllowUnderhanded = false 

SWEP.IronSightsPos = Vector(-2.401, 0, 3.839)
SWEP.IronSightsAng = Vector(0.699, 3.7, -25.629)

SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false

SWEP.Secondary.IronFOV = 75
SWEP.RunSightsPos = Vector(1, 0, 1)
SWEP.RunSightsAng = Vector(-18, 0, 0)


function SWEP:ShootBullet()
	if CLIENT then
		if not self:IsValid() then return end
		ParticleEffect("generic_smoke", self.Owner:GetShootPos()+self.Owner:EyeAngles():Forward()*30, Angle(0,0,0), self)
	end
	if SERVER then
		self:GetOwner():EmitSound("darky_rust.rpg_fire")
		if not self:IsValid() then return end

		local ent = ents.Create(self:GetStat("Primary.Projectile"))
		
		if ent:IsValid() then
			local aimcone = 0
			local dir
			local ang = self.Owner:EyeAngles()
			ang:RotateAroundAxis(ang:Right(), -aimcone / 2 + math.Rand(0, aimcone))
			ang:RotateAroundAxis(ang:Up(), -aimcone / 2 + math.Rand(0, aimcone))
			dir = ang:Forward()
			ent:SetPos(self.Owner:GetShootPos())
			ent.Owner = self.Owner
			ang:RotateAroundAxis(ang:Up(), -90)
			ent:SetAngles(ang)

			ent:SetModel(self:GetStat("Primary.ProjectileModel"))
			ent:SetPhysicsAttacker(self:GetOwner())
			ent:SetOwner(self:GetOwner())
			ent.damage = self:GetStat("Primary.Damage")
			ent.radius = self:GetStat("Primary.Radius")
			ent.owner = self:GetOwner()
			ent:Spawn()
			
			local phys = ent:GetPhysicsObject()

			if IsValid(phys) then
				phys:SetVelocity(dir * self:GetStat("Primary.ProjectileVelocity"))
			end
			-- local trail = util.SpriteTrail(ent, 0, Color(255, 255, 255), false, 15, 2, 0.4, 1 / ( 15 + 2 ) * 0.5, "trails/smoke" )

			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		end
	end
end
