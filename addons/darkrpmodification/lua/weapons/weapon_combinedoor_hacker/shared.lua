-- "addons\\darkrpmodification\\lua\\weapons\\weapon_combinedoor_hacker\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
    SWEP.Slot = 2
    SWEP.SlotPos = 10
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true
end

-- Variables that are used on both client and server

SWEP.PrintName = "Хактул"
SWEP.Author = "D-Rised"
SWEP.Instructions = ""
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/weapons/v_emptool.mdl")
SWEP.WorldModel = Model("models/weapons/w_emptool.mdl")

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "A - Rised - [Повстанцы]"

SWEP.Sound = Sound("physics/wood/wood_box_impact_hard3.wav")

SWEP.Primary.ClipSize = -1      -- Size of a clip
SWEP.Primary.DefaultClip = 0        -- Default number of bullets in a clip
SWEP.Primary.Automatic = false      -- Automatic/Semi Auto
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1        -- Size of a clip
SWEP.Secondary.DefaultClip = -1     -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false        -- Automatic/Semi Auto
SWEP.Secondary.Ammo = "none"

--[[-------------------------------------------------------
Name: SWEP:Initialize()
Desc: Called when the weapon is first loaded
---------------------------------------------------------]]

SWEP.WepSelectFont		= "HL2MPTypeDeath"
SWEP.WepSelectLetter	= "H"
SWEP.Weight = 0.5

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( color_transparent )
	surface.SetTextColor( 75, 75, 75, alpha )
	surface.SetFont( self.WepSelectFont )
	local w, h = surface.GetTextSize( self.WepSelectLetter )

	surface.SetTextPos( x + ( wide / 2 ) - ( w / 2 ),
						y + ( tall / 2 ) - ( h / 2 ) )
	surface.DrawText( self.WepSelectLetter )
end

function SWEP:Initialize()
    self:SetHoldType("slam")
	self.NextDotsTime = 0
end


function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsWeaponChecking")
    self:NetworkVar("Float", 0, "StartCheckTime")
    self:NetworkVar("Float", 1, "EndCheckTime")
    self:NetworkVar("Float", 2, "NextSoundTime")
    self:NetworkVar("Int", 0, "TotalWeaponChecks")
end

--[[-------------------------------------------------------
Name: SWEP:PrimaryAttack()
Desc: +attack1 has been pressed
---------------------------------------------------------]]

local x = 0
function SWEP:PrimaryAttack()
	if self:GetIsWeaponChecking() then return end
    self:SetNextSecondaryFire(CurTime() + 0.3)

    self:GetOwner():LagCompensation(true)
    local trace = self:GetOwner():GetEyeTrace()
    self:GetOwner():LagCompensation(false)

    local ent = trace.Entity
	
    if not IsValid(ent) or ent:GetPos():DistToSqr(self:GetOwner():GetPos()) > 35000 then
        return
    end
	
	if ent:GetClass() != "rised_forcefield" then return end
	if !ent:GetDTBool(0) then return end
	
	if CurTime() <= self.Owner:GetNWInt("Entity_Timer", 0) then 
		DarkRP.notify(self.Owner, 0, 7, "Восстановление заряда, осталось: ".. math.Round(self.Owner:GetNWInt("Entity_Timer", 0) - CurTime()))
		return
	end
	
    self:SetIsWeaponChecking(true)
    self:SetStartCheckTime(CurTime())
    self:SetEndCheckTime(CurTime() + 30)
    self:SetTotalWeaponChecks(self:GetTotalWeaponChecks() + 1)

    self:SetNextSoundTime(CurTime() + 1)

    if CLIENT then
        self.Dots = ""
        self.NextDotsTime = CurTime() + 0.5
    end
end

function SWEP:Holster()
    self:SetIsWeaponChecking(false)
    self:SetNextSoundTime(0)
    return true
end

