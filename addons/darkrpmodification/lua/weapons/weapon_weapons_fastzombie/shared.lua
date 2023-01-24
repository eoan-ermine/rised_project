-- "addons\\darkrpmodification\\lua\\weapons\\weapon_weapons_fastzombie\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile( "shared.lua" );

if CLIENT then
	SWEP.PrintName = "Fast Zombie";
	SWEP.Category	= "Zombies"
	
	SWEP.Slot = 3;
	SWEP.SlotPos = 3;
	
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true

end

SWEP.Author			= "Sean"
SWEP.Instructions	= "Left Click: Attack, Crouch + Right Click: Leap, Reload: Moan"
SWEP.Contact		= ""
SWEP.Purpose		= "AGHH!"

SWEP.ViewModelFOV	= 71
SWEP.ViewModelFlip	= false
SWEP.HoldType		= "knife"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel      = "models/weapons/v_fza.mdl"
SWEP.WorldModel   	= ""
  
-- Stats
SWEP.Primary.Delay			= 0.8
SWEP.Secondary.Delay		= 3

SWEP.Primary.Recoil			= 5
SWEP.Primary.Damage			= 45
SWEP.Primary.Automatic   	= true
-- Stats


-- Misc
SWEP.Primary.NumShots		= 1	
SWEP.Primary.Cone			= 1
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Ammo = "none"

SWEP.NextStrike = 0;
-- Misc

SWEP.WepSelectFont		= "HL2MPTypeDeath"
SWEP.WepSelectLetter	= "Z"

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( color_transparent )
	surface.SetTextColor( 25, 25, 25, alpha )
	surface.SetFont( self.WepSelectFont )
	local w, h = surface.GetTextSize( self.WepSelectLetter )

	surface.SetTextPos( x + ( wide / 2 ) - ( w / 2 ),
						y + ( tall / 2 ) - ( h / 2 ) )
	surface.DrawText( self.WepSelectLetter )
end

function SWEP:Precache()
util.PrecacheModel(self.ViewModel)

util.PrecacheSound("npc/fast_zombie/zombie_alert1.wav")
util.PrecacheSound("npc/fast_zombie/zombie_alert2.wav")
util.PrecacheSound("npc/fast_zombie/zombie_alert3.wav")
util.PrecacheSound("npc/fast_zombie/claw_miss1.wav")
util.PrecacheSound("npc/fast_zombie/claw_miss2.wav")
util.PrecacheSound("npc/fast_zombie/claw_strike1.wav")
util.PrecacheSound("npc/fast_zombie/claw_strike2.wav")
util.PrecacheSound("npc/fast_zombie/claw_strike3.wav")
util.PrecacheSound("npc/fast_zombie/zo_attack1.wav")
util.PrecacheSound("npc/fast_zombie/zo_attack2.wav")
util.PrecacheSound("npc/fast_zombie/moan_loop1.wav")
util.PrecacheSound("npc/fast_zombie/fz_scream.wav")
end

function SWEP:Initialize()
	self:Precache()
	self:SetWeaponHoldType(self.HoldType)
	self:SetDeploySpeed(1)
end

function SWEP:ZombieModel()
	if self.Owner:IsValid() then
	--util.PrecacheModel("models/player/zombie_fast.mdl")
	--self.Owner:SetModel("models/player/zombie_fast.mdl")
	end
end

function SWEP:Playermodel()
	if self.Owner:IsValid() then
	--util.PrecacheModel("models/player/zombie_fast.mdl")
	--self.Owner:SetModel("models/player/zombie_fast.mdl")
	end
end

function SWEP:NormalSpeed() -- Resets the speed
	if self.Owner:IsValid() then
	end
end

function SWEP:CustomSpeed() -- New speed
	if self.Owner:IsValid() then
	end
	
	if SERVER then
		timer.Simple(1, function()
			if IsValid(self) then
				net.Start( "NETHOOK_fastzombieAnim" )
				net.WriteEntity(self.Owner)
				net.WriteInt(1, 32)
				net.Broadcast()
			end
		end)
	end
end

net.Receive("NETHOOK_fastzombieAnim", function(ply)
	local plyer = net.ReadEntity()
	local anim = net.ReadInt(32)
	if anim == 1 then
		if IsValid(plyer) then
			plyer:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_HL2MP_RUN_ZOMBIE_FAST, false )
		end
	elseif anim == 2 then
		if IsValid(plyer) then
			plyer:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_GMOD_GESTURE_RANGE_FRENZY, true )
		end
	elseif anim == 3 then
		if IsValid(plyer) then
			plyer:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_ZOMBIE_LEAP_START, true )
		end
	elseif anim == 4 then
		if IsValid(plyer) then
			plyer:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_ZOMBIE_LEAPING, true )
		end
	end
end)

function SWEP:Deploy()
	if self.Owner:IsValid() then
	self:CustomSpeed() -- call the custom speed funciton above
	self:ZombieModel() -- call the zombiemodel function
	
	if SERVER then
		timer.Simple(0.05, function() 
			if IsValid(self) then
				self:SendWeaponAnim(ACT_VM_IDLE)
				net.Start( "NETHOOK_fastzombieAnim" )
				net.WriteEntity(self.Owner)
				net.WriteInt(1, 32)
				net.Broadcast()
			end
		end)
	end
	
	end
	return true;
end

function SWEP:Holster()
	if self.Owner:IsValid() then
	self:NormalSpeed() -- call the normal speed function above
	self:Playermodel()
	end
	return true;
