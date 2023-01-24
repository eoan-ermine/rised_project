-- "lua\\weapons\\alyx_emptool.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
if SERVER then
resource.AddFile("models/weapons/v_emptool.mdl")
resource.AddFile("models/weapons/w_emptool.mdl")
resource.AddFile("materials/entities/alyx_emptool.png")
end

SWEP.PrintName = "Alyx's EMP"
SWEP.Slot = 1
SWEP.SlotPos = 7
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Author = "Ryan Kruge (The Kruge)"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Left click to open/close doors or shut down rollermines. Right click to lock/unlock doors. Reload to make rollermines friendly/unfriendly!"
SWEP.ViewModel = "models/weapons/v_emptool.mdl"
SWEP.WorldModel = "models/weapons/w_emptool.mdl"
SWEP.Spawnable = true
SWEP.AdminOnly = false 
SWEP.ShootSound = Sound( "AlyxEMP.Discharge" )
SWEP.Category = "Alyx's EMP"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none" 
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize()
self:SetWeaponHoldType( "slam" )
end

function SWEP:Reload()
if self.ReloadTime == nil then 
self.ReloadTime = 0 
end

if CurTime() >= self.ReloadTime then
self.Weapon:SendWeaponAnim( ACT_VM_FIDGET )

if SERVER then
local trace = self.Owner:GetEyeTrace() 	

if trace.Entity:GetClass() == "npc_rollermine" then
self.Owner:EmitSound( self.ShootSound )

if trace.Entity.RollerMine == nil then
trace.Entity.RollerMine = false
end

if trace.Entity.RollerMine == false then
trace.Entity:SetColor(Color(0, 200, 0, 255))
trace.Entity:AddRelationship("npc_alyx D_LI 999")
trace.Entity:AddRelationship("player D_LI 999")
trace.Entity:AddRelationship("npc_combine_s D_HT 998")
trace.Entity:AddRelationship("npc_metropolice D_HT 999")
trace.Entity:AddRelationship("npc_zombie D_HT 999")
trace.Entity.RollerMine = true
elseif trace.Entity.RollerMine == true then
trace.Entity:SetColor(Color(255, 255, 255, 255))
trace.Entity:AddRelationship("npc_alyx D_HT 999")
trace.Entity:AddRelationship("player D_HT 999")
trace.Entity:AddRelationship("npc_combine_s D_FR 998")
trace.Entity.RollerMine = false
end
end
end
self.ReloadTime = CurTime() + 0.4
end
end

function SWEP:Think()
end

function SWEP:PrimaryAttack()
self.Weapon:SendWeaponAnim( ACT_VM_FIDGET )

if SERVER then
if self.CanAlyxOpen == nil then
self.CanAlyxOpen = false
end

if self.CanAlyxBall == nil then
self.CanAlyxBall = false
end

local trace = self.Owner:GetEyeTrace()

if trace == nil then return
end

if trace.HitPos:Distance(self.Owner:GetShootPos()) >= 0 then
self.Owner:EmitSound( self.ShootSound )
trace.Entity:Fire("Unlock", "", 0)
trace.Entity:Fire("SetAnimation", "Open", 0)
trace.Entity:Fire("Open", "", 0.01)

if (string.lower(trace.Entity:GetClass()) == "npc_rollermine") then
self.Owner:EmitSound( self.ShootSound )
trace.Entity:Fire("Powerdown", "", 0)
end
end
end

local trace = self.Owner:GetEyeTrace()

if !trace then return end
local effectdata = EffectData()
effectdata:SetOrigin( trace.HitPos )
effectdata:SetNormal( trace.HitNormal )
effectdata:SetMagnitude( 8 )
effectdata:SetScale( 1 )
effectdata:SetRadius( 16 )
util.Effect( "cball_bounce", effectdata )
self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)
end

function SWEP:SecondaryAttack()
self.Weapon:SendWeaponAnim( ACT_VM_FIDGET )

if SERVER then
if self.CanAlyxEmp == nil then
self.CanAlyxEmp = false
end

local trace = self.Owner:GetEyeTrace()

if trace == nil then return end
if trace.HitPos:Distance(self.Owner:GetShootPos()) >= 0 then
self.Owner:EmitSound( self.ShootSound )

if self.CanAlyxEmp == false then
trace.Entity:Fire("Lock","",0.1)
self.CanAlyxEmp = true
elseif self.CanAlyxEmp == true then
trace.Entity:Fire("UnLock","",0.1)
self.CanAlyxEmp = false
end
end
end

local trace = self.Owner:GetEyeTrace()

if !trace then return
end

local effectdata = EffectData()
effectdata:SetOrigin( trace.HitPos )
effectdata:SetNormal( trace.HitNormal )
effectdata:SetMagnitude( 8 )
effectdata:SetScale( 1 )
effectdata:SetRadius( 16 )
util.Effect( "cball_bounce", effectdata )
self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
end

function SWEP:Deploy()
self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
return true
end

function SWEP:ShouldDropOnDie()
return false
end

function SWEP:Holster()
return true
end