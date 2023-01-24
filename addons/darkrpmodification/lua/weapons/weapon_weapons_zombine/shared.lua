-- "addons\\darkrpmodification\\lua\\weapons\\weapon_weapons_zombine\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile("shared.lua")

if CLIENT then
SWEP.PrintName = "Zombine"
SWEP.Category         = "Zombies"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.CSMuzzleFlashes = false
SWEP.Slot = 2;
SWEP.SlotPos = 2;
SWEP.IconLetter            = "J"
end

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Author = "Sean"
SWEP.Purpose = "Kill Humans"
SWEP.Instructions = "Left click: Attack, Right Click: Grenade, Reload: Moan"

SWEP.ViewModel = "models/weapons/zombine/v_zombine.mdl"
SWEP.WorldModel = ""

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1.1

SWEP.HoldType = "knife"

SWEP.Secondary.Automatic = false

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"

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

    util.PrecacheSound("npc/zombine/zombie_voice_idle1.wav")
    util.PrecacheSound("npc/zombine/zombie_voice_idle2.wav")
    util.PrecacheSound("npc/zombie/claw_strike1.wav")
    util.PrecacheSound("npc/zombie/claw_strike2.wav")
    util.PrecacheSound("npc/zombie/claw_strike3.wav")
    util.PrecacheSound("npc/zombie/claw_miss1.wav")
    util.PrecacheSound("npc/zombie/claw_miss2.wav")
    util.PrecacheSound("npc/zombine/zo_attack1.wav")
    util.PrecacheSound("npc/zombine/zo_attack2.wav")
end

function SWEP:Initialize()	
	self:Precache()
	self:SetWeaponHoldType(self.HoldType)
    self:SetDeploySpeed(1)
end

function SWEP:ZombieModel()
	if self.Owner:IsValid() then
	--util.PrecacheModel("models/player/zombine/combine_zombie.mdl")
	--self.Owner:SetModel("models/player/zombine/combine_zombie.mdl")
	end
end

function SWEP:Playermodel()
	if self.Owner:IsValid() then
	--util.PrecacheModel("models/player/zombine/combine_zombie.mdl")
	--self.Owner:SetModel("models/player/zombine/combine_zombie.mdl")
	end
end

function SWEP:NormalSpeed() -- Resets the speed
	if self.Owner:IsValid() then
	self.Owner:SetRunSpeed(100)
	self.Owner:SetWalkSpeed(100)
	end
end

function SWEP:CustomSpeed() -- New speed
	if self.Owner:IsValid() then
	self.Owner:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_HL2MP_WALK_ZOMBIE_01, false )
	end
	
	if SERVER then
		if bool == false then
			bool = true
		else
			timer.Simple(1, function()
				if IsValid(self) then
					net.Start( "NETHOOK_zombineAnim" )
					net.WriteEntity(self.Owner)
					net.WriteInt(1, 32)
					net.Broadcast()
				end
			end)
		end
	end
end

net.Receive("NETHOOK_zombineAnim", function(ply)
	local plyer = net.ReadEntity()
	local anim = net.ReadInt(32)
	if anim == 1 then
		if IsValid(plyer) then
			plyer:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_HL2MP_WALK_ZOMBIE_01, false )
		end
	elseif anim == 2 then
		if IsValid(plyer) then
			plyer:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_GMOD_GESTURE_RANGE_ZOMBIE, true )
		end
	elseif anim == 3 then
		if IsValid(plyer) then
			plyer:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, false )
		end
		timer.Simple(0.9, function()
			if IsValid(plyer) then
				plyer:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_HL2MP_RUN_ZOMBIE, false ) 
			end
		end)
	end
end)

function SWEP:Deploy()
	if self.Owner:IsValid() then
	bool = false
	self:CustomSpeed() -- call the custom speed function above
	self:ZombieModel() -- call the zombiemodel function
	
	if SERVER then
		timer.Simple(0.05, function() 
			if IsValid(self) then
				self:SendWeaponAnim(ACT_VM_IDLE)
				net.Start( "NETHOOK_zombineAnim" )
				net.WriteEntity(self.Owner)
				net.WriteInt(1, 32)
				net.Broadcast()
			end
		end)
	end
	
	self:SendWeaponAnim(ACT_VM_DEPLOY)
	
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
    local trace = util.TraceLine({start=vStart, endpos = vStart + pl:GetAimVector() * 71, filter = pl, mask = MASK_SHOT})

    local ent
    if trace.HitNonWorld then
        ent = trace.Entity
    elseif self.PreHit and self.PreHit:IsValid() and not (self.PreHit:IsPlayer() and not self.PreHit:Alive()) and self.PreHit:GetPos():Distance(vStart) < 110 then
        ent = self.PreHit
        trace.Hit = true
    end

    if trace.Hit then
        pl:EmitSound("npc/zombie/claw_strike"..math.random(1, 3)..".wav")
    end

    pl:EmitSound("npc/zombie/claw_miss"..math.random(1, 2)..".wav")
    self.PreHit = nil

    if ent and ent:IsValid() and not (ent:IsPlayer() and not ent:Alive()) then
            local damage = 62
            local phys = ent:GetPhysicsObject()
            if phys:IsValid() and not ent:IsNPC() and phys:IsMoveable() then
                local vel = damage * 487 * pl:GetAimVector()

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
	if CurTime() < self.NextGrenade then return end -- so you can't use the grenade and attack the same time
	local attack = math.random(1,2)
	if attack == 1 then self:SendWeaponAnim(ACT_VM_PRIMARYATTACK) else
	if attack == 2 then self:SendWeaponAnim(ACT_VM_PRIMARYATTACK) end
