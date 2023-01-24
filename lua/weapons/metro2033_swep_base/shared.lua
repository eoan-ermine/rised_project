-- "lua\\weapons\\metro2033_swep_base\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
	/*	
	
				METRO 2033 SWEP BASE 
				 CYKA BLYAT EDITION
		
*/

SWEP.Base = "weapon_base"

SWEP.AdminSpawnable = true

SWEP.AutoSwitchTo = false
SWEP.Slot = 2
SWEP.PrintName = "BASE!"
SWEP.Author = "Hobo_Gus"
SWEP.Spawnable = false
SWEP.AutoSwitchFrom = false
SWEP.Weight = 5
SWEP.DrawCrosshair = false

SWEP.CustomCrosshair = false

SWEP.Category = "Metro 2033"
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.QuadAmmoCounter = false
SWEP.AmmoQuadColor = Color(84,196,247,255)
SWEP.Instructions = "Use it as base"
SWEP.Contact = "Hobo_Gus in Steam"
SWEP.Purpose = "BRUTAL LUA RAPE"
SWEP.HoldType = "smg"
SWEP.ViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.LaserSight = false
SWEP.HitmarkerSound = false
SWEP.IronsightTime = 0.17

SWEP.DisableMuzzle = 0
SWEP.LuaShells = false
SWEP.ShellName = "hg_rifle_shell"

SWEP.DamageType = nil

SWEP.Crosshair = true

SWEP.DefSwayScale 	= 1.0
SWEP.DefBobScale 	= 1.0

SWEP.ViewModelBoneMods = {
}

SWEP.MaxDist = 45

SWEP.PrimarySound = Sound("weapons/ar1/ar1_dist2.wav")
SWEP.ReloadSound = Sound("common/null.wav")

SWEP.Primary.Damage = 11
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 45
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 154
SWEP.Primary.Spread = 1
SWEP.Primary.Cone = 0.3
SWEP.IronCone = 0.05
SWEP.DefaultCone = 0.3
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Delay = 0.10
SWEP.Primary.Force = 3

//1 - AR2, 2 - Air Boat Gun, 3 - Tool tracer, 4 - Gauss tracer, 5 - Gunship tracer, 6 - Default, 7 - Tool tracer 2.
//След пули. Какой он может быть смотри выше
SWEP.Tracer = 6
SWEP.CustomTracerName = "Tracer"
SWEP.ShotEffect = "muzzle_riflev2"

SWEP.UseShotEffect = true

SWEP.Sprint = false
SWEP.SniperScope = false

SWEP.SprintMul = 3

SWEP.RunPos = Vector(5, -7, -2)
SWEP.RunAng = Vector(0, 40, -10)

SWEP.SightBreath = true
SWEP.SightBreathMul = 1

SWEP.InfinityBreathHolding = true
SWEP.BreathHoldingTime = 10

SWEP.RTScope = false
SWEP.RTScopeType = "def"
SWEP.RTScopeReticle = "reticles/reticle2"
SWEP.RTScopeReticleSize = 80

SWEP.CanSwitchAmmo = true

SWEP.AdvancedNPCAiming = false

SWEP.WallPos = Vector(-1.407, -10.252, -7.035)
SWEP.WallAng = Vector(50.652, 5.627, -3.518)

SWEP.CoverPos = Vector(-3.016, 0, 2.009)
SWEP.CoverAng = Vector(11.255, 5.627, -63.318) 

SWEP.IronSights = true

SWEP.IronSightsPos = Vector(-7.56, 0, -0.04)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.MarkerOpacity = 0

SWEP.IronSightFOV = 14

SWEP.MoveMul = 0.4
SWEP.RecoilMul = 0.03

local rndr = render
local mth = math
local srface = surface
local inpat = input

function SWEP:TimedPunch( time, ang )
local ply = self.Owner
local wep = self.Weapon
	timer.Simple(time, function()
		if wep == nil then return end
		ply:ViewPunch( ang )
	end)
end

function SWEP:SafeTimer( time, func )
local ply = self.Owner
local wep = self.Weapon
	timer.Simple(time, function()
		if wep == nil then return end
		func()
	end)	
end

function SWEP:Deploy()
self:OnDeploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self:SetHoldType( self.HoldType )	
	self.Primary.Cone = self.DefaultCone
	if SERVER then
		self.Weapon:SetNWInt("Reloading", CurTime() + self:SequenceDuration() )
	end
	self.Weapon:SetNWString( "AniamtionName", "none" )
	self.Weapon:SetNWString( "PreventNearWall", false )
	--self.Owner:SetNWInt( "breathholdtime_hg", self.BreathHoldingTime )
	self.Weapon:SetNWBool("money_mode", false)
	self.Weapon:SetNWInt("temp_mag", self:Clip1())
	self.Owner:SetNWInt("reloading_hold", 0)
	return true
