-- "lua\\weapons\\rust_syringe\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 60
SWEP.UseHands = true

SWEP.PrintName = "Medical Syringe v2"
SWEP.Slot = 5
SWEP.SlotPos = 2

if CLIENT then 
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/weapon_rust_syringe" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false 
end

SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.Category = "Darky Weapons"

SWEP.ViewModel = "models/weapons/darky_m/c_syringe_v2.mdl"
SWEP.WorldModel = "models/weapons/darky_m/w_syringe_v2.mdl"

SWEP.HealAmount = 14 -- there will actually 15 cause regeneration makes instant +1 hp
SWEP.RegenAmount = 21 -- 21 to compensate it

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Syringes"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HoldType = "slam"

SWEP.Insert = 0
SWEP.IdleTimer = CurTime()
SWEP.InsertTimer = CurTime()


function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()
    self:SendWeaponAnim(ACT_VM_DRAW)
    self.IdleTimer = CurTime() + self:GetOwner():GetViewModel():SequenceDuration()
    return true
end

function SWEP:Holster()
    self.Insert = 0
    self.IdleTimer = CurTime()
    self.InsertTimer = CurTime()
    return true
end

function SWEP:PrimaryAttack()
    local Owner = self:GetOwner()
    if Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then return end
    if self.Insert != 0 then return end

    Owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RELOAD_PISTOL)
    if CLIENT then return end
    local CT = CurTime()

    self:SendWeaponAnim(ACT_VM_THROW)
    self.Insert = 1
    self.InsertTimer = CT + Owner:GetViewModel():SequenceDuration()
    self.SoundTimer = CT + 0.3
end

function SWEP:SecondaryAttack()
    local Owner = self:GetOwner()
    if Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then return end
    if self.Insert != 0 then return end

    local Traced = self:CheckTrace()

    if IsValid(Traced) and Traced:IsPlayer() or Traced:IsNPC() then
        Owner:DoAnimationEvent(ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND)
        if CLIENT then return end
        local CT = CurTime()

        self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
        self.Friend = Traced
        self.TraceCheckTimer = CurTime() + 0.2
        self.Insert = 2
        self.InsertTimer = CT + Owner:GetViewModel():SequenceDuration()
        self.SoundTimer = CT + 0.3
    end
end

function SWEP:CheckTrace()
    local Owner = self:GetOwner()
    Owner:LagCompensation(true)

    local Trace = util.TraceLine({
        start = Owner:GetShootPos(),
        endpos = Owner:GetShootPos() + Owner:GetAimVector() * 64,
        filter = Owner
    })

    Owner:LagCompensation(false)

    return Trace.Entity
end

function SWEP:Heal(target)
    local Owner = self:GetOwner()
    self.Insert = 0
    self.IdleTimer = CurTime()
    Owner:RemoveAmmo(1, self.Primary.Ammo)
    target:SetHealth(math.min(target:GetMaxHealth(), target:Health() + self.HealAmount))

    target.DHPRegen = (target.DHPRegen and target.DHPRegen or 0) + self.RegenAmount
    target.LastDHPRegen = CurTime()
    DHPRegenList[target] = true

    if Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
        Owner:StripWeapon("rust_syringe")
    end
end

function SWEP:CancelHeal()
    self.Insert = 0
    self.IdleTimer = CurTime()
    self.Friend = nil
end

function SWEP:Think()
    local CT = CurTime()
    local Owner = self:GetOwner()

    if self.IdleTimer <= CT then
        self:IdleAnimation()
    end

    if CLIENT then return end

    if self.SoundTimer and self.SoundTimer <= CT then
        if self.Insert == 1 then
            Owner:EmitSound("darky_rust.syringe-inject-self")
            self.SoundTimer = nil
        elseif self.Insert == 2 then
            Owner:EmitSound("darky_rust.syringe-inject-friend")
            self.SoundTimer = nil
        end
    end

    if self.Insert == 1 and self.InsertTimer <= CT then
        self:Heal(Owner)
    end

    if self.Insert == 2 then
        if self.InsertTimer <= CT then
            self:Heal(self.Friend)
            self.TraceCheckTimer = nil
        end

        if self.TraceCheckTimer and self.TraceCheckTimer <= CT then
            if self:CheckTrace() != self.Friend then
                self:CancelHeal()
            else
                self.TraceCheckTimer = CurTime() + 0.2
            end
        end
    end
end

function SWEP:IdleAnimation()
    if SERVER and self.Insert == 0 then
        self:SendWeaponAnim(ACT_VM_IDLE)
        self.IdleTimer = CurTime() + self:GetOwner():GetViewModel():SequenceDuration()
    end
end