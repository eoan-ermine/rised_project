-- "addons\\rised_weapons\\lua\\weapons\\swb_base\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()
AddCSLuaFile("sh_bullets.lua")
AddCSLuaFile("cl_model.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_calcview.lua")
AddCSLuaFile("sh_ammotypes.lua")
AddCSLuaFile("sh_move.lua")
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("cl_playerbindpress.lua")

include("sh_bullets.lua")
include("sh_ammotypes.lua")
include("sh_move.lua")
include("sh_sounds.lua")

game.AddParticles("particles/swb_muzzle.pcf")

PrecacheParticleSystem("swb_pistol_large")
PrecacheParticleSystem("swb_pistol_med")
PrecacheParticleSystem("swb_pistol_small")
PrecacheParticleSystem("swb_rifle_large")
PrecacheParticleSystem("swb_rifle_med")
PrecacheParticleSystem("swb_rifle_small")
PrecacheParticleSystem("swb_shotgun")
PrecacheParticleSystem("swb_silenced")
PrecacheParticleSystem("swb_silenced_small")
PrecacheParticleSystem("swb_sniper")

if CLIENT then
	include("cl_calcview.lua")
	include("cl_playerbindpress.lua")
	include("cl_model.lua")
	include("cl_hud.lua")
	
	SWEP.DrawCrosshair = false
	SWEP.BounceWeaponIcon = false
	SWEP.DrawWeaponInfoBox = false
	SWEP.CurFOVMod = 0
	SWEP.BobScale = 0
	SWEP.SwayScale = 0
	SWEP.ZoomAmount = 15
	SWEP.FadeCrosshairOnAim = true
	SWEP.DrawAmmo = false
	SWEP.DrawTraditionalWorldModel = true
	SWEP.CrosshairEnabled = false
	SWEP.ViewbobEnabled = true
	SWEP.ViewbobIntensity = 1
	SWEP.ReloadViewBobEnabled = false
	SWEP.RVBPitchMod = 1
	SWEP.RVBYawMod = 1
	SWEP.RVBRollMod = 1
	SWEP.BulletDisplay = 0
	SWEP.Shell = "mainshell"
	SWEP.ShellScale = 1
	SWEP.ZoomAmount = 15
	SWEP.CSMuzzleFlashes  = true
	SWEP.ZoomWait = 0
	SWEP.CrosshairParts = {left = true, right = true, upper = true, lower = true}
	SWEP.FireModeDisplayPos = "middle"
	SWEP.SwimPos = Vector(0, 0, -2.461)
	SWEP.SwimAng = Vector(-26.57, 0, 0)
end

SWEP.FadeCrosshairOnAim = true

if SERVER then
	SWEP.PlayBackRateSV = 1
end

SWEP.AimMobilitySpreadMod = 0.5
SWEP.PenMod = 1
SWEP.AmmoPerShot = 1
SWEP.SWBWeapon = true
SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 50
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= ""
SWEP.WorldModel		= ""
SWEP.AnimPrefix		= "fist"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= -1				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1				// Size of a clip
SWEP.Secondary.DefaultClip	= -1				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= true				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none"

SWEP.AddSpread = 0
SWEP.SpreadWait = 0
SWEP.AddSpreadSpeed = 1
SWEP.ReloadWait = 0
SWEP.PlayBackRateHip = 1
SWEP.PlayBackRate = 1
SWEP.ReloadSpeed = 1

SWEP.Chamberable = true
SWEP.UseHands = true
SWEP.CanPenetrate = true
SWEP.CanRicochet = true
SWEP.AddSafeMode = true
SWEP.Suppressable = false
SWEP.SprintingEnabled = true
SWEP.HolsterUnderwater = true
SWEP.HolsterOnLadder = true

SWEP.BurstCooldownMul = 1.75
SWEP.BurstSpreadIncMul = 0.5
SWEP.BurstRecoilMul = 0.85
SWEP.DeployTime = 1
SWEP.Shots = 1
SWEP.FromActionToNormalWait = 0
SWEP.ShotgunReloadState = 0
SWEP.RisedAimMuzzle = false
SWEP.AimSoundPlayed = false
SWEP.PreFireDelayCT = 0
SWEP.SimpleReloadSoundType = false

SWB_IDLE = 0
SWB_RUNNING = 1
SWB_AIMING = 2
SWB_ACTION = 3

