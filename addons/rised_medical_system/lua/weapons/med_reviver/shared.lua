-- "addons\\rised_medical_system\\lua\\weapons\\med_reviver\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

if CLIENT then
SWEP.PrintName			= "Реаниматор"			
SWEP.Slot				= 3
SWEP.SlotPos			= 19
SWEP.DrawCrosshair		= false
end

SWEP.Author = "D-Rised";
SWEP.Contact = "";
SWEP.Instructions	= "Левый клик - оживить."
SWEP.Category = "A - Rised - [Медицина]"

SWEP.ViewModel		= "models/props_combine/combine_emitter01.mdl"
SWEP.WorldModel		= "models/props_combine/combine_emitter01.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "normal"
SWEP.AnimPrefix			= "normal"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	self:SetHoldType( "normal" )
	self.NextDotsTime = 0
end

function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsWeaponChecking")
    self:NetworkVar("Float", 0, "StartCheckTime")
    self:NetworkVar("Float", 1, "EndCheckTime")
    self:NetworkVar("Float", 2, "NextSoundTime")
    self:NetworkVar("Int", 0, "TotalWeaponChecks")
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
		local trEntity = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(trEntity:GetPos());
		
   		if Distance > 100 then return false end			
		
		if !trEntity:GetNWEntity('EDS.Victim'):IsPlayer() then return end
		if GAMEMODE.CombineJobs[trEntity:GetNWEntity('EDS.Victim'):Team()] then return end
		if GAMEMODE.ZombieJobs[trEntity:GetNWEntity('EDS.Victim'):Team()] then return end
		
		if CurTime() <= self.Owner:GetNWInt("Entity_Timer_Revive", 0) then 
			DarkRP.notify(self.Owner, 0, 7, "Восстановление заряда, осталось: ".. math.Round(self.Owner:GetNWInt("Entity_Timer_Revive", 0) - CurTime()))
			return
		end
	
		self:SetIsWeaponChecking(true)
		self:SetStartCheckTime(CurTime())
		self:SetEndCheckTime(CurTime() + 25)
		self:SetTotalWeaponChecks(self:GetTotalWeaponChecks() + 1)

		self:SetNextSoundTime(CurTime() + 1)

		if CLIENT then
			self.Dots = ""
			self.NextDotsTime = CurTime() + 0.5
		end
	end
end

function SWEP:Holster()
    self:SetIsWeaponChecking(false)
    self:SetNextSoundTime(0)
    return true
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
			if not IsValid(trace.Entity) or trace.HitPos:DistToSqr(self:GetOwner():GetShootPos()) > 10000 or !trace.Entity:GetNWEntity('EDS.Victim'):IsPlayer() then
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
				trace.Entity:EmitSound("npc/scanner/combat_scan5.wav", 100)
			else
				self:SetNextSoundTime(0)
				trace.Entity:EmitSound("npc/scanner/combat_scan5.wav", 100)
			end
		end
		
		if self.Owner:GetNWInt("Entity_Timer_Revive", 0) > 0 and CurTime() <= self:GetNextSoundTime() then 
			self.Owner:SetNWInt("Entity_Timer_Revive", self.Owner:GetNWInt("Entity_Timer_Revive") - 1)
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
        local x, y, width, height = w / 2 - w / 10, h / 1.7, w / 5, h / 15
        local time = self:GetEndCheckTime() - self:GetStartCheckTime()
        local curtime = CurTime() - self:GetStartCheckTime()
        local status = math.Clamp(curtime / time, 0, 1)
        local BarWidth = status * (width - 16)
        local cornerRadius = math.Min(8, BarWidth / 3 * 2 - BarWidth / 3 * 2 % 2)
		
        draw.RoundedBox(4, x, y, width - 4, 2, Color(0, 0, 0, 150))
        draw.RoundedBox(4, x, y, BarWidth, 2, Color(255, 195, 87, 255))
        draw.DrawNonParsedSimpleText("Реанимация" .. self.Dots, "Trebuchet18", w / 2, y + height / 4, Color(255, 195, 87, 255), 1, 1)
    end
end

function SWEP:SecondaryAttack()
    self:PrimaryAttack()
end

function SWEP:Succeed()
	if SERVER then
		if not IsValid(self:GetOwner()) then return end
		self:SetIsWeaponChecking(false)

		local trace = self:GetOwner():GetEyeTrace()
		local trEntity = trace.Entity
		
		self.Owner:SetNWInt("Entity_Timer_Revive", CurTime() + 180)
		
		if trEntity:GetNWEntity('EDS.Victim'):IsPlayer() then
			local ply = trEntity:GetNWEntity('EDS.Victim')
			local rnd = math.random(1,100)
			if ply:Alive() or rnd > 30 then
				DarkRP.notify(self.Owner, 0, 7, "Реанимация невозможна!")
				return
			end
			self.Owner:EmitSound("ambient/energy/spark"..math.random(1,6)..".wav")
			local pos, ang = trEntity:GetPos(), trEntity:EyeAngles()
			
			ply:SetNWBool("PlyDontLoseJobe", true)
			ply:Spawn()
			ply:UnLock()
			ply:SetPos(pos)
			ply:SetEyeAngles(ang)
			
			self.Owner:CombineRankChanged("Revive")
			
			trEntity:Remove()
			timer.Simple(5, function()
				ply:SetNWBool("PlyDontLoseJobe", false)
			end)
			ply:SetHealth(1)
		end
	end
end

if CLIENT then
function SWEP:GetViewModelPosition(vPos, aAngles)
	vPos = vPos + LocalPlayer():GetUp() * -10
	vPos = vPos + LocalPlayer():GetAimVector() * 30
	vPos = vPos + LocalPlayer():GetRight() * 12
	aAngles:RotateAroundAxis(aAngles:Right(), 0)
	aAngles:RotateAroundAxis(aAngles:Forward(), 0)
	aAngles:RotateAroundAxis(aAngles:Up(), 0)
	
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

		local offset = HAng:Right() * 2 + HAng:Forward() * 20 + HAng:Up() * -5
		
		HAng:RotateAroundAxis(HAng:Right(), 90)
		HAng:RotateAroundAxis(HAng:Forward(),  0)
		HAng:RotateAroundAxis(HAng:Up(), 180)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)
		
		self:SetMaterial("models/props_combine/combine_emitter01.mdl")
		self:DrawModel()
	end
end

end
