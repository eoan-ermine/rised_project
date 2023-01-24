-- "addons\\rised_cooking\\lua\\weapons\\weapon_knife_cookingmod\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local _ = {
    _ = "Primary",
    a = "Secondary",
    b = "Owner",
    c = "Weapon"
}

SWEP[_._].ClipSize = -1
SWEP[_._].DefaultClip = -1
SWEP[_._].Delay = 2
SWEP[_._].Automatic = not not 1
SWEP[_._].Ammo = "None"
SWEP[_.a].ClipSize = -1
SWEP[_.a].DefaultClip = -1
SWEP[_.a].Automatic = not 1
SWEP[_.a].Ammo = "None"
SWEP.Weight = 3
SWEP.AutoSwitchTo = not 1
SWEP.AutoSwitchFrom = not 1
SWEP.DrawAmmo = not 1
SWEP.DrawCrosshair = not not 1
SWEP.IdleAnim = not not 1
SWEP.IconLetter = "w"
SWEP.UseHands = not not 1
SWEP.Author = "Bananowytasiemiec"
SWEP.Purpose = "Slice Bread"
SWEP.Category = "Cooking Mod"
SWEP.Instructions = "LMB to attack"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = not 1
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.PrintName = "Cooking Knife"
SWEP.HoldType = "knife"
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Spawnable = not not 1
SWEP.AdminSpawnable = not not 1

function SWEP:Initialize()
    self:SetHoldType( "knife" )
end

function SWEP:PrimaryAttack()
    self[_.c]:SetNextPrimaryFire(CurTime() + 0.3)
    local c = self[_.b]:GetEyeTrace()

    if c.HitPos:Distance(self[_.b]:GetShootPos()) <= 75 then
        self[_.b]:SetAnimation(PLAYER_ATTACK1)
        self[_.c]:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
        bullet = {}
        bullet.Num = 1
        bullet.Src = self[_.b]:GetShootPos()
        bullet.Dir = self[_.b]:GetAimVector()
        bullet.Spread = Vector(0, 0, 0)
        bullet.Tracer = 0
        bullet.Force = 25
        bullet.Damage = 20
        bullet.Distance = 75
        self[_.b]:FireBullets(bullet)
    else
        self[_.b]:SetAnimation(PLAYER_ATTACK1)
        self[_.c]:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    end

    self[_.c]:SetNextPrimaryFire(CurTime() + 0.7)
end

function SWEP:Deploy()
    return not not 1
end

function SWEP:Holster()
    return not not 1
end

function SWEP:SecondaryAttack()
	return!1
end