SWEP.FireModeNames = {["auto"] = {display = "FULL-AUTO", auto = true, burstamt = 0, buldis = 5},
	["semi"] = {display = "SEMI-AUTO", auto = false, burstamt = 0, buldis = 1},
	["double"] = {display = "DOUBLE-ACTION", auto = false, burstamt = 0, buldis = 1},
	["bolt"] = {display = "BOLT-ACTION", auto = false, burstamt = 0, buldis = 1},
	["pump"] = {display = "PUMP-ACTION", auto = false, burstamt = 0, buldis = 1},
	["break"] = {display = "BREAK-ACTION", auto = false, burstamt = 0, buldis = 1},
	["2burst"] = {display = "2-ROUND BURST", auto = true, burstamt = 2, buldis = 2},
	["3burst"] = {display = "3-ROUND BURST", auto = true, burstamt = 3, buldis = 3},
	["safe"] = {display = "SAFE", auto = false, burstamt = 0, buldis = 0}}

local math = math

function SWEP:IsEquipment() -- I have no idea what I'm doing, help
	return WEPS.IsEquipment(self)
end

function SWEP:CalculateEffectiveRange()
	self.EffectiveRange = self.CaseLength * 10 - self.BulletDiameter * 5 -- setup realistic base effective range
	self.EffectiveRange = self.EffectiveRange * 39.37 -- convert meters to units
	self.EffectiveRange = self.EffectiveRange * 0.25
	self.DamageFallOff = (100 - (self.CaseLength - self.BulletDiameter)) / 200
	self.PenStr = (self.BulletDiameter * 0.5 + self.CaseLength * 0.35) * (self.PenAdd and self.PenAdd or 1)
	self.PenetrativeRange = self.EffectiveRange * 0.5
end

local tbl, tbl2