function SWEP:Succeed()
	if SERVER then
		if not IsValid(self:GetOwner()) then return end
		self:SetIsWeaponChecking(false)

		local trace = self:GetOwner():GetEyeTrace()
		local ent = trace.Entity
		
		if not IsValid(ent) then return end
		if ent:GetClass() != "rised_forcefield" then return end
		
		if ent:GetDTBool(0) then
			net.Start("callcpnetwork")
			net.WriteEntity(self.Owner)
			net.WriteInt(3,10)
			net.Broadcast()
		end

		ent:SetDTBool(0, !ent:GetDTBool(0))
		ent:Toggle(ent:GetDTBool(0))

		AddTaskExperience(self.Owner, "Взломать силовое поле")
		
		self.Owner:SetNWInt("Entity_Timer", CurTime() + 300)
	end
end

function SWEP:Fail()
    self:SetIsWeaponChecking(false)
    self:SetHoldType("normal")
    self:SetNextSoundTime(0)
end

function SWEP:Think()
	if SERVER then
		if self:GetIsWeaponChecking() and self:GetEndCheckTime() ~= 0 then
			self:GetOwner():LagCompensation(true)
			local trace = self:GetOwner():GetEyeTrace()
			self:GetOwner():LagCompensation(false)
			if not IsValid(trace.Entity) or trace.HitPos:DistToSqr(self:GetOwner():GetShootPos()) > 35000 or trace.Entity:GetClass() != "rised_forcefield" then
				self:Fail()
			end
			if self:GetEndCheckTime() <= CurTime() then
				self:Succeed()
			end
		end
		if self:GetNextSoundTime() ~= 0 and CurTime() >= self:GetNextSoundTime() then
			self:GetOwner():LagCompensation(true)
			local trace = self:GetOwner():GetEyeTrace()
			self:GetOwner():LagCompensation(false)
			if self:GetIsWeaponChecking() then
				self:SetNextSoundTime(CurTime() + 1)
				trace.Entity:EmitSound("npc/scanner/combat_scan5.wav", 55)
			else
				self:SetNextSoundTime(0)
				trace.Entity:EmitSound("npc/scanner/combat_scan5.wav", 55)
			end
		end
		
		if self.Owner:GetNWInt("Entity_Timer", 0) > 0 and CurTime() <= self:GetNextSoundTime() then 
			self.Owner:SetNWInt("Entity_Timer", self.Owner:GetNWInt("Entity_Timer") - 1)
		end
	end
	
    if CLIENT and self.NextDotsTime and CurTime() >= self.NextDotsTime then
        self.NextDotsTime = CurTime() + 0.5
        self.Dots = self.Dots or ""
        local len = string.len(self.Dots)
        local dots = {
            [0] = ".",
            [1] = "..",
            [2] = "...",
            [3] = ""
        }
        self.Dots = dots[len]
    end
end

function SWEP:DrawHUD()
    if self:GetIsWeaponChecking() and self:GetEndCheckTime() ~= 0 then
        self.Dots = self.Dots or ""
        local w = ScrW()
        local h = ScrH()
        local x, y, width, height = w / 2 - w / 10, h / 1.9, w / 5, h / 15
        local time = self:GetEndCheckTime() - self:GetStartCheckTime()
        local curtime = CurTime() - self:GetStartCheckTime()
        local status = math.Clamp(curtime / time, 0, 1)
        local BarWidth = status * (width - 16)
        local cornerRadius = math.Min(8, BarWidth / 3 * 2 - BarWidth / 3 * 2 % 2)
		
        draw.RoundedBox(4, x, y, width - 4, 2, Color(0, 0, 0, 150))
        draw.RoundedBox(4, x, y, BarWidth, 2, Color(255, 195, 87, 255))
        draw.DrawNonParsedSimpleText("Взлом" .. self.Dots, "Trebuchet18", w / 2, y + height / 4, Color(255, 195, 87, 255), 1, 1)
    end
end

function SWEP:SecondaryAttack()
    self:PrimaryAttack()
end