-- "addons\\darkrpmodification\\lua\\weapons\\weapon_stalkerisation\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Сталкеризатор"
    SWEP.Slot = 2
    SWEP.SlotPos = 10
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true
end

-- Variables that are used on both client and server

SWEP.Author = "D-Rised"
SWEP.Instructions = ""
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/gibs/scanner_gib04.mdl")
SWEP.WorldModel = Model("models/gibs/scanner_gib04.mdl")

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "A - Rised - [Альянс]"

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

--[[-------------------------------------------------------
Name: SWEP:PrimaryAttack()
Desc: +attack1 has been pressed
---------------------------------------------------------]]

local x = 0
function SWEP:PrimaryAttack()
	if SERVER then
		if self:GetIsWeaponChecking() then return end
		self:SetNextSecondaryFire(CurTime() + 0.3)

		self:GetOwner():LagCompensation(true)
		local trace = self:GetOwner():GetEyeTrace()
		self:GetOwner():LagCompensation(false)

		local ent = trace.Entity
		
		if not IsValid(ent) or ent:GetPos():DistToSqr(self:GetOwner():GetPos()) > 35000 then
			return
		end
		
		if not IsValid(ent:GetDriver()) then return end
		if ent:GetDriver():GetModel() == "models/beta stalker/beta_stalker.mdl" then return end
		if ent:GetClass() != "prop_vehicle_prisoner_pod" then return end
		
		if ent:GetDriver():IsPlayer() then
			if GAMEMODE.AnimalJobs[ent:GetDriver():Team()] then return end
			
			ent:GetDriver():Lock()
		
			if CurTime() <= self.Owner:GetNWInt("Entity_Timer", 0) then 
				DarkRP.notify(self.Owner, 0, 7, "Восстановление заряда, осталось: ".. math.Round(self.Owner:GetNWInt("Entity_Timer", 0) - CurTime()))
				return
			end
			
			self:SetIsWeaponChecking(true)
			self:SetStartCheckTime(CurTime())
			self:SetEndCheckTime(CurTime() + 45)
			self:SetTotalWeaponChecks(self:GetTotalWeaponChecks() + 1)

			self:SetNextSoundTime(CurTime() + 1)

			if CLIENT then
				self.Dots = ""
				self.NextDotsTime = CurTime() + 0.5
			end
		end
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

		local trEntity = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(trEntity:GetPos());
		
		if trEntity:GetClass() != "prop_vehicle_prisoner_pod" then return end
   		if Distance > 100 then return false end
		
		trEntity:GetDriver():SetModel("models/beta stalker/beta_stalker.mdl")
		trEntity:GetDriver():EmitSound("npc/stalker/breathing3.wav")
		trEntity:GetDriver():StripWeapons()
		
		timer.Simple(1, function()

			if trEntity:GetDriver():IsPlayer() then
				local stalker = trEntity:GetDriver()
				
				trEntity:GetDriver():UnLock()
				trEntity:GetDriver():ExitVehicle()
				
				if stalker:GetNWBool("rhc_cuffed", false) then
					stalker:RHCRestrain(self.Owner)
				end
				
				stalker:changeTeam(TEAM_STALKER, true)
				stalker:ScreenFade(SCREENFADE.IN, color_black, 10, 3)
				
				AddTaskExperience(self.Owner, "Сталкеризация")
				
				timer.Simple(1, function() stalker:PrintMessage( HUD_PRINTCENTER, "Ваше тело подверглось тяжелым техно-биологическим изменениям..." ) end)
				timer.Simple(2, function() stalker:PrintMessage( HUD_PRINTCENTER, "Ваше тело подверглось тяжелым техно-биологическим изменениям..." ) end)
				timer.Simple(3, function() stalker:PrintMessage( HUD_PRINTCENTER, "Ваше тело подверглось тяжелым техно-биологическим изменениям..." ) end)
				timer.Simple(4, function() stalker:PrintMessage( HUD_PRINTCENTER, "Ваше тело подверглось тяжелым техно-биологическим изменениям..." ) end)
				timer.Simple(5, function() stalker:PrintMessage( HUD_PRINTCENTER, "Ваше тело подверглось тяжелым техно-биологическим изменениям..." ) end)
				timer.Simple(6, function() stalker:PrintMessage( HUD_PRINTCENTER, "Ваше тело подверглось тяжелым техно-биологическим изменениям..." ) end)
			end
			
		end)
		
		self.Owner:SetNWInt("Entity_Timer", CurTime() + 35)
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
			if not IsValid(trace.Entity) or trace.HitPos:DistToSqr(self:GetOwner():GetShootPos()) > 35000 or trace.Entity:GetClass() != "prop_vehicle_prisoner_pod" then
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
				trace.Entity:GetDriver():ScreenFade(SCREENFADE.IN, Color( 255, 0, 0, 255 ), 0.8, 0)
				if trace.Entity:GetDriver():isCP() then
					trace.Entity:GetDriver():EmitSound("npc/metropolice/pain"..math.random(1,4)..".wav")
				else
					for k, v in pairs( GAMEMODE.MaleModels ) do
						if trace.Entity:GetDriver():GetModel()== v then
							trace.Entity:GetDriver():EmitSound("vo/npc/male01/pain0"..math.random(1,9)..".wav")
						end
					end
		
					for q, w in pairs( GAMEMODE.FemaleModels ) do
						if trace.Entity:GetDriver():GetModel() == w then
							trace.Entity:GetDriver():EmitSound("vo/npc/female01/pain0"..math.random(1,9)..".wav")
						end
					end
				end
			else
				self:SetNextSoundTime(0)
				trace.Entity:GetDriver():ScreenFade(SCREENFADE.IN, Color( 255, 0, 0, 255 ), 0.8, 0)
				if trace.Entity:GetDriver():isCP() then
					trace.Entity:GetDriver():EmitSound("npc/metropolice/pain"..math.random(1,4)..".wav")
				else
					for k, v in pairs( GAMEMODE.MaleModels ) do
						if trace.Entity:GetDriver():GetModel()== v then
							trace.Entity:GetDriver():EmitSound("vo/npc/male01/pain0"..math.random(1,9)..".wav")
						end
					end
		
					for q, w in pairs( GAMEMODE.FemaleModels ) do
						if trace.Entity:GetDriver():GetModel() == w then
							trace.Entity:GetDriver():EmitSound("vo/npc/female01/pain0"..math.random(1,9)..".wav")
						end
					end
				end
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
        draw.DrawNonParsedSimpleText("Сталкеризация" .. self.Dots, "Trebuchet18", w / 2, y + height / 4, Color(255, 195, 87, 255), 1, 1)
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

		self:SetMaterial("models/gibs/scanner_gib04.mdl")
		self:DrawModel()
	end
end

end 