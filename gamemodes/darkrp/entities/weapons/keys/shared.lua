-- "gamemodes\\darkrp\\entities\\weapons\\keys\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if SERVER then
    AddCSLuaFile("cl_menu.lua")
end

if CLIENT then
    SWEP.PrintName = "Keys"
    SWEP.Slot = 1
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false

    include("cl_menu.lua")
end

SWEP.Author = "DarkRP Developers"
SWEP.Instructions = "Left click to lock\nRight click to unlock\nReload for door settings or animation menu"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IsDarkRPKeys = true

SWEP.WorldModel = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix  = "rpg"

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "DarkRP (Utility)"
SWEP.Sound = "doors/door_latch3.wav"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.WepSelectFont		= "HL2MPTypeDeath"
SWEP.WepSelectLetter	= "K"

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( color_transparent )
	surface.SetTextColor( 255, 255, 255, alpha )
	surface.SetFont( self.WepSelectFont )
	local w, h = surface.GetTextSize( self.WepSelectLetter )

	surface.SetTextPos( x + ( wide / 2 ) - ( w / 2 ),
						y + ( tall / 2 ) - ( h / 2 ) )
	surface.DrawText( self.WepSelectLetter )
end

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    if CLIENT or not IsValid(self:GetOwner()) then return true end
    self:GetOwner():DrawWorldModel(false)
    return true
end

function SWEP:Holster()
    return true
end

function SWEP:PreDrawViewModel()
    return true
end

local function lookingAtLockable(ply, ent)
    local eyepos = ply:EyePos()
    return IsValid(ent)             and
        ent:isKeysOwnable()         and
        (
            ent:isDoor()    and eyepos:DistToSqr(ent:GetPos()) < 4225
            or
            ent:IsVehicle() and eyepos:DistToSqr(ent:NearestPoint(eyepos)) < 10000
        )

end

local function lockUnlockAnimation(ply, snd)
    ply:EmitSound("npc/metropolice/gear" .. math.floor(math.Rand(1,7)) .. ".wav")
    timer.Simple(0.9, function() if IsValid(ply) then ply:EmitSound(snd) end end)

    local RP = RecipientFilter()
    RP:AddAllPlayers()

    umsg.Start("anim_keys", RP)
        umsg.Entity(ply)
        umsg.String("usekeys")
    umsg.End()

    ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
end

local function doKnock(ply, sound)
    ply:EmitSound(sound, 100, math.random(90, 110))
    umsg.Start("anim_keys")
        umsg.Entity(ply)
        umsg.String("knocking")
    umsg.End()

    ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true)
end

function SWEP:PrimaryAttack()
    local trace = self:GetOwner():GetEyeTrace()

    if not lookingAtLockable(self:GetOwner(), trace.Entity) then return end

    self:SetNextPrimaryFire(CurTime() + 0.3)

    if CLIENT then return end
	
    if self:GetOwner():canKeysLock(trace.Entity) or (trace.Entity:getKeysDoorGroup() == "ГСР" && self.Owner:GetNWString("Player_WorkStatus") != "Безработный") then
        trace.Entity:keysLock() -- Lock the door immediately so it won't annoy people
        lockUnlockAnimation(self:GetOwner(), self.Sound)
    elseif trace.Entity:IsVehicle() then
        DarkRP.notify(self:GetOwner(), 1, 3, DarkRP.getPhrase("do_not_own_ent"))
    else
        doKnock(self:GetOwner(), "physics/wood/wood_crate_impact_hard2.wav")
    end
end

function SWEP:SecondaryAttack()
    local trace = self:GetOwner():GetEyeTrace()

    if not lookingAtLockable(self:GetOwner(), trace.Entity) then return end

    self:SetNextSecondaryFire(CurTime() + 0.3)

    if CLIENT then return end

    if self:GetOwner():canKeysUnlock(trace.Entity) or (trace.Entity:getKeysDoorGroup() == "ГСР" && self.Owner:GetNWString("Player_WorkStatus") != "Безработный") then
        trace.Entity:keysUnLock() -- Unlock the door immediately so it won't annoy people
        lockUnlockAnimation(self:GetOwner(), self.Sound)
    elseif trace.Entity:IsVehicle() then
        DarkRP.notify(self:GetOwner(), 1, 3, DarkRP.getPhrase("do_not_own_ent"))
    else
        doKnock(self:GetOwner(), "physics/wood/wood_crate_impact_hard3.wav")
    end
end

function SWEP:Reload()
    local trace = self:GetOwner():GetEyeTrace()
    if not IsValid(trace.Entity) or (((not trace.Entity:isDoor() and not trace.Entity:IsVehicle()) or self.Owner:EyePos():DistToSqr(trace.HitPos) > 40000)) then
        if CLIENT and not DarkRP.disabledDefaults["modules"]["animations"] then RunConsoleCommand("_DarkRP_AnimationMenu") end
        return
    end
    if SERVER then
        umsg.Start("KeysMenu", self:GetOwner())
        umsg.End()
    end
end
