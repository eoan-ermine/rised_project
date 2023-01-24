-- "addons\\rised_medical_system\\lua\\weapons\\weapon_medical_scanner\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

if CLIENT then
SWEP.PrintName			= "Медицинский сканер"			
SWEP.Slot				= 2
SWEP.SlotPos			= 19
SWEP.DrawCrosshair		= false
end

SWEP.Author		= "D-Rised"
SWEP.Contact		= ""
SWEP.Purpose		= "Левый клик - анализ человека./nПравый клик - анализ себя."
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/Items/HealthKit.mdl"
SWEP.WorldModel		= "models/Items/HealthKit.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "normal"
SWEP.AnimPrefix = "normal"
SWEP.UID = 76561198130530705

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.Category = "A - Rised - [Медицина]"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.WepSelectFont		= "HL2MPTypeDeath"
SWEP.WepSelectLetter	= "L."

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
	self:SetHoldType( "normal" )
end

function SWEP:Holster()
	if CLIENT then
		if IsValid(LocalPlayer()) then
   	   		local Viewmodel = LocalPlayer():GetViewModel()

			if IsValid(Viewmodel) then
				Viewmodel:SetMaterial("")
			end
		end
	end
	return true
end

function SWEP:PrimaryAttack()
	if SERVER then
		local ply = self.Owner
		local trEntity = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(trEntity:GetPos());
		
   		if Distance > 100 then return false end
		
		if trEntity:IsPlayer() then
		
			ply:ChatPrint("Сканирование...")
			
			timer.Simple(2, function()
			
				-- Analyse --
				timer.Simple(0.2, function()
					ply:ChatPrint("Пациент: " .. trEntity:Nick())
				end)
				
				timer.Simple(0.4, function()
					if trEntity:GetNWInt("LegFracture") == 1 then
						ply:ChatPrint("Состояние конечностей:   Сломаны ноги")
					else
						ply:ChatPrint("Состояние конечностей:   Без патологии")
					end
				end)
				
				
				timer.Simple(0.6, function()
					if trEntity:GetNWString("MedicineDisease_02") == "" then
						ply:ChatPrint("Психоэмоциональный статус:   Без патологии")
					else
						ply:ChatPrint("Психоэмоциональный статус:   " .. trEntity:GetNWString("MedicineDisease_02", "Без патологии"))
					end
				end)
				

				timer.Simple(0.8, function()
					if trEntity:GetNWInt("Bleeding") == 1 then
						ply:ChatPrint("Целостность кожных покровов:   Открытое кровотечение")
					else
						ply:ChatPrint("Целостность кожных покровов:   Без патологии")
					end
				end)
				

				timer.Simple(1, function()
					if trEntity:GetNWString("MedicineDisease_01", "") != "" then
						ply:ChatPrint("Характеристика всех органов и систем:   " .. trEntity:GetNWString("MedicineDisease_01", ""))

						---=== Добавление записи в историю персонажа ===---
						local char = trEntity:GetVar("CharacterCreatorIdSaveLoad")
						local steamid = trEntity:SteamID()
						local lastRecord = GetCitizenLastRecord(steamid, char)

						local recordTime = os.date("%d/%m/%Y", os.time())
						local record = {
							["Дата"] = recordTime,
							["Тип записи"] = "Медицинские данные",
							["Текст"] = ply:Name() .. " обнаружил болезнь: " .. trEntity:GetNWString("MedicineDisease_01", ""),
							["Цвет"] = Color(175,175,175,255),
							["Мета"] = trEntity:GetNWString("MedicineDisease_01", ""),
						}
						if !istable(lastRecord) then
							AddRecordToCitizenHistory(steamid, char, record)
						else
							if lastRecord["Мета"] != trEntity:GetNWString("MedicineDisease_01", "") then
								AddRecordToCitizenHistory(steamid, char, record)
							end
						end
					else
						ply:ChatPrint("Характеристика всех органов и систем:   Без патологии")
					end
				end)
				
			
			end)
		
		elseif trEntity:GetClass() == "hospital_npc_patient" then

			ply:ChatPrint("Сканирование...")
			
			timer.Simple(2, function()
			
				-- Analyse --
				timer.Simple(0.2, function()
					ply:ChatPrint("Пациент: " .. trEntity.RPName)
				end)
				
				timer.Simple(0.4, function()
					ply:ChatPrint("Состояние конечностей:   Без патологии")
				end)
				
				
				timer.Simple(0.6, function()
					ply:ChatPrint("Психоэмоциональный статус:   Без патологии")
				end)
				

				timer.Simple(0.8, function()
					ply:ChatPrint("Целостность кожных покровов:   Без патологии")
				end)
				

				timer.Simple(1, function()
					if trEntity.Sick then
						ply:ChatPrint("Характеристика всех органов и систем:   " .. trEntity.Disease)
					else
						ply:ChatPrint("Характеристика всех органов и систем:   Без патологии")
					end
				end)
				
			
			end)
		end
		
		self:SetNextPrimaryFire(CurTime() + 1.5)
	end
end

function SWEP:SecondaryAttack()
end

if CLIENT then
function SWEP:GetViewModelPosition(vPos, aAngles)
	vPos = vPos + LocalPlayer():GetUp() * -10
	vPos = vPos + LocalPlayer():GetAimVector() * 20
	vPos = vPos + LocalPlayer():GetRight() * 8
	aAngles:RotateAroundAxis(aAngles:Right(), 90)
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

		self:SetMaterial("models/Items/HealthKit.mdl")
		self:DrawModel()
	end
end

end
