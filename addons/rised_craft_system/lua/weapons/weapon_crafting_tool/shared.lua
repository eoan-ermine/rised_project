-- "addons\\rised_craft_system\\lua\\weapons\\weapon_crafting_tool\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
    SWEP.Slot = 2
    SWEP.SlotPos = 10
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true
end

SWEP.PrintName = "Набор инструментов"

SWEP.Author = "D-Rised"
SWEP.Instructions = ""
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/props_c17/tools_wrench01a.mdl")
SWEP.WorldModel = Model("models/props_c17/tools_wrench01a.mdl")

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "A - Rised - [Крафт]"

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

function SWEP:PrimaryAttack()
	if SERVER then
		local craft = self:GetOwner():GetEyeTrace().Entity

		if craft:GetClass() == "crafting_item" then
			local progress = 0
			local plus = craft:GetNWInt("RisedCraft_Accuracy") - 50

			if (plus >= -50 and plus <= -35) or (plus >= 35 and plus <= 50) then
				progress = 5
			elseif (plus >= -30 and plus <= -20) or (plus >= 20 and plus <= 30) then
				progress = 10
			elseif (plus >= -15 and plus <= -5) or (plus >= 5 and plus <= 15) then
				progress = -25
			elseif plus == 0 then
				progress = 25
			end

			
			craft:SetNWInt("RisedCraft_Process", math.Clamp(craft:GetNWInt("RisedCraft_Process") + progress, 0, 100))
        	if craft:GetNWInt("RisedCraft_Process") >= 100 then
        		craft:Remove()

				local item = scripted_ents.Get(craft.CraftItem)
				local craft_ent = nil
				if !istable(item) then
					local weapon = weapons.GetStored(craft.CraftItem)
					craft_ent = ents.Create("spawned_weapon")
					local model = weapon.WorldModel or "models/weapons/w_rif_ak47.mdl"
					model = util.IsValidModel(model) and model or "models/weapons/w_rif_ak47.mdl"
	
					craft_ent:SetPos(craft:GetPos())
					craft_ent:SetAngles(craft:GetAngles())
					craft_ent:SetModel(model)
					craft_ent:SetWeaponClass(craft.CraftItem)
					craft_ent.nodupe = true
					craft_ent.clip1 = weapon.Clip1
					craft_ent.clip2 = weapon.Clip2
					craft_ent.ammoadd = ammo
					craft_ent.Weight = weapon.Weight
					craft_ent:Spawn()
					craft_ent:EmitSound("physics/metal/metal_solid_strain5.wav", 55)
				else
					craft_ent = ents.Create(craft.CraftItem)
					craft_ent:SetPos(craft:GetPos())
					craft_ent:SetAngles(craft:GetAngles())
					craft_ent:Spawn()
					craft_ent:EmitSound("physics/metal/metal_solid_strain5.wav", 55)
				end

        		timer.Simple(0.5, function()
        			if IsValid(craft_ent) then
	        			DarkRP.notify(self.Owner,1,5,"Вы изготовили "..craft_ent.PrintName)
	        			self.Owner:EmitSound("items/itempickup.wav", 75)
						self.Owner:Rised_ItemPickUp(craft_ent)
					end
        		end)
        	elseif craft:GetNWInt("RisedCraft_Process") >= 50 then
        		craft:EmitSound("phx/epicmetal_soft"..math.random(1,7)..".wav", 75)
        	elseif craft:GetNWInt("RisedCraft_Process") <= 0 then
	        	DarkRP.notify(self.Owner,1,5,"Вы сломали заготовку")
        		craft:Remove()
        		craft:EmitSound("phx/epicmetal_hard"..math.random(1,7)..".wav", 75)
        	else
        		craft:EmitSound("phx/epicmetal_hard"..math.random(1,7)..".wav", 75)
        	end
        end

        self:SetNextPrimaryFire(CurTime() + 1)
	end
end

function SWEP:SecondaryAttack()
end

if CLIENT then
	function SWEP:GetViewModelPosition(vPos, aAngles)
		vPos = vPos + LocalPlayer():GetUp() * -12
		vPos = vPos + LocalPlayer():GetAimVector() * 20
		vPos = vPos + LocalPlayer():GetRight() * 8
		aAngles:RotateAroundAxis(aAngles:Right(), 90)
		aAngles:RotateAroundAxis(aAngles:Forward(), 290)
		aAngles:RotateAroundAxis(aAngles:Up(), 300)
		
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

			local offset = HAng:Right() * 1 + HAng:Forward() * 3 + HAng:Up() * 1

			HAng:RotateAroundAxis(HAng:Right(), 200)
			HAng:RotateAroundAxis(HAng:Forward(),  90)
			HAng:RotateAroundAxis(HAng:Up(), 0)
			
			self:SetRenderOrigin(HPos + offset)
			self:SetRenderAngles(HAng)

			self:SetMaterial("models/props_c17/tools_wrench01a.mdl")
			self:DrawModel()
		end
	end

	function SWEP:DrawHUD()
		local craft = self:GetOwner():GetEyeTrace().Entity
		if craft:GetClass() != "crafting_item" then return end

	    local w = ScrW()
	    local h = ScrH()
	    local x, y, width, height = w / 2 - w / 10, h / 1.9, 400, h / 15
	    local time = self:GetEndCheckTime() - self:GetStartCheckTime()
	    local curtime = CurTime() - self:GetStartCheckTime()
	    local status = math.Clamp(curtime / time, 0, 1)
		local accuracy = craft:GetNWInt("RisedCraft_Accuracy") * width/100

	    draw.RoundedBox(4, x, y-1, 80, 4, Color(100, 100, 100, 200))
	    draw.RoundedBox(4, x + 80, y-1, 60, 4, Color(205, 205, 145, 200))
	    draw.RoundedBox(4, x + 200, y-1, 20, 4, Color(255, 255, 255, 200))
	    draw.RoundedBox(4, x + 280, y-1, 60, 4, Color(205, 205, 145, 200))
	    draw.RoundedBox(4, x + 340, y-1, 80, 4, Color(100, 100, 100, 200))

	    draw.RoundedBox(4, x + accuracy, y, 20, 2, Color(255, 255, 255, 255))
	    draw.DrawNonParsedSimpleText("Точность", "Trebuchet18", w / 2, y + height / 4, Color(255, 255, 255, 255), 1, 1)
	end
end 