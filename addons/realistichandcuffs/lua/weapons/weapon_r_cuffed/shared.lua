-- "addons\\realistichandcuffs\\lua\\weapons\\weapon_r_cuffed\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Cuffed"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "ToBadForYou"
SWEP.Instructions = ""
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.HoldType = "passive";
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "passive"
SWEP.Category = "ToBadForYou"
SWEP.UID = 76561198208634281

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize() self:SetHoldType("passive") end
function SWEP:CanPrimaryAttack() return false; end
function SWEP:SecondaryAttack() return false; end

function SWEP:PreDrawViewModel(vm)
    return true
end

function SWEP:DrawWorldModel()
end

function SWEP:PrimaryAttack()
	if SERVER then
		if self.Owner:GetNWBool("rhc_cuffed") == true && self.Owner:GetNWBool("rhc_haslockpick") == true then
			self.Owner:SetNWBool("rhc_haslockpick", false)
			DarkRP.notify(self.Owner,2,7,"Вы освободились с помощью отмычки (отмычка сломалась).")
			self.Owner:RHCRestrain(self.Owner)
		end
	end
end

if CLIENT then
local LangTbl = RHandcuffsConfig.Language[RHandcuffsConfig.LanguageToUse]
function SWEP:DrawHUD()
    draw.SimpleTextOutlined(LangTbl.CuffedText,"Trebuchet24",ScrW()/2,ScrH()/12,Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM,2,Color(0,0,0,255))
end
end