end

function SWEP:Think()
    if not self.NextHit or CurTime() < self.NextHit then return end
    self.NextHit = nil

    local pl = self.Owner

    local vStart = pl:EyePos() + Vector(0, 0, -10)
    local trace = util.TraceLine({start=vStart, endpos = vStart + pl:GetAimVector() * 72, filter = pl, mask = MASK_SHOT})

    local ent
    if trace.HitNonWorld then
        ent = trace.Entity
    elseif self.PreHit and self.PreHit:IsValid() and not (self.PreHit:IsPlayer() and not self.PreHit:Alive()) and self.PreHit:GetPos():Distance(vStart) < 110 then
        ent = self.PreHit
        trace.Hit = true
    end

    if trace.Hit then
        pl:EmitSound("npc/fast_zombie/claw_strike"..math.random(1, 2)..".wav")
    end

    pl:EmitSound("npc/fast_zombie/claw_miss"..math.random(1, 2)..".wav")
    self.PreHit = nil

    if ent and ent:IsValid() and not (ent:IsPlayer() and not ent:Alive()) then
            local damage = 35
            local phys = ent:GetPhysicsObject()
            if phys:IsValid() and not ent:IsNPC() and phys:IsMoveable() then
                local vel = damage * 323 * pl:GetAimVector()

                phys:ApplyForceOffset(vel, (ent:NearestPoint(pl:GetShootPos()) + ent:GetPos() * 2) / 3)
                --ent:SetPhysicsAttacker(pl)
            end
            if not CLIENT and SERVER then
            ent:TakeDamage(damage, pl, self)
        end
    end
end

SWEP.NextSwing = 0
function SWEP:PrimaryAttack()
    if CurTime() < self.NextSwing then return end
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	if SERVER then
		net.Start( "NETHOOK_fastzombieAnim" )
		net.WriteEntity(self.Owner)
		net.WriteInt(2, 32)
		net.Broadcast()
	end
	
	timer.Simple(0.3, function(wep)
		if SERVER then
			if IsValid(self) then
				net.Start( "NETHOOK_fastzombieAnim" )
				net.WriteEntity(self.Owner)
				net.WriteInt(1, 32)
				net.Broadcast()
			end
			
			local trEntity = self.Owner:GetEyeTrace().Entity
			local Distance = self.Owner:EyePos():Distance(trEntity:GetPos())
				
			if Distance < 100 and trEntity:GetClass()=="prop_door_rotating" then
				if trEntity:GetNWInt("Door_Hits") >= 15 then
					trEntity:Fire("unlock")
					trEntity:Fire("open")
					trEntity:EmitSound("physics/wood/wood_furniture_break2.wav")
					trEntity:SetNWInt("Door_Hits", 0)
				else
					trEntity:EmitSound("physics/wood/wood_plank_break1.wav")
					trEntity:SetNWInt("Door_Hits", trEntity:GetNWInt("Door_Hits") + 1)
				end
			end
		end
	end)
    self.NextSwing = CurTime() + self.Primary.Delay
    self.NextHit = CurTime() + 0.1
    local vStart = self.Owner:EyePos() + Vector(0, 0, -10)
    local trace = util.TraceLine({start=vStart, endpos = vStart + self.Owner:GetAimVector() * 65, filter = self.Owner, mask = MASK_SHOT})
    if trace.HitNonWorld then
        self.PreHit = trace.Entity
    end
end

SWEP.Leap = 0
function SWEP:SecondaryAttack()
if CurTime() < self.Leap then return end
	
	timer.Simple(1.4, function() 
		if IsValid(self) then
			self:SendWeaponAnim(ACT_VM_IDLE)
		end		
	end)
    self.isflying = true
    self.islanding = false
	self:SetVelocity((self:GetUp() * 145) + (self:GetForward() * 555));
	
if self.isflying then
	self.Owner:ViewPunch(Angle(8, 0, 0));
	self.Owner:SetVelocity((self.Owner:GetForward() * 555) + (self.Owner:GetUp() * 145));
	
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	if SERVER then
		net.Start( "NETHOOK_fastzombieAnim" )
		net.WriteEntity(self.Owner)
		net.WriteInt(3, 32)
		net.Broadcast()
	end
	
	function Animations()
		if IsValid(self) then
			if SERVER then
				net.Start( "NETHOOK_fastzombieAnim" )
				net.WriteEntity(self.Owner)
				net.WriteInt(4, 32)
				net.Broadcast()
			end
			timer.Simple(0.9, function(wep)
				if SERVER then
					net.Start( "NETHOOK_fastzombieAnim" )
					net.WriteEntity(self.Owner)
					net.WriteInt(1, 32)
					net.Broadcast()
				end
			end)
		end
	end
	
	timer.Create("Animations", 0.4, 2, Animations ) -- plays the leaping animation 2 times
	
	self.Weapon:EmitSound("npc/fast_zombie/fz_scream1.wav")
	
	self.Leap = CurTime() + 3
	
	end
end


SWEP.NextMoan = 0
function SWEP:Reload()
    if CurTime() < self.NextMoan then return end

	self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_TAUNT_ZOMBIE)
	
    if SERVER and not CLIENT then
        self.Owner:EmitSound("npc/fast_zombie/zombie_alert"..math.random(1, 3)..".wav")
    end
    self.NextMoan = CurTime() + 3
end