end	
	if SERVER then
		net.Start( "NETHOOK_zombineAnim" )
		net.WriteEntity(self.Owner)
		net.WriteInt(2, 32)
		net.Broadcast()
	end
	self.Owner:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_GMOD_GESTURE_RANGE_ZOMBIE, true )
    self.Owner:EmitSound("npc/zombine/zo_attack"..math.random(1, 2)..".wav")
	timer.Simple(0.45, function(wep)
		if SERVER then
			if IsValid(self) then
				net.Start( "NETHOOK_zombineAnim" )
				net.WriteEntity(self.Owner)
				net.WriteInt(1, 32)
				net.Broadcast()
			end
			
			local trEntity = self.Owner:GetEyeTrace().Entity
			local Distance = self.Owner:EyePos():Distance(trEntity:GetPos())
				
			if Distance < 100 and trEntity:GetClass()=="prop_door_rotating" then
				if trEntity:GetNWInt("Door_Hits") >= 2 then
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
    self.NextHit = CurTime() + 0.4
    local vStart = self.Owner:EyePos() + Vector(0, 0, -10)
    local trace = util.TraceLine({start=vStart, endpos = vStart + self.Owner:GetAimVector() * 65, filter = self.Owner, mask = MASK_SHOT})
    if trace.HitNonWorld then
        self.PreHit = trace.Entity
	end
end

function SWEP:Grenade()

	if SERVER then
		local grenade = ents.Create("env_explosion")
		grenade:SetPos(self:GetPos())
		grenade:Spawn()
		grenade:SetKeyValue( "iMagnitude", "125" )
		grenade:Fire( "Explode", 0, 0 )
		grenade:EmitSound("ambient/fire/gascan_ignite1.wav")
		self.Owner:Kill()
	end

end

SWEP.NextGrenade = 0
function SWEP:SecondaryAttack()
	if CurTime() < self.NextMoan then return end
	if SERVER then
		net.Start( "NETHOOK_zombineAnim" )
		net.WriteEntity(self.Owner)
		net.WriteInt(3, 32)
		net.Broadcast()
	end
	self.Owner:SetRunSpeed(255)
	self.Owner:SetWalkSpeed(255)
	
	timer.Simple(4.2, function(wep)
		if SERVER then
			if IsValid(self) then
				self.Owner:SetWalkSpeed(100)
				self.Owner:SetRunSpeed(100)
				net.Start( "NETHOOK_zombineAnim" )
				net.WriteEntity(self.Owner)
				net.WriteInt(1, 32)
				net.Broadcast()
			end
		end
	end)
	
    if SERVER and not CLIENT then
        self.Owner:EmitSound("npc/zombie/zombie_voice_idle"..math.random(1, 14)..".wav")
    end

	self.NextMoan = CurTime() + 7
end

SWEP.NextMoan = 0
function SWEP:Reload()
    if CurTime() < self.NextGrenade then return end
	if self.Owner:KeyDown(IN_WALK) then
		timer.Simple(0.5, function() 
			if IsValid(self) then
				self.Owner:EmitSound("weapons/grenade/tick1.wav")  
			end
		end)
		timer.Create("ZombineGranade", 0.4, 7, function() 
			if IsValid(self) then
				self.Owner:EmitSound("weapons/grenade/tick1.wav") 
			end
		end)
		timer.Simple(3, function(wep) 
			if IsValid(self) then
				self:Grenade()
			end
		end)

		if SERVER and not CLIENT then
			self.Owner:EmitSound("npc/zombine/zombie_voice_idle"..math.random(1, 2)..".wav")
			if IsValid(self) then
				net.Start( "NETHOOK_zombineAnim" )
				net.WriteEntity(self.Owner)
				net.WriteInt(3, 32)
				net.Broadcast()
				self.Owner:SetRunSpeed(255)
				self.Owner:SetWalkSpeed(255)
			end
		end
		self.NextGrenade = CurTime() + 3
	end
end