-- "addons\\darkrpmodification\\lua\\weapons\\weapon_spy\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if SERVER then
    --AddCSLuaFile("cl_menu.lua")
end

if CLIENT then
    SWEP.PrintName = "Маскировка"
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
    --include("cl_menu.lua")
end

SWEP.Author = "D-Rised"
SWEP.Instructions = "Левая кнопка - маскировка\nПравая кнопка - снять маскировку"
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
SWEP.Category = "A - Rised - [Другое]"
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
SWEP.WepSelectLetter	= "M"

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( color_transparent )
	surface.SetTextColor( 100, 0, 0, alpha )
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
local finish = 0
function SWEP:PrimaryAttack()
	
	finish = 0

	timer.Create("wearCombine", 0.7, 5, function()
		
		if IsValid(self) then
			finish = finish + 1
		
			if finish == 2 then
				if self.Owner:Team() == TEAM_REBELSPY02 then
					if self.Owner:GetModel() == "models/player/group03/female_02.mdl" then
						self.Owner:SetModel("models/player/group01/female_02.mdl")
					elseif self.Owner:GetModel() == "models/player/group03/female_04.mdl" then
						self.Owner:SetModel("models/player/group01/female_04.mdl")
					elseif self.Owner:GetModel() == "models/player/group03/male_02.mdl" then
						self.Owner:SetModel("models/player/group01/male_02.mdl")
					elseif self.Owner:GetModel() == "models/player/group03/male_03.mdl" then
						self.Owner:SetModel("models/player/group01/male_03.mdl")
					elseif self.Owner:GetModel() == "models/player/group03/male_05.mdl" then
						self.Owner:SetModel("models/player/group01/male_05.mdl")
					elseif self.Owner:GetModel() == "models/player/group03/male_07.mdl" then
						self.Owner:SetModel("models/player/group01/male_07.mdl")
					end
					self.Owner:EmitSound( "physics/body/body_medium_impact_soft"..math.random(1,7)..".wav")
				elseif self.Owner:Team() == TEAM_REBELSPY01 then
					self.Owner:SetModel("models/dpfilms/metropolice/playermodels/pm_hl2concept.mdl")
					self.Owner:EmitSound( "npc/metropolice/gear"..math.random(1,6)..".wav")
				end
			else
				self.Owner:EmitSound( "physics/body/body_medium_impact_soft"..math.random(1,7)..".wav")
			end
		end
	end)
end

function SWEP:SecondaryAttack()
	finish = 0

	timer.Create("wearCombine", 0.7, 2, function()
		if IsValid(self) then
			finish = finish + 1
		
			if finish == 2 then
			
				if self.Owner:Team() == TEAM_REBELSPY02 then
					if self.Owner:GetModel() == "models/player/group01/female_02.mdl" then
						self.Owner:SetModel("models/player/group03/female_02.mdl")
					elseif self.Owner:GetModel() == "models/player/group01/female_04.mdl" then
						self.Owner:SetModel("models/player/group03/female_04.mdl")
					elseif self.Owner:GetModel() == "models/player/group01/male_02.mdl" then
						self.Owner:SetModel("models/player/group03/male_02.mdl")
					elseif self.Owner:GetModel() == "models/player/group01/male_03.mdl" then
						self.Owner:SetModel("models/player/group03/male_03.mdl")
					elseif self.Owner:GetModel() == "models/player/group01/male_05.mdl" then
						self.Owner:SetModel("models/player/group03/male_05.mdl")
					elseif self.Owner:GetModel() == "models/player/group01/male_07.mdl" then
						self.Owner:SetModel("models/player/group03/male_07.mdl")
					end
					self.Owner:EmitSound( "physics/body/body_medium_impact_soft"..math.random(1,7)..".wav")
				elseif self.Owner:Team() == TEAM_REBELSPY01 then
					self.Owner:SetModel("models/dpfilms/metropolice/playermodels/pm_hd_barney.mdl")
					self.Owner:EmitSound( "npc/metropolice/gear"..math.random(1,6)..".wav")
				end
			else
				self.Owner:EmitSound( "physics/body/body_medium_impact_soft"..math.random(1,7)..".wav")
			end
		end
	end)
end

function SWEP:Reload()

end
