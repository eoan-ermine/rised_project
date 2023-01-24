-- "addons\\rised_ration\\lua\\weapons\\weapon_ration5\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
    AddCSLuaFile("shared.lua")
end

SWEP.PrintName = "Рацион питания"
SWEP.Author = "D-Rised"
SWEP.Slot = 4
SWEP.SlotPos = 10
SWEP.Description = "Искусственная пища."
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Левый клик - съесть"
SWEP.HoldType			= "normal"
SWEP.AnimPrefix = "normal"

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "A - Rised - [Другое]"

SWEP.ViewModel = "models/weapons/w_packatc.mdl"
SWEP.WorldModel = "models/weapons/w_packatc.mdl"
SWEP.UseHands = true

SWEP.Primary.Recoil = 0
SWEP.Primary.ClipSize  = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic  = true
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Recoil = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Delay = 1
SWEP.Secondary.Ammo = "none"

SWEP.WepSelectFont		= "HL2MPTypeDeath"
SWEP.WepSelectLetter	= "R"
SWEP.Weight = 0.5

function SWEP:Initialize()
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( color_transparent )
	surface.SetTextColor( 255, 255, 255, alpha )
	surface.SetFont( self.WepSelectFont )
	local w, h = surface.GetTextSize( self.WepSelectLetter )

	surface.SetTextPos( x + ( wide / 2 ) - ( w / 2 ),
						y + ( tall / 2 ) - ( h / 2 ) )
	surface.DrawText( self.WepSelectLetter )
end

function SWEP:PrimaryAttack()
	if SERVER then
		if self.Owner:getDarkRPVar("Energy") > 50 then
			self.Owner:setDarkRPVar("Energy", self.Owner:getDarkRPVar("Energy") - 25)
		end
			
		-- Настроение --
		hook.Call("playerMoodChanged", GAMEMODE, self.Owner, -20)
		
		self.Owner:TakeDamage(15)
		util.ScreenShake( Vector( 0, 0, 0 ), 5, 50, 5, 5 )
		bool = false
			
		local ent = ents.Create("rrs_emptyfood")
		ent:SetPos(self.Owner:EyePos() + self.Owner:GetAimVector() * 30)
		ent:Spawn()
		self.Owner:SelectWeapon("re_hands")
		self:Remove()
	end
    self:EmitSound("ambient/levels/canals/toxic_slime_gurgle4.wav", 50, 100, 1, CHAN_AUTO)
    self:EmitSound("ambient/levels/canals/toxic_slime_gurgle6.wav", 40, 100, 1, CHAN_AUTO)
	
	self:SetNextPrimaryFire(CurTime()+5)
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end

if CLIENT then
function SWEP:GetViewModelPosition(vPos, aAngles)
	vPos = vPos + LocalPlayer():GetUp() * -5	
	vPos = vPos + LocalPlayer():GetAimVector() * 30
	vPos = vPos + LocalPlayer():GetRight() * 8
	aAngles:RotateAroundAxis(aAngles:Right(), 50)
	aAngles:RotateAroundAxis(aAngles:Forward(), 0)
	aAngles:RotateAroundAxis(aAngles:Up(), 180)
	
	return vPos, aAngles
end

function SWEP:OnRemove()
	if !IsValid(LocalPlayer()) or !IsValid(self.Owner) then return end
    local Viewmodel = self.Owner:GetViewModel()

	if IsValid(Viewmodel) then
		Viewmodel:SetMaterial("")
	end
end

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.5 + HAng:Forward() * 7 + HAng:Up() * 0.518

		HAng:RotateAroundAxis(HAng:Right(), 10)
		HAng:RotateAroundAxis(HAng:Forward(),  90)
		HAng:RotateAroundAxis(HAng:Up(), 80)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:SetMaterial("models/weapons/w_packatc.mdl")
		self:DrawModel()
	end
end

end