end

function SWEP:OnDeploy()

end

function SWEP:ServThink()
end

local nxtbreathdown = 0

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {} 
 
	self.AmmoDisplay.Draw = self.DrawAmmo 
 
	if self.Primary.ClipSize > 0 then
		self.AmmoDisplay.PrimaryClip = self:Clip1() 
		self.AmmoDisplay.PrimaryAmmo = self:Ammo1() 
	end
	if self.Secondary.ClipSize > 0 then
		self.AmmoDisplay.SecondaryClip = self:Clip2()
		self.AmmoDisplay.SecondaryAmmo = self:Ammo2()
	end
 
	return self.AmmoDisplay
end

function SWEP:SecondThink()
end

function SWEP:PrimaryCall()//Если надо что-то приписать к выстрелу, но не нужен весь код
end

function SWEP:ServPrimaryCall()//Если надо что-то приписать к выстрелу, но не нужен весь код
end

function SWEP:PrimaryAttack()
	if (self.Weapon:GetNWInt("temp_mag") <= 0 ) then return end
	if self.Weapon:GetNWInt("Reloading") > CurTime() then return end
	if self:Clip1() <= 0 then return end
local ply = self.Owner
local wep = self.Weapon
	self:PrimaryCall()
	
	if SERVER then
		self:ServPrimaryCall()
	end
	
	local rnda = (self.Primary.Recoil/2)
	local rndb = (self.Primary.Recoil/2) * mth.random(-1, 1)
	
	if !ply:IsNPC() then
			wep:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
				ply:LagCompensation(true)
					self:ShootBulletInfo()
				ply:LagCompensation(false)
			if SERVER then
				ply:EmitSound(self.PrimarySound)
				ply:ViewPunch( Angle( -rnda,rndb,rndb ) )
			end
	end
	
	if SERVER then
		wep:SetNWFloat( "LastShootTime", CurTime() + self.Primary.Delay )
		wep:SetNWFloat( "RecoilMultiplier", wep:GetNWFloat( "RecoilMultiplier" ) + self.RecoilMul )
	end
	
	self:ShootEffects()
	
	if IsFirstTimePredicted() then
		if ply:IsNPC() and self.LuaShells == true then
				local fx = EffectData()
				fx:SetEntity(self.Weapon)
				fx:SetOrigin(self.Owner:GetShootPos())
				fx:SetNormal(self.Owner:GetAimVector())
				fx:SetAttachment(2)
				util.Effect(self.ShellName, fx)	
		end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )	
		local fx 		= EffectData()
		fx:SetEntity(wep)
		fx:SetOrigin(ply:GetShootPos())
		fx:SetNormal(ply:GetAimVector())
		fx:SetAttachment("1")
		if self.UseShotEffect == true then
			util.Effect( self.ShotEffect ,fx)
		end
	end
	
	--if self.Weapon:GetNWBool("money_mode") == false then
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
--	elseif self.Weapon:GetNWBool("money_mode") == true then
		if self.Weapon:GetNWBool("money_mode") == true and self.Owner:getDarkRPVar("money") > 0 then
			if SERVER then
				self.Owner:addMoney(-1)
				self.Weapon:SetNWInt("temp_mag", self.Weapon:GetNWInt("temp_mag") - 1)
			end
		end
	--end

	    if !ply:IsNPC() and ( (game.SinglePlayer() and SERVER) or ( !game.SinglePlayer() and CLIENT and IsFirstTimePredicted() ) ) then
                local shotang = self.Owner:EyeAngles()
				if self:GetNWBool("Ironsights") then
					shotang.pitch = shotang.pitch - self.Primary.Recoil/2
					local hrz_rec = self.Primary.Recoil/2.2
					shotang.yaw = shotang.yaw - math.random( -hrz_rec, hrz_rec )
				else
					shotang.pitch = shotang.pitch - self.Primary.Recoil/0.9
					local hrz_rec = self.Primary.Recoil/1.5
					shotang.yaw = shotang.yaw - math.random( -hrz_rec, hrz_rec )
				end
                ply:SetEyeAngles( shotang )
				self.Weapon:SetNWInt("recoil_fov", self.Primary.Recoil*1.7)
        end
		
end

function SWEP:ShootEffects()

	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 	
	self.Owner:MuzzleFlash()						

end

function SWEP:NPCShoot_Primary( ShootPos, ShootDir )
	if ( !self:CanPrimaryAttack() ) then return end
	if self.Weapon:Clip1() <= 0 then self:Reload() end
	
	if self.Weapon:GetNextPrimaryFire() < CurTime() then
		self:PrimaryAttack()
	end
end

SWEP.Secondary.Ammo = "none"

SWEP.VElements = {
}
SWEP.WElements = {
	
}
	
function SWEP:Equip()
	self:SetHoldType(self.HoldType)
end	
	
function SWEP:OnRestore()

	self.NextSecondaryAttack = 0
	
end

function SWEP:ReloadFunc()

end

function SWEP:ReloadFinished()

end

function SWEP:DefaultReloading()
	self.Owner:SetNWInt("reloading_hold", 0)
	if self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) <= 0 then return end
	
	self.Weapon:DefaultReload( ACT_VM_RELOAD )
	
	self.Weapon:SetNWBool("money_mode", false)
	self.Weapon:SetNWInt("temp_mag", self.Primary.ClipSize)
	
	local waitdammit = (self.Owner:GetViewModel():SequenceDuration())
	if SERVER then
		self.Weapon:SetNWInt("Reloading", CurTime() + (waitdammit + .1) )
	end
		timer.Simple(waitdammit + .1, 
		function() 
			if self.Weapon == nil then return end
			self:ReloadFinished()
		end)
		self:ReloadFunc()
		
		self.Owner:EmitSound(self.ReloadSound)
			
			if CLIENT then

				self.Owner:DrawViewModel(true)

			end
			
end

function SWEP:MoneyReloading()
	self.Owner:SetNWInt("reloading_hold", 0)
	if self.Owner:getDarkRPVar("money") <= 0 then return end
	
	self.Weapon:SendWeaponAnim( ACT_VM_RELOAD ) 
	
	self.Weapon:SetNWBool("money_mode", true)
	self.Weapon:SetNWInt("temp_mag", self.Primary.ClipSize)

	local waitdammit = (self.Owner:GetViewModel():SequenceDuration())
	if SERVER then
		self.Weapon:SetNWInt("Reloading", CurTime() + (waitdammit + .1)) 
	end
		timer.Simple(waitdammit + .1, 
		function() 
			if self.Weapon == nil then return end
			local ammo = math.Clamp( self.Owner:getDarkRPVar("money"), 0, self.Primary.ClipSize)
			--print(ammo)
			self:SetClip1(ammo)
			self:ReloadFinished()
		end)
		self:ReloadFunc()
		
		self.Owner:EmitSound(self.ReloadSound)
			
			if CLIENT then

				self.Owner:DrawViewModel(true)

			end
	
end

function SWEP:ReloadingHandle()
	--print(self.Owner:GetNWInt("reloading_hold"))
	if self.Weapon:GetNWInt("Reloading") > CurTime() then return end
	
	if self.Owner:KeyDown(IN_RELOAD) then

		if self:GetNextPrimaryFire() > CurTime() then return end
		
		self.Owner:SetNWInt("reloading_hold", self.Owner:GetNWInt("reloading_hold")+1)
		
	end
	
	if self.Owner:GetNWInt("reloading_hold") > 30 and self.Weapon:GetNWInt("Reloading") < CurTime() and self.CanSwitchAmmo == true then
	
		if self.Weapon:GetNWBool("money_mode") == true then		
			self:DefaultReloading()
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD ) 
		elseif self.Weapon:GetNWBool("money_mode") == false then
			self:MoneyReloading()
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD ) 
		end
		
		if self:Clip1() >= self.Primary.ClipSize then return end
		
		self.Owner:SetNWInt("reloading_hold", 0)
	end
	
	if self.Owner:KeyReleased(IN_RELOAD) and self.Owner:GetNWInt("reloading_hold") < 30 then
	
		if self.Weapon:GetNWBool("money_mode") == false then	
			if self:Clip1() < self.Primary.ClipSize then
				self:DefaultReloading()
			end
		elseif self.Weapon:GetNWBool("money_mode") == true then
			if self.Weapon:GetNWInt("temp_mag") < self.Primary.ClipSize then
				self:MoneyReloading()
			end
		end
	end
	
	if !self.Owner:KeyDown(IN_RELOAD) and self.Owner:GetNWInt("reloading_hold") > 1 then

		self.Owner:SetNWInt("reloading_hold", 0)
		
	end
	
end

function SWEP:Reload()
if not IsValid(self) then return end 
if not IsValid(self.Owner) then return end

if self.Owner:IsPlayer() then

else

	
	if self.Weapon:Clip1() <= 0 or self.Owner:GetEnemy() == nil then 
		self.Owner:EmitSound(self.ReloadSound)
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
		self.Owner:SetSchedule(SCHED_RELOAD)
	end	
	
end

end

function SWEP:GetCapabilities()

	return bit.bor( CAP_WEAPON_RANGE_ATTACK2, CAP_INNATE_RANGE_ATTACK2 )

end

function SWEP:ShootBullet(CurrentDamage, CurrentRecoil, NumberofShots, CurrentCone, NearWallShit, trace)

	if self.Tracer == 1 then--Still modified shit from m9k lelele
		TracerName = "Ar2Tracer"
	elseif self.Tracer == 2 then
		TracerName = "AirboatGunHeavyTracer"
	elseif self.Tracer == 3 then
		TracerName = "ToolTracer"
	elseif self.Tracer == 4 then
		TracerName = "GaussTracer"
	elseif self.Tracer == 5 then
	    TracerName = "GunshipTracer"
	elseif self.Tracer == 7 then
	    TracerName = "ToolTracer"
	elseif self.Tracer == 10 then
	    TracerName = trace
	else
		TracerName = "Tracer"
	end
	local vectorshit
	if self.Owner:IsPlayer() then
			vectorshit = self.Owner:GetAimVector():Angle()+self.Owner:GetViewPunchAngles()--self.Owner:GetViewModel():GetAngles()--
	else
		vectorshit = self.Owner:GetAimVector():Angle()
		CurrentDamage = CurrentDamage*0.5
	end
	
	local posshit = self.Owner:GetShootPos()
	
	--if self:NearWall() and self.NearWallType == 1 then
		
		if self.Owner:IsPlayer() and self.Owner:KeyDown(IN_ATTACK2) and self.NearWallAim == true then
			vectorshit:RotateAroundAxis( vectorshit:Right(), (self.CoverAng.x * 1) )
			vectorshit:RotateAroundAxis( vectorshit:Up(), (self.CoverAng.y * 1) )
			vectorshit:RotateAroundAxis( vectorshit:Forward(), (self.CoverAng.z * 1) )
			
			posshit = posshit + (self.CoverPos * 1) 
		else
			vectorshit:RotateAroundAxis( vectorshit:Right(), (self.WallAng.x * NearWallShit) )
			vectorshit:RotateAroundAxis( vectorshit:Up(), (self.WallAng.y * NearWallShit) )
			vectorshit:RotateAroundAxis( vectorshit:Forward(), (self.WallAng.z * NearWallShit) )
			
			posshit = posshit + (self.WallPos * NearWallShit) 
		end
	--end

	local bullet = {}
		bullet.Num 		= NumberofShots
		bullet.Src 		= (posshit)
		bullet.Dir 	= self.Owner:GetAimVector() + (vectorshit:Forward())
		 --* NearWallShit
		if self.Owner:IsPlayer() then
			if self.HorizontalSpread == true then
			
				local vectorshit = self.Owner:GetAimVector():Angle() 
				
					vectorshit:RotateAroundAxis( vectorshit:Right(), 0 )
					vectorshit:RotateAroundAxis( vectorshit:Up(), math.random(-5,5)  )
					vectorshit:RotateAroundAxis( vectorshit:Forward(), 0 )
					
				bullet.Dir 		= self.Owner:GetAimVector() + vectorshit:Forward()
				bullet.Spread 	= Vector(0, 0, 0) 
			else
				bullet.Spread 	= Vector( CurrentCone * 0.1)
			end
		else
			if self.AdvancedNPCAiming == true or self.Owner:GetNWBool("adv_hg_aiming") == true then 
			--bullet.Dir 	= self.Owner:GetAimVector()
			if !IsValid(self.Owner:GetEnemy()) then return end
				local enemy_head_pos = self.Owner:GetEnemy():GetBoneMatrix(self.Owner:GetEnemy():LookupBone("ValveBiped.Bip01_Head1")):GetTranslation()
				
				local distance_correction
				
				if self.Owner:GetPos():Distance(enemy_head_pos) < 900 and self.Owner:GetPos():Distance(enemy_head_pos) > 300 then
					distance_correction = self.Owner:GetPos():Distance(enemy_head_pos)*.1
				elseif self.Owner:GetPos():Distance(enemy_head_pos) < 300 and self.Owner:GetPos():Distance(enemy_head_pos) > 100 then
					distance_correction = self.Owner:GetPos():Distance(enemy_head_pos)*.3
				elseif self.Owner:GetPos():Distance(enemy_head_pos) < 100 then
					distance_correction = self.Owner:GetPos():Distance(enemy_head_pos)*.5
				elseif self.Owner:GetPos():Distance(enemy_head_pos) > 900 then
					distance_correction = 0
				else
					distance_correction = 0
				end
				
				local vectorshit = ( self.Owner:GetPos() - (enemy_head_pos-Vector(0, 0, distance_correction)) ):Angle()--self.Owner:GetEnemy():GetPos() ):Angle()
				local c = CurrentCone*1.4
				
				vectorshit:RotateAroundAxis( vectorshit:Right(), math.random(-c,c)  )
				vectorshit:RotateAroundAxis( vectorshit:Up(), math.random(-c,c)   )
				vectorshit:RotateAroundAxis( vectorshit:Forward(), math.random(-c,c)  )
			
				vectorshit = vectorshit
			
				bullet.Dir = vectorshit:Forward()*-1
			
			else
			
			bullet.Dir 	= self.Owner:GetAimVector()
			
			end
						
			bullet.Spread 	= Vector(0.03,0.03,0.03) 
			
		end
		bullet.Tracer = mth.random(1,3)						
		bullet.TracerName = TracerName
		bullet.Force	= self.Primary.Force
		if self.Weapon:GetNWBool("money_mode") == false then
			bullet.Damage	= CurrentDamage
		elseif self.Weapon:GetNWBool("money_mode") == true then
			bullet.Damage	= CurrentDamage*1.6
		end
		bullet.Callback	= function(attacker, tracedata, dmginfo) 
			if self.Dissolve == 1 then 
				dmginfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_DISSOLVE ) )
			end
			if self.DamageType != nil then
				dmginfo:SetDamageType( bit.bor( self.DamageType, self.DamageType ) )
			end
				return self:HitCallback(attacker, tracedata, dmginfo) 
		end

	self.Owner:FireBullets(bullet)

end

function SWEP:ShootBulletInfo(trace)

	local CurrentDamage
	local CurrentRecoil
	local CurrentCone
	local basedamage

	local damagedice = mth.Rand(.85,1.3)
	
	local NearWallShit = 0

	if self:NearWall() and self.NearWallType == 1 then
		NearWallShit = ( mth.Clamp( (self.MaxDist - self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos) )/(self.MaxDist/1.5), 0, 1) ) 
		else
		NearWallShit = Lerp(FrameTime()*4, NearWallShit, 0)		
	end
	
	if !trace then
		trace = self.CustomTracerName
	end

	basedamage = self.Primary.Damage
	CurrentDamage = basedamage * damagedice
	CurrentRecoil = self.Primary.Recoil
	CurrentCone = self.Primary.Cone
	self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumberofShots, CurrentCone, NearWallShit, trace)
	
end

function SWEP:ShootBulletInfoSec(trace)

	local CurrentDamage
	local CurrentRecoil
	local CurrentCone
	local basedamage

	local damagedice = mth.Rand(.85,1.3)
	
	local NearWallShit = 0

	if self:NearWall() and self.NearWallType == 1 then
		NearWallShit = ( mth.Clamp( (self.MaxDist - self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos) )/(self.MaxDist/1.5), 0, 1) ) 
		else
		NearWallShit = Lerp(FrameTime()*4, NearWallShit, 0)		
	end
	
	if !trace then
		trace = self.CustomTracerName
	end
	
	basedamage = self.Secondary.Damage
	CurrentDamage = basedamage * damagedice
	CurrentRecoil = self.Secondary.Recoil
	CurrentCone = self.Secondary.Cone
	self:ShootBullet(CurrentDamage, CurrentRecoil, self.Secondary.NumberofShots, CurrentCone, NearWallShit, trace)
	
end

function SWEP:HitCallback(attacker, tr, dmginfo)
	
	if not IsFirstTimePredicted() then
	return {damage = false, effects = false}
	end
		
	local DoDefaultEffect = true
	if (tr.HitSky) then return end
	self:CustomHitFunc( attacker, tr, dmginfo )

		if self.Tracer == 0 or self.Tracer == 1 or self.Tracer == 2 or self.Tracer == 3 or self.Tracer == 4 then
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(20)
			util.Effect("AR2Impact", effectdata)
		elseif self.Tracer == 5 or self.Tracer == 7 then
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(20)
			util.Effect("StunstickImpact", effectdata)
		elseif self.Tracer == 6 then

		return 
	end
	return {damage = true, effects = DoDefaultEffect}
end

function SWEP:CustomHitFunc( attacker, tr, dmginfo )
end

function SWEP:CustomFireEvent( pos, ang, event, options )

end

function SWEP:FireAnimationEvent( pos, ang, event, options )
self:CustomFireEvent( pos, ang, event, options )
if self.DisableMuzzle == 1 then
	-- Disables animation based muzzle event
	--if ( event == 20 ) then return true end	
	if ( event == 21 ) or ( event == 20 ) then 		
		--if IsFirstTimePredicted() then
			if self.Owner:IsPlayer() and self.LuaShells == true then
				local fx = EffectData()
				fx:SetEntity(self.Weapon)
				fx:SetOrigin(self.Owner:GetShootPos())
				fx:SetNormal(self.Owner:GetAimVector())
				fx:SetAttachment(2)
				util.Effect(self.ShellName, fx)	
			end
		--end 
		return true 
	end	

	-- Disable thirdperson muzzle flash
	if ( event == 5001 ) then return true end
	if ( event == 5003 ) then return true end
	if ( event == 5011 ) then return true end
	if ( event == 5021 ) then return true end
	if ( event == 5031 ) then return true end
	if ( event == 6001 ) then return true end
end
end

function SWEP:CustomHud()//Функция для худа, если нужно оставить базовый код
end

local tstdata = {}

local length = 0

function SWEP:DrawHUD()
self:CustomHud()
local trace = self.Owner:GetEyeTrace()

	local wep = LocalPlayer():GetActiveWeapon()
	local ply = LocalPlayer()
	
self:DrawScopeShit()

end

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	
	-- Set us up the texture
	srface.SetDrawColor( 255, 255, 255, alpha )
	srface.SetTexture( self.WepSelectIcon )
	
	-- Lets get a sin wave to make it bounce
	local fsin = 0
	-- And fucking rotation
	local rsin = 0
	
	if ( self.BounceWeaponIcon == true ) then
		fsin = mth.sin( CurTime() * 10 ) * 5
		rsin = mth.sin( CurTime() * 5 ) * 10
	end
	
	-- Borders
	y = y + 10
	x = x + 10
	wide = wide - 20
	
	-- Draw that mother
	srface.DrawTexturedRectRotated( x + 80 + (fsin), y + 50 - (fsin),  wide-fsin*2 , ( wide / 2 ) + (fsin), rsin )
	
	-- Draw weapon info box
	self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
	
end


--[[---------------------------------------------------------
	This draws the weapon info box
-----------------------------------------------------------]]
function SWEP:PrintWeaponInfo( x, y, alpha )

	if ( self.DrawWeaponInfoBox == false ) then return end

	if (self.InfoMarkup == nil ) then
		local str
		local title_color = "<color=230,230,230,255>"
		local text_color = "<color=150,150,150,255>"
		
		str = "<font=HudSelectionText>"
		if ( self.Author != "" ) then str = str .. title_color .. "Author:</color>\t"..text_color..self.Author.."</color>\n" end
		if ( self.Contact != "" ) then str = str .. title_color .. "Contact:</color>\t"..text_color..self.Contact.."</color>\n\n" end
		if ( self.Purpose != "" ) then str = str .. title_color .. "Purpose:</color>\n"..text_color..self.Purpose.."</color>\n\n" end
		if ( self.Instructions != "" ) then str = str .. title_color .. "Instructions:</color>\n"..text_color..self.Instructions.."</color>\n" end
		str = str .. "</font>"
		
		self.InfoMarkup = markup.Parse( str, 250 )
	end
	
	srface.SetDrawColor( 60, 60, 60, alpha )
	srface.SetTexture( self.SpeechBubbleLid )
	
	srface.DrawTexturedRect( x, y - 64 - 5, 128, 64 ) 
	draw.RoundedBox( 8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color( 60, 60, 60, alpha ) )
	
	self.InfoMarkup:Draw( x+5, y+5, nil, nil, alpha )
	
end

function SWEP:RenderSomeShit()
		tstdata.angles = self.Owner:GetAngles() + self.Owner:GetViewPunchAngles()
		tstdata.origin = self.Owner:GetShootPos()
		tstdata.x = 0
		tstdata.y = 0
		tstdata.w = ScrW()
		tstdata.h = ScrH()
		tstdata.drawviewmodel  = false
		tstdata.fov = 15
		rndr.RenderView( tstdata )
end

local hudbopmul = 0

function SWEP:DrawScopeShit()

	local ply = self.Owner
	
	if self.Weapon:GetNWBool( "FuckDaModel") == true then
	
	local scoupe = srface.GetTextureID("gmod/scope")//"hobo_gus/scoupe")
	local scouperef = srface.GetTextureID("gmod/scope-refract")
		self.QuadTable = {}
		self.QuadTable.w = ScrH()
		self.QuadTable.h = ScrH()
		self.QuadTable.x = (ScrW() - ScrH()) * .5
		self.QuadTable.y = 0
		
		self:RenderSomeShit()	
srface.SetDrawColor( 0, 0, 0, 255 )		
		srface.SetTexture( scouperef )
		srface.DrawTexturedRect( ( ScrW() / 2.0 ) - ScrH()/2, (0), ScrH(), ScrH(), 0 )
		
		local x = ScrW() / 2.0
		local y = ScrH() / 2.0
	
		srface.SetDrawColor( self.CrossColor )
		srface.DrawLine( ScrH()/2, y, ScrW(), y )
		srface.DrawLine( x, 0, ScrW()/2, ScrH() )
		
		srface.SetDrawColor( 0, 0, 0, 255 )
		srface.SetTexture( scoupe )		
		srface.DrawTexturedRect( ( ScrW() / 2.0 ) - ScrH()/2, (0), ScrH(), ScrH(), 0 )
		
		srface.DrawRect(0, 0, (ScrW() - ScrH()) * .5, ScrH() )
		srface.DrawRect(ScrW() - ((ScrW() - ScrH()) * .5), 0, (ScrW() - ScrH()) * .5, ScrH() )
		
		if self.SightBreath == true then
			if ply:KeyDown(IN_SPEED) or self.Weapon:GetNWBool("over_breathhold") == true then
				hudbopmul = Lerp(FrameTime()*2, hudbopmul, 0)
			else
				hudbopmul = Lerp(FrameTime()*2, hudbopmul, 1)
			end
				draw.SimpleText("SHIFT - Hold your breath", "QuadFont", ScrW()/2, ScrH() - 60, Color(255, 255, 255, 255*hudbopmul), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			--draw.SimpleText(self.Weapon:GetNWBool("over_breathhold"), "QuadFont", ScrW()/2, ScrH() - 60, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
	end
end

/********************************************************
	SWEP Construction Kit base code
		Created by Clavus
	Available for public use, thread at:
	   facepunch.com/threads/1032378
	   
	DESCRIPTION:
		This script is meant for experienced scripters 
		that KNOW WHAT THEY ARE DOING. Don't come to me 
		with basic Lua questions.
		
		Just copy into your SWEP or SWEP base of choice
		and merge with your own code.
		
		The SWEP.VElements, SWEP.WElements and
		SWEP.ViewModelBoneMods tables are all optional
		and only have to be visible to the client.
********************************************************/
if CLIENT then
surface.CreateFont( "QuadFont", {
	font = "Arial",
	size = 25,
	weight = 5,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false, 
} )

surface.CreateFont( "QuadFontSmall", {
	font = "Arial",
	size = 15,
	weight = 5,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false, 
} )

end

function SWEP:InitFunc()
end

function SWEP:QuadsHere()
end

function SWEP:GetSCKshitPos(vm)

	//local vm = self.VElements[vm].modelEnt
	local pos, ang
	pos = self.VElements[vm].modelEnt:GetPos()
	ang = self.VElements[vm].modelEnt:GetAngles()
	
	return pos, ang
end

function SWEP:GetCapabilities()

	return bit.bor( CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1 )

end

function SWEP:ShouldDropOnDie()
	return true
end

function SWEP:Initialize()
self:InitFunc()
	if SERVER then
	
	self.Owner:ShouldDropWeapon(true) 
	self:SetWeaponHoldType( self.HoldType )
	if self.Owner:IsNPC() then //Shitty code for NPC...
		self:SetNPCMinBurst(1)
		self:SetNPCMaxBurst(5)
		self:SetNPCFireRate(2)--self.Primary.Delay)
		self:SetNPCMinRest(20)
		self:SetNPCMaxRest(35)
		self.Weapon.Owner:Fire("DisableWeaponPickup")
		self.Weapon.Owner:SetKeyValue("spawnflags","155") // Long Visibility/Shoot
		self.Weapon.Owner:SetKeyValue("FireRate","15")
		self.Owner:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_VERY_GOOD )
	end
 end
	
	if CLIENT then

	self:SetWeaponHoldType( self.HoldType )	
	self:QuadsHere()
	if self.QuadAmmoCounter == true then
		self.VElements["ammocounter"].draw_func = function( weapon )
			//surface.SetDrawColor(quadInnerColor)
			draw.SimpleText(weapon:Clip1(), "QuadFont", 0, 0, self.AmmoQuadColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(weapon:Ammo1(), "QuadFont", 0, 25, self.AmmoQuadColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
		
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels

		if IsValid(self.Owner) and self.Owner:IsPlayer() then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
			end
		end
	end
end

function SWEP:OnDrop()
	if CLIENT and IsValid(self.Owner) and self.Owner:IsPlayer() then
	local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
end

function SWEP:Holster()

	if CLIENT and IsValid(self.Owner) and self.Owner:IsPlayer() then
	local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
		
	end
	
	if IsValid(self.Owner) and self.Owner:WaterLevel() == 3 then--or self:NearWall() then
	return false
	else
	return true
	end

end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:CustomDrawn()
end

function SWEP:CustomWorldDrawn()
end

if CLIENT then

local redflare = Material( "effects/redflare" ) 
	--[[function SWEP:PostDrawViewModel( vm, weapon ) 
		if self.Weapon:GetNetworkedBool( "FuckDaModel" ) then return false end
	end]]

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn(vm)
		self:CustomDrawn(vm)
		
		//self:LaserDraw()
		local vm = self.Owner:GetViewModel()
		if ( IsValid( vm ) ) and self.LaserSight == true then
			local tr = self.Owner:GetEyeTrace()
			local lsize = math.random(7,10)
			
			local ent = self.Owner

			local mins = self.Owner:OBBMins()
			local maxs = self.Owner:OBBMaxs()
			local len = 6000
			
			local postst = self.Owner:GetViewModel():GetAttachment("1").Pos
			local angtst = self.Owner:GetViewModel():GetAttachment("1").Ang


			
			local tracetst = util.TraceHull( {
				start = postst + angtst:Forward()*-5 + angtst:Up()*5,
				endpos = postst + angtst:Right() * -len,
				maxs = maxs,
				mins = mins,
				filter = ent
			} )
			
			local pos = self.Owner:GetViewModel():GetAttachment("1").Pos--vm:GetPos()
			local ang = self.Owner:GetViewModel():GetAttachment("1").Ang--GetAngles()--vm:GetAngles()
			local endpos, startpos
			
		    rndr.SetMaterial( redflare )
            rndr.DrawSprite( tracetst.HitPos,lsize,lsize,Color( 255,255,255 ) )
		end
		
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		--self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then

			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					rndr.SuppressEngineLighting(true)
				end
				
				rndr.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				rndr.SetBlend(v.color.a/255)
				model:DrawModel()
				rndr.SetBlend(1)
				rndr.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					rndr.SuppressEngineLighting(false)
				end
				
					if name == "Laser" then
							local pos = model:GetPos()
							local ang = model:GetAngles()
							local lsize = mth.random(3,5)
							local endpos, startpos			// = pos + ang:Up() * 10000
							
							if name == "Laser" then
								endpos = pos + ang:Right() * -1 + ang:Forward() * 10000 + ang:Up() * 1.2// + ang:Up() * 10
								startpos = pos + ang:Right() * -1 + ang:Forward() * 5 + ang:Up() * 1.2// + ang:Up() * 10
							end
							
							local trc = util.TraceLine({
								start = startpos,
								endpos = endpos
							})
					
							rndr.SetMaterial( redflare )
							rndr.DrawBeam(startpos, trc.HitPos, 0.2, 0, 0.99, Color(255,255,255, 100))
							rndr.DrawSprite( trc.HitPos,lsize,lsize,Color( 255,255,255 ) )
					
					end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				rndr.SetMaterial(sprite)
				rndr.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		self:CustomWorldDrawn()
		if self.Owner:IsValid() and self.LaserSight == true then
				local tr = self.Owner:GetEyeTrace()
				local lsize = mth.random(9,15)
		          rndr.SetMaterial( redflare )
                  rndr.DrawSprite( tr.HitPos,lsize,lsize,Color( 255,255,255 ) )
		end
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					rndr.SuppressEngineLighting(true)
				end
				
				rndr.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				rndr.SetBlend(v.color.a/255)
				model:DrawModel()
				rndr.SetBlend(1)
				rndr.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					rndr.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				rndr.SetMaterial(sprite)
				rndr.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end

			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r 
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/
	
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end

print ('LUA BRUTALLY RAPED')