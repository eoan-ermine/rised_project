-- "lua\\weapons\\weapon_ar2_proto\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base           = "weapon_base"
SWEP.Category				= "Entropy : Zero" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = "Combine" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "Insane Black Rock Shooter" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.AdminOnly = false
SWEP.DrawCrosshair			= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
SWEP.PrintName				= "Prototype AR2"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 2			-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 20			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter if enabled in the GUI.
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.
SWEP.UseHands = true
SWEP.ViewModel        = "models/weapons/c_irifle_proto.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"

SWEP.Primary.Automatic			= true
SWEP.Primary.ClipSize = 80
SWEP.Primary.Delay = 0.08
SWEP.Primary.DefaultClip = 110
SWEP.Primary.Ammo = "ar2"

SWEP.HoldType = "ar2"

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 1.95
SWEP.Secondary.Damage = 125
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "AR2AltFire"

function SWEP:Reload()
	if	self.Weapon:DefaultReload(ACT_VM_RELOAD) then
	    self:EmitSound( "Weapon_AR2.Reload" )
	end
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:PlayAnim(a,c,t)
local vm=self.Owner:GetViewModel()
if a then
local n=vm:LookupSequence(a)
vm:ResetSequence(n)
vm:ResetSequenceInfo()
vm:SendViewModelMatchingSequence(n)
end
if !c then c=1 end
vm:SetPlaybackRate(c)
end

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
	self.Idle = 0
	self.IdleTimer = CurTime() + 4
end

function SWEP:DrawWeaponSelection(x,y,wide,tall)
	local c=self.TextColor or Color(255,220,0)
		draw.SimpleText("l","WeaponIcons",x+wide/2,y+tall*.2,c,TEXT_ALIGN_CENTER)
		self:PrintWeaponInfo(x+wide+20,y+tall*.95,alpha)
end

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
		if ( IsFirstTimePredicted() ) then
			local bullet = {}
				bullet.Num = GetConVar( "sk_ez_proto_ar2_num" ):GetInt()
				bullet.Src = self.Owner:GetShootPos()
				bullet.Dir = (self.Owner:EyeAngles()+self.Owner:GetViewPunchAngles()):Forward() 
				
				if GetConVar( "sk_ez_no_bullet_spread" ):GetInt() == 0 then
					bullet.Spread = Vector( 0.1, 0.1, 0 )
				else
					bullet.Spread = Vector( 0, 0, 0 )
				end
				
			bullet.Force = 5
			bullet.Damage = self.Primary.Damage
			bullet.TracerName = "AR2Tracer"
			self.Owner:FireBullets( bullet )
			
				if GetConVar( "sk_ez_no_recoil" ):GetInt() == 0 then
					self.Owner:ViewPunch(Angle( -4, math.Rand( -2, 2 ),0))
				end
		
			self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			
				if GetConVar( "sk_ez_infinite_ammo" ):GetInt() == 0 then
					self:TakePrimaryAmmo( 1 )
				else
					self:TakePrimaryAmmo( 0 )
				end
				
			self:EmitSound("Weapon_AR2_Proto.Single")
			self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
			self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
		end
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:SecondaryAttack()
	if ( IsFirstTimePredicted() ) then
		if self.Owner:GetAmmoCount( self.Secondary.Ammo ) > 0 or GetConVar( "sk_ez_infinite_ammo" ):GetInt() == 1 then
			self:EmitSound("Weapon_AR2_Proto.Special1")
			self:PlayAnim( "shake" )
				if SERVER then
					timer.Simple(0.75,function()
						local cballspawner = ents.Create( "point_combine_ball_launcher" )
							cballspawner:SetAngles( self.Owner:EyeAngles())
							cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*14)
							cballspawner:SetKeyValue( "minspeed",2200 )
							cballspawner:SetKeyValue( "maxspeed", 2200 )
							cballspawner:SetKeyValue( "ballradius", "15" )
							cballspawner:SetKeyValue( "ballcount", "3" )
							cballspawner:SetKeyValue( "maxballbounces", "18" )
							cballspawner:SetKeyValue( "launchconenoise", 8 )
							cballspawner:Spawn()
							cballspawner:Activate()
							cballspawner:Fire( "LaunchBall" )
							cballspawner:Fire( "LaunchBall" )
							cballspawner:Fire( "LaunchBall" )
							cballspawner:Fire("kill","",0)
								if GetConVar( "sk_ez_no_recoil" ):GetInt() == 0 then
									self.Owner:ViewPunch(Angle( -20,0,0 ))
								end
								if GetConVar( "sk_ez_infinite_ammo" ):GetInt() == 0 then
									self:TakeSecondaryAmmo( 1 )
								else
									self:TakeSecondaryAmmo( 0 )
								end
							self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
							self.Owner:SetAnimation( PLAYER_ATTACK1 )
							self:EmitSound("Weapon_AR2_Proto.AltFire_Single")
					end)
				end
			timer.Simple(0.76,function()
				if IsValid(self) and IsValid(self.Owner) then
					for k,v in pairs(ents.FindInSphere(self.Owner:GetShootPos(),20)) do
						if IsValid(v) and string.find(v:GetClass(),"prop_combine_ball") and !IsValid(v:SetOwner()) and SERVER then
							v:SetOwner(self.Owner)
							v:GetPhysicsObject():AddGameFlag( FVPHYSICS_WAS_THROWN )
							v:Fire("explode","",GetConVar( "sk_ez_proto_ar2_ball_explode_time" ):GetInt())
						end
					end
				end
			end)
			self:SetNextPrimaryFire( CurTime() + self.Secondary.Delay )
			self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
			self.Idle = 0
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		else 
			self:EmitSound("Weapon_IRifle.Empty")
			self:SetNextPrimaryFire( CurTime() + 0.25 )
			self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
			self.Idle = 0
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		end
	end
end

function SWEP:Think()
	self.Primary.Damage = GetConVar( "sk_ez_proto_ar2_dmg" ):GetInt()
	self.ViewModelFOV = 80
if self.Idle == 0 and self.IdleTimer < CurTime() then
	if SERVER then
		self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
	end
	self.Idle = 1
end
	end

if ( SERVER ) then return end
killicon.AddAlias( "weapon_ar2_proto", "weapon_ar2" )