function SWEP:Initialize()

	self.Primary.ClipSize = RISED.Config.Weapons[self:GetClass()].ClipSize
	self.Recoil = RISED.Config.Weapons[self:GetClass()].Recoil
	self.Damage = RISED.Config.Weapons[self:GetClass()].Damage
	self.RPM = RISED.Config.Weapons[self:GetClass()].RPM
	self.HipSpread = RISED.Config.Weapons[self:GetClass()].HipSpread
	self.AimSpread = RISED.Config.Weapons[self:GetClass()].AimSpread
	self.VelocitySensitivity = RISED.Config.Weapons[self:GetClass()].VelocitySensitivity
	self.MaxSpreadInc = RISED.Config.Weapons[self:GetClass()].MaxSpreadInc
	self.SpreadPerShot = RISED.Config.Weapons[self:GetClass()].SpreadPerShot
	self.SpreadCooldown = RISED.Config.Weapons[self:GetClass()].SpreadCooldown
	self.Shots = RISED.Config.Weapons[self:GetClass()].Shots
	self.DeployTime = RISED.Config.Weapons[self:GetClass()].DeployTime
	self.Weight = RISED.Config.Weapons[self:GetClass()].Weight

	self:SetHoldType(self.NormalHoldType)
	self:CalculateEffectiveRange()
	self.CHoldType = self.NormalHoldType
	
	if self.AddSafeMode then
		table.insert(self.FireModes, #self.FireModes + 1, "safe")
	end
	
	t = self.FireModes[1]
	self.FireMode = t
	t = self.FireModeNames[t]
	
	self.Primary.Auto = t.auto
	self.BurstAmount = t.burstamt
	
	self.CurCone = self.HipSpread
	self.Primary.ClipSize_Orig = self.Primary.ClipSize
	
	if CLIENT then
		self.ViewModelFOV_Orig = self.ViewModelFOV
		self.BulletDisplay = t.buldis
		self.FireModeDisplay = t.display
		
		if self.WM then
			self.WMEnt = ClientsideModel(self.WM, RENDERGROUP_BOTH)
			self.WMEnt:SetNoDraw(true)
		end
	end
end

function SWEP:SetupDataTables()
	self:DTVar("Int", 0, "State")
	self:DTVar("Int", 1, "Shots")
	self:DTVar("Bool", 0, "Suppressed")
	self:DTVar("Bool", 1, "Safe")
end

local vm, CT, aim, cone, vel, CT, tr
local td = {}

function SWEP:Deploy()
	if self.dt.Suppressed then
		self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
	else
		self:SendWeaponAnim(ACT_VM_DRAW)
	end
	
	if !self:GetNWBool("SWB_FirstTimeDeploy") and self:GetClass() != "swb_pm" then
		self:SetNWBool("SWB_FirstTimeDeploy", true)
		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_ready" ) )
	end

	-- Изменение отдачи и разброса при стрельбе без навыка --
	if table.HasValue(supported_weapons_pistol, self:GetClass()) then

		local ply = self.Owner

		if ply:Team() != TEAM_REFUGEE and (GAMEMODE.CitizensJobs[ply:Team()] or GAMEMODE.LoyaltyJobs[ply:Team()]) then
			self.Recoil = 3
			self.MaxSpreadInc = 0.5
			self.SpreadPerShot = 0.02
		end
	
	elseif table.HasValue(supported_weapons_rifle, self:GetClass()) then

		local ply = self.Owner

		if ply:Team() != TEAM_REFUGEE and (GAMEMODE.CitizensJobs[ply:Team()] or GAMEMODE.LoyaltyJobs[ply:Team()] or GAMEMODE.CrimeJobs[ply:Team()] or ply:Team() == TEAM_REBELNEWBIE) then
			self.Recoil = 2
			self.MaxSpreadInc = 0.8
			self.SpreadPerShot = 0.04
		end

	end
			
	self.dt.State = SWB_IDLE
	CT = CurTime()

	if self.DeploySound then
		self:EmitSound(self.DeploySound)
	end

	self:SetNextSecondaryFire(CT + self.DeployTime)
	self:SetNextPrimaryFire(CT + self.DeployTime)
	return true
end

function SWEP:Holster()
	if self.ReloadDelay then
		return false
	end
	
	self.ShotgunReloadState = 0
	self.ReloadDelay = nil
	self.dt.State = SWB_IDLE
	return true
end

local mag

function SWEP:ReloadSound()
	if SERVER then
		self.Owner:EmitSound(self.Primary.Reload)
	elseif !GetConVar("rised_thirdpersonview_enable"):GetBool() and !self.SimpleReloadSoundType then
		timer.Simple(0.1, function() self.Owner:StopSound(self.Primary.Reload) end)
	end
end

hook.Add( "EntityEmitSound", "TimeWarpSounds", function( t )
	if t.Entity:IsPlayer() then
		if CLIENT and t.SoundName == ")weapons/smg1/smg1_reload.wav" then
			return false
		end
	end
end )

function SWEP:Reload()

	CT = CurTime()
	mag = self:Clip1()
	
	if self.ReloadDelay or CT < self.ReloadWait or self.dt.State == SWB_ACTION or self.ShotgunReloadState != 0 then
		return
	end
	
	if self.Owner:KeyDown(IN_USE) and self.dt.State != SWB_RUNNING then
		self:CycleFiremodes()
		return
	end
	
	if (self.Chamberable and mag >= self.Primary.ClipSize) or (not self.Chamberable and mag >= self.Primary.ClipSize) or self.Owner:GetAmmoCount(self.Primary.Ammo) == 0 then
		return
	end
	
	if self.dt.State != SWB_RUNNING then
		self.dt.State = SWB_IDLE
	end
	
	if self.ShotgunReload then
		self.ShotgunReloadState = 1
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		self.ReloadDelay = CT + 0.4
	else
		if self.Chamberable then
			if mag == 0 then
				self.Primary.ClipSize = self.Primary.ClipSize_Orig
			else
				self.Primary.ClipSize = self.Primary.ClipSize_Orig + 1
			end
		end
		
		if self.dt.Suppressed then
			self:DefaultReload(ACT_VM_RELOAD_SILENCED)
		end

		
		if self.ReloadType == "Normal" then
			if mag == 0 then
				self:DefaultReload(ACT_VM_RELOAD_EMPTY)
			else
				self:DefaultReload(ACT_VM_RELOAD)
			end
		elseif self.ReloadType == "Sniper" then
			self:DefaultReload(ACT_VM_RELOAD)
		elseif self.ReloadType == "Another" then
			if mag == 0 then
				local vm = self.Owner:GetViewModel()
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_reloadempty" ) )
				self:DefaultReload(ACT_VM_RELOAD)
			else
				local vm = self.Owner:GetViewModel()
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_reload" ) )
				self:DefaultReload(ACT_VM_RELOAD)
			end
		elseif self.ReloadType == "Another_NoEmptyAnimation" then
			local vm = self.Owner:GetViewModel()
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_reload" ) )
			self:DefaultReload(ACT_VM_RELOAD)
		elseif self.ReloadType == "Chey-Tac" then
			if mag == 0 then
				local vm = self.Owner:GetViewModel()
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_reloadempty" ) )
				self:DefaultReload(ACT_VM_RELOAD_EMPTY)
			else
				local vm = self.Owner:GetViewModel()
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_reload" ) )
				self:DefaultReload(ACT_VM_RELOAD)
			end
		end
	end
	
	--self:DefaultReload(ACT_VM_RELOAD)
	
	self:ReloadSound()
	--[[self:SendWeaponAnim(ACT_VM_RELOAD)
	
	vm = self.Owner:GetViewModel() 
	vm:SetPlaybackRate(self.ReloadSpeed)
	dur = vm:SequenceDuration() / self.ReloadSpeed
	
	self.ReloadDelay = CT + dur]]--
	--self:SetNextPrimaryFire(CT + dur)
	--self:SetNextSecondaryFire(CT + dur)
end

function SWEP:CycleFiremodes()
	t = self.FireModes
	
	if not t.last then
		t.last = 2
	else
		if not t[t.last + 1] then
			t.last = 1
		else
			t.last = t.last + 1
		end
	end
	
	if self.dt.State == SWB_AIMING then
		if self.FireModes[t.last] == "safe" then
			t.last = 1
		end
	end
	
	if self.FireMode != self.FireModes[t.last] and self.FireModes[t.last] then
		CT = CurTime()
		self:SelectFiremode(self.FireModes[t.last])
		self:SetNextPrimaryFire(CT + 0.25)
		self:SetNextSecondaryFire(CT + 0.25)
		self.ReloadWait = CT + 0.25
	end
end

function SWEP:SelectFiremode(n)
	if CLIENT then
		return
	end
	
	t = self.FireModeNames[n]
	self.Primary.Automatic = t.auto
	self.FireMode = n
	self.BurstAmount = t.burstamt
	
	if self.FireMode == "safe" then
		self.dt.Safe = true -- more reliable than umsgs
	else
		self.dt.Safe = false
	end
	
	umsg.Start("SWB_FIREMODE")
		umsg.Entity(self.Owner)
		umsg.String(n)
	umsg.End()
end

local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local GetAimVector = reg.Player.GetAimVector

function SWEP:CalculateSpread(vel)
	aim = GetAimVector(self.Owner)
	CT = CurTime()
	
	if not self.Owner.LastView then
		self.Owner.LastView = aim
		self.Owner.ViewAff = 0
	else
		self.Owner.ViewAff = Lerp(0.25, self.Owner.ViewAff, (aim - self.Owner.LastView):Length() * 0.5)
		self.Owner.LastView = aim
	end
	
	if self.dt.State == SWB_AIMING then
		self.BaseCone = self.AimSpread
		
		if self.Owner.Expertise then
			self.BaseCone = self.BaseCone * (1 - self.Owner.Expertise["steadyaim"].val * 0.0015)
		end
	else
		self.BaseCone = self.HipSpread
		
		if self.Owner.Expertise then
			self.BaseCone = self.BaseCone * (1 - self.Owner.Expertise["wepprof"].val * 0.0015)
		end
	end
	
	if self.Owner:Crouching() then
		self.BaseCone = self.BaseCone * (self.dt.State == SWB_AIMING and 0.9 or 0.75)
	end
	
	self.CurCone = math.Clamp(self.BaseCone + self.AddSpread + (vel / 10000 * self.VelocitySensitivity) * (self.dt.State == SWB_AIMING and self.AimMobilitySpreadMod or 1) + self.Owner.ViewAff, 0, 0.09 + self.MaxSpreadInc)
	
	if CT > self.SpreadWait then
		self.AddSpread = math.Clamp(self.AddSpread - 0.005 * self.AddSpreadSpeed, 0, self.MaxSpreadInc)
		self.AddSpreadSpeed = math.Clamp(self.AddSpreadSpeed + 0.05, 0, 1)
	end
end

local SP = game.SinglePlayer()

local mag, ammo

function SWEP:IndividualThink()
	if (SP and SERVER) or not SP then
		if self.dt.State == SWB_AIMING then
			if not self.Owner:OnGround() or Length(GetVelocity(self.Owner)) >= self.Owner:GetWalkSpeed() * 1.35 or not self.Owner:KeyDown(IN_ATTACK2) then
				CT = CurTime()
				self.dt.State = SWB_IDLE
				self:SetNextSecondaryFire(CT + 0.2)
			end
		end
	end
end

local IFTP
local wl, ws

function SWEP:Think()

	if self.IndividualThink then
		self:IndividualThink()
	end
	
	if (not IsValid(self.Owner)) then return end
	
	vel = Length(GetVelocity(self.Owner))
	IFTP = IsFirstTimePredicted()
	
	if (not SP and IFTP) or SP then
		self:CalculateSpread(vel)
	end
	
	CT = CurTime()
	wl = self.Owner:WaterLevel()
	
	if self.Owner:OnGround() then
		if wl >= 3 and self.HolsterUnderwater then
			if self.ShotgunReloadState == 1 then
				self.ShotgunReloadState = 2
			end
			self.dt.State = SWB_ACTION
			self.FromActionToNormalWait = CT + 0.3
		else
			ws = self.Owner:GetWalkSpeed()
			
			if ((vel > ws * 1.2 and self.Owner:KeyDown(IN_SPEED)) or vel > ws * 3 or (self.ForceRunStateVelocity and vel > self.ForceRunStateVelocity)) and self.SprintingEnabled then
				self.dt.State = SWB_RUNNING
			else
				if self.dt.State != SWB_AIMING then
					if CT > self.FromActionToNormalWait then
						if self.dt.State != SWB_IDLE then
							self.dt.State = SWB_IDLE
						--	self:SetNextPrimaryFire(CT + 0.3)
							self:SetNextSecondaryFire(CT + 0.3)
							self.ReloadWait = CT + 0.3
						end
					end
				end
			end
		end
	else
		if (wl > 1 and self.HolsterUnderwater) or (self.Owner:GetMoveType() == MOVETYPE_LADDER and self.HolsterOnLadder) then
			if self.ShotgunReloadState == 1 then
				self.ShotgunReloadState = 2
			end
			
			self.dt.State = SWB_ACTION
			self.FromActionToNormalWait = CT + 0.3
		else
			if CT > self.FromActionToNormalWait then
				if self.dt.State != SWB_IDLE then
					self.dt.State = SWB_IDLE
					self:SetNextPrimaryFire(CT + 0.3)
					self:SetNextSecondaryFire(CT + 0.3)
					self.ReloadWait = CT + 0.3
				end
			end
		end
	end

	if IFTP then
		if self.ShotgunReloadState == 1 then
			if self.Owner:KeyPressed(IN_ATTACK) then
				self.ShotgunReloadState = 2
			end
			
			if CT > self.ReloadDelay then
				if SERVER then
					self:SendWeaponAnim(ACT_VM_RELOAD)
				end
				
				mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)
				
				if SERVER then
					self:SetClip1(mag + 1)
					self.Owner:SetAmmo(ammo - 1, self.Primary.Ammo)
				end

				self.ReloadDelay = CT + self.ReloadShellInsertWait
				
				if mag + 1 == self.Primary.ClipSize or ammo - 1 == 0 then
					self.ShotgunReloadState = 2
				end
			end
		elseif self.ShotgunReloadState == 2 then
			if CT > self.ReloadDelay then
				self.Owner:SetAnimation(PLAYER_RELOAD)
				if SERVER then
					if self:GetClass() == "swb_mosin" then
						self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
					else
						self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
					end
				end

				timer.Simple(0.3, function() self.Owner:EmitSound("weapons/toz-194m/toz_194m_pumpback.wav") end)
				
				self.ShotgunReloadState = 0
				self:SetNextPrimaryFire(CT + self.ReloadFinishWait)
				self:SetNextSecondaryFire(CT + self.ReloadFinishWait)
				self.ReloadWait = CT + self.ReloadFinishWait
				self.ReloadDelay = nil
			end
		end
	end
	
	if SERVER then
		if self.dt.Safe then
			if self.CHoldType != self.RunHoldType then
				self:SetHoldType(self.RunHoldType)
				self.CHoldType = self.RunHoldType
			end
			if self.Owner:GetNWBool("Angry") != false then
				self.Owner:SetNWBool("Angry", false)
			end
		else
			if self.dt.State == SWB_RUNNING or self.dt.State == SWB_ACTION then
				if self.CHoldType != self.RunHoldType then
					self:SetHoldType(self.RunHoldType)
					self.CHoldType = self.RunHoldType
				end
			else
				if self.CHoldType != self.NormalHoldType then
					self:SetHoldType(self.NormalHoldType)
					self.CHoldType = self.NormalHoldType
				end
			end
			if self.Owner:GetNWBool("Angry") != true then
				self.Owner:SetNWBool("Angry", true)
			end
		end
	end
end

local mul

function SWEP:FinishAttack()
end

hook.Add( "KeyRelease", "PrimaryFireRelease", function( ply, key )
    if ( key == IN_ATTACK ) then
		timer.Simple(0.1, function()
       		ply:SetNWBool("Player_Key_Attack", false)
		end)
    end
end )

function SWEP:PrimaryAttack()

	if self.ShotgunReloadState != 0 then
		return
	end
	
	if self.ReloadDelay then
		return
	end
	
	if self.dt.Safe then
		self:CycleFiremodes()
		return
	end
	
	if self.PreFireDelay and self:Clip1() > 0 then
		if !self.Owner:GetNWBool("Player_Key_Attack") then
			self:EmitSound(self.PreFireSound)
			self.PreFireDelayCT = CurTime() + self.PreFireDelay
			self.Owner:SetNWBool("Player_Key_Attack", true)
			self:SetNextPrimaryFire(CurTime() + self.PreFireDelay)
		end
		if CurTime() < self.PreFireDelayCT then
			return
		end
	end
	
	mag = self:Clip1()
	--mag = 100
	
	if mag == 0 then
		self:EmitSound("SWB_Empty", 100, 100)
		self:SetNextPrimaryFire(CT + 0.25)
		return
	end
	
	if self.dt.State == SWB_RUNNING or self.dt.State == SWB_ACTION then
		return
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	CT = CurTime()
	
	if self.dt.Suppressed then
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
	else
		--self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end
	
	if self.FireAnimFunc then
		self:FireAnimFunc()
	else
		if self.dt.State == SWB_AIMING then
			if mag - self.AmmoPerShot <= 0 and self.DryFire then
				if self.dt.Suppressed then
					self:SendWeaponAnim(ACT_VM_DRYFIRE_SILENCED)
				else
					self:SendWeaponAnim(ACT_VM_DRYFIRE)
				end
			else
				if self.dt.Suppressed then
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
				else
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
				end
			end
			
			if self.FadeCrosshairOnAim then
				if SP then
					if SERVER then
						self.Owner:GetViewModel():SetPlaybackRate(self.PlayBackRate or 1)
					end
				else
					if SERVER then
						self.Owner:GetViewModel():SetPlaybackRate(self.PlayBackRateSV or 1)
					else
						self.Owner:GetViewModel():SetPlaybackRate(self.PlayBackRate or 1)
					end
				end
			end
			
			local vm = self.Owner:GetViewModel()
			if vm:LookupSequence( "iron_fire_a" ) != -1 then
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "iron_fire_a" ) )
			end
			if vm:LookupSequence( "iron_fire" ) != -1 then
				self.Owner:GetViewModel():SendViewModelMatchingSequence( self.Owner:GetViewModel():LookupSequence( "iron_fire" ) )
			end
			if self:GetClass() == "swb_tt" or self:GetClass() == "swb_gsh18" or self:GetClass() == "swb_deagle" or self:GetClass() == "swb_mp5a5" then
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_fire" ) )
			end
			if self:GetClass() == "swb_mosin" or self:GetClass() == "swb_pm" then
				self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_2)
			elseif self:GetClass() == "swb_mp5k" then
				self:SendWeaponAnim(ACT_VM_DRYFIRE)
			end
		else
			local vm = self.Owner:GetViewModel()
			if vm:LookupSequence( "iron_fire_a" ) != -1 then
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_fire" ) )
			end
			
			if mag - self.AmmoPerShot <= 0 and self.DryFire then
				if self.dt.Suppressed then
					self:SendWeaponAnim(ACT_VM_DRYFIRE_SILENCED)
				else
					self:SendWeaponAnim(ACT_VM_DRYFIRE)
				end
			else
				if self.dt.Suppressed then
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
				else
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
				end
			end
			
			if self.FadeCrosshairOnAim then
				self.Owner:GetViewModel():SetPlaybackRate(self.PlayBackRateHip or 1)
			end
		end
	end
	
	if IsFirstTimePredicted() then
		if self.dt.Suppressed then
			self:EmitSound(self.FireSoundSuppressed, 105, 100)
		else
			self:EmitSound(self.FireSound, 100, 100)
		end
		self:FireBullet(self.Damage * (self.dt.Suppressed and 0.9 or 1), self.CurCone, self.Shots * (self.BurstAmount > 0 && self.BurstAmount || 1))
		self:MakeRecoil()
		
		self.SpreadWait = CT + self.SpreadCooldown
		mul = 1
	
		if self.Owner:Crouching() then
			mul = mul * 0.75
		end
		
		if self.Owner.Expertise then
			mul = mul * (1 - self.Owner.Expertise["wepprof"].val * 0.002)
			
			if SERVER then
				if self.dt.State == SWB_AIMING then
					self.Owner:ProgressStat("steadyaim", self.Recoil * 1.5)
					self.Owner:ProgressStat("wepprof", self.Recoil * 0.5)
				else
					self.Owner:ProgressStat("wepprof", self.Recoil * 1.5)
				end
				
				self.Owner:ProgressStat("rechandle", self.Recoil)
			end
		end
		
		if self.BurstAmount > 0 then
			self.AddSpread = math.Clamp(self.AddSpread + self.SpreadPerShot * self.BurstSpreadIncMul * mul, 0, self.MaxSpreadInc)
		else
			self.AddSpread = math.Clamp(self.AddSpread + self.SpreadPerShot * mul, 0, self.MaxSpreadInc)
		end

		self.AddSpreadSpeed = math.Clamp(self.AddSpreadSpeed - 0.2, 0, 1)
		
		if CLIENT then
			if self.dt.State == SWB_AIMING then
				self.FireMove = 1
			else
				self.FireMove = 0.4
			end
		end
		self:MuzzleEffectStart()
		
		self:FinishAttack()
	end
	
	self:TakePrimaryAmmo(self.AmmoPerShot)
	self:SetNextPrimaryFire(CT + self.FireDelay)
	self:SetNextSecondaryFire(CT + self.FireDelay)
	self.ReloadWait = CT + (self.WaitForReloadAfterFiring and self.WaitForReloadAfterFiring or self.FireDelay)
end

function SWEP:MuzzleEffectStart()

end

local ang

function SWEP:MakeRecoil(mod)
	mod = mod and mod or 1
	
	if self.Owner:Crouching() then
		mod = mod * 0.75
	end
	
	if self.dt.State == SWB_AIMING then
		mod = mod * 0.85
	end
	
	if self.dt.Suppressed then
		mod = mod * 0.85
	end
	
	if self.BurstAmount > 0 then
		mod = mod * self.BurstRecoilMul
	end
	
	if self.Owner.Expertise then
		mod = mod * (1 - self.Owner.Expertise["rechandle"].val * 0.0015)
	end
	
	if (SP and SERVER) or (not SP and CLIENT) then
		ang = self.Owner:EyeAngles()
		ang.p = ang.p - self.Recoil * 0.5 * mod
		ang.y = ang.y + math.random(-1, 1) * self.Recoil * 0.5 * mod
	
		self.Owner:SetEyeAngles(ang)
	end
	
	self.Owner:ViewPunch(Angle(-self.Recoil * 1.25 * mod, 0, 0))
end

function SWEP:SecondaryAttack()
	if self.ShotgunReloadState != 0 then
		return
	end
	
	if self.ReloadDelay then
		return
	end
	
	if self.dt.Safe then
		self:CycleFiremodes()
		return
	end
	
	if self.dt.State == SWB_RUNNING or self.dt.State == SWB_ACTION or self.dt.State == SWB_AIMING then
		return
	end
	
	if self.Suppressable and self.Owner:KeyDown(IN_USE) then
		self:ToggleSuppressor()
		return
	end
	
	if not self.Owner:OnGround() or Length(GetVelocity(self.Owner)) >= self.Owner:GetWalkSpeed() * 1.2 then
		return
	end
	
	if self.AimSound and !self.AimSoundPlayed then
		self.AimSoundPlayed = true
		self:EmitSound(self.AimSound)
		timer.Simple(0.5, function() self.AimSoundPlayed = false end)
	end
	
	CT = CurTime()
	
	self.dt.State = SWB_AIMING

	if IsFirstTimePredicted() then
		self.AimTime = UnPredictedCurTime() + 0.2
		
		if self.PreventQuickScoping then
			self.AddSpread = math.Clamp(self.AddSpread + 0.03, 0, self.MaxSpreadInc)
			self.SpreadWait = CT + 0.3
		end
	end
	
	self:SetNextSecondaryFire(CT + 0.1)
end

function SWEP:ToggleSuppressor()
	if self.dt.Suppressed then
		self:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
	else
		self:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
	end
	
	vm = self.Owner:GetViewModel()
	dur = vm:SequenceDuration()
	CT = CurTime()
	
	self:SetNextPrimaryFire(CT + dur)
	self:SetNextSecondaryFire(CT + dur)
	self.ReloadWait = CT + dur
	self.dt.Suppressed = ! self.dt.Suppressed
end

function SWEP:Equip()
end

if CLIENT then
	local EP, EA2, FT
	
	function SWEP:ViewModelDrawn()
		EP, EA2, FT = EyePos(), EyeAngles(), FrameTime()
		
		if IsValid(self.Hands) then
			self.Hands:SetRenderOrigin(EP)
			self.Hands:SetRenderAngles(EA2)
			self.Hands:FrameAdvance(FT)
			self.Hands:SetupBones()
			self.Hands:SetParent(self.Owner:GetViewModel())
			self.Hands:DrawModel()
		end
	end
	
	local wm, pos, ang
	local GetBonePosition = debug.getregistry().Entity.GetBonePosition
	
	local ply, wep
	
	local function GetRecoil()
		ply = LocalPlayer()
		
		if not ply:Alive() then
			return
		end
		
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.SWBWeapon then
			CT = CurTime()
			wep.SpreadWait = CT + wep.SpreadCooldown
			
			mul = 1
		
			if ply:Crouching() then
				mul = mul * 0.75
			end
			
			if ply.Expertise then
				mul = mul * (1 - ply.Expertise["wepprof"].val * 0.002)
			end
			
			if wep.BurstAmount > 0 then
				wep.AddSpread = math.Clamp(wep.AddSpread + wep.SpreadPerShot * wep.BurstSpreadIncMul * mul, 0, wep.MaxSpreadInc)
			else
				wep.AddSpread = math.Clamp(wep.AddSpread + wep.SpreadPerShot * mul, 0, wep.MaxSpreadInc)
			end
			
			wep.AddSpreadSpeed = math.Clamp(wep.AddSpreadSpeed - 0.2, 0, 1)
			
			if wep.dt.State == SWB_AIMING then
				wep.FireMove = 1
			else
				wep.FireMove = 0.4
			end
		end
	end
	
	usermessage.Hook("SWB_Recoil", GetRecoil)
	
	local function AimTime()
		ply = LocalPlayer()
		
		if not ply:Alive() then
			return
		end
		
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.SWBWeapon then
			wep.AimTime = UnPredictedCurTime() + 0.25
			
			if wep.PreventQuickScoping then
				wep.AddSpread = math.Clamp(wep.AddSpread + 0.03, 0, wep.MaxSpreadInc)
				wep.SpreadWait = CurTime() + 0.3
			end
		end
	end
	
	usermessage.Hook("SWB_AimTime", AimTime)

	local function SWB_ReceiveFireMode(um)
		ply = um:ReadEntity()
		Mode = um:ReadString()
		
		if IsValid(ply) then
			wep = ply:GetActiveWeapon()
			wep.FireMode = Mode
			
			if IsValid(ply) and IsValid(wep) and wep.SWBWeapon then
				if wep.FireModeNames then
					t = wep.FireModeNames[Mode]
					
					wep.Primary.Automatic = t.auto
					wep.BurstAmount = t.burstamt
					wep.FireModeDisplay = t.display
					wep.BulletDisplay = t.buldis
					wep.CheckTime = CurTime() + 2
					
					if ply == LocalPlayer() then
						ply:EmitSound("weapons/smg1/switch_single.wav", 70, math.random(92, 112))
					end
				end
			end
		end
	end

	usermessage.Hook("SWB_FIREMODE", SWB_ReceiveFireMode)
end

ccf = ccf or {}

local rigmdl = Model("models/weapons/tfa_ins2/c_ins2_pmhands.mdl")

local weaponsWithHands = {
	"swb_ak74",
	"swb_asval",
	"swb_mosin",
	"swb_gsh18",
	"swb_sawedoff",
	"swb_pm",
	"swb_rpk",
	"swb_tt",
	"swb_sks",
	"swb_toz",
	"swb_m60",
	"swb_mp5a5",
}

local function tryParentHands(hands, vm, ply, wep) -- hey look no more drawmodel

	if !IsValid(vm) or !IsValid(wep) or !table.HasValue(weaponsWithHands, wep:GetClass()) then
		if IsValid(ccf.HandsEnt) then
			ccf.HandsEnt:RemoveEffects(EF_BONEMERGE)
			ccf.HandsEnt:RemoveEffects(EF_BONEMERGE_FASTCULL)
			ccf.HandsEnt:SetParent(NULL)

			ccf.HandsEnt:Remove()
		end

		return
	end

	if !IsValid(hands) then return end -- Hi Gmod Can Hands ????
	
	if not IsValid(ccf.HandsEnt) then
		ccf.HandsEnt = ClientsideModel(rigmdl)
	end

	local handsent = ccf.HandsEnt
	
	if wep.UseHands and vm:LookupBone("R ForeTwist") and not vm:LookupBone("ValveBiped.Bip01_R_Hand") then -- assuming we are ins2 only skeleton
		handsent:SetParent(vm)
		handsent:SetPos(vm:GetPos())
		handsent:SetAngles(vm:GetAngles())

		if not handsent:IsEffectActive(EF_BONEMERGE) then
			handsent:AddEffects(EF_BONEMERGE)
			handsent:AddEffects(EF_BONEMERGE_FASTCULL)
		end

		hands:SetParent(handsent)
	end
end

hook.Add("PreDrawPlayerHands", "HandsWhatTheFuck", tryParentHands)