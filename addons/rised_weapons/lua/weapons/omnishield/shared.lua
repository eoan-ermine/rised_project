-- "addons\\rised_weapons\\lua\\weapons\\omnishield\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
  AddCSLuaFile( "shared.lua" )
	
	-- resource.AddFile("models/kali/omnishield/cat6 heavy omnishield.mdl")
	-- resource.AddFile("models/kali/omnishield/cat6 heavy omnishield.dx80")
	-- resource.AddFile("models/kali/omnishield/cat6 heavy omnishield.dx90")
	-- resource.AddFile("models/kali/omnishield/cat6 heavy omnishield.phy")
	-- resource.AddFile("models/kali/omnishield/cat6 heavy omnishield.sw")
	-- resource.AddFile("models/kali/omnishield/cat6 heavy omnishield.vvd")
	-- resource.AddFile("materials/kali/omnishield/omniblade.vmt")
	-- resource.AddFile("materials/kali/omnishield/omniblade.vtf")
	-- resource.AddFile("materials/kali/omnishield/sb_shield_tex_diff.vmt")
	-- resource.AddFile("materials/kali/omnishield/shield_edges.vmt")
	-- resource.AddFile("materials/kali/omnishield/sb_shield_tex_diff.vtf")
end



if (CLIENT) then
SWEP.PrintName = "WH-Shield"
SWEP.Category = "kake"
SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Author = "kake"
SWEP.Contact = "Deadlock-roleplay.net"
SWEP.Purpose = "'Omni shield from Mass Effect"
end

SWEP.HoldType			= "slam"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"
SWEP.Primary.Damage         = 0
SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = true
SWEP.Primary.Delay = 1.1
SWEP.Primary.Ammo       = "none"

SWEP.Primary.ClipSize  = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic  = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.WorldModel = ""
SWEP.ViewModel = ""
SWEP.Power = 500

function SWEP:Initialize()

	self:SetNWInt("Rised_Shield_Power", 1500)

end

function SWEP:Deploy()
	if SERVER then
		if IsValid(self.ent) then return end
		self:SetNoDraw(true)
		self.entvisual = ents.Create("prop_physics")
			self.entvisual:SetModel("models/hlvr/combine_shield.mdl")
			self.entvisual:SetPos(self.Owner:GetPos() + (self.Owner:GetForward()*10) + (self.Owner:GetUp()*40) + (self.Owner:GetRight()*-10))
			self.entvisual:SetAngles(Angle(0,self.Owner:EyeAngles().y,self.Owner:EyeAngles().r))
			self.entvisual:SetParent(self.Owner, 1)
			self.entvisual:SetModelScale( 1, 0.1 )
			self.entvisual:SetCollisionGroup( COLLISION_GROUP_WORLD )
			self.entvisual:Spawn()
			self.entvisual:Activate()
		self.ent = ents.Create("prop_physics")
			self.ent:SetModel("models/props_lab/blastdoor001b.mdl")
			self.ent:SetPos(self.Owner:GetPos() + (self.Owner:GetForward()*40) + (self.Owner:GetUp()*50) + (self.Owner:GetRight()*-40))
			self.ent:SetAngles(Angle(0,self.Owner:GetAngles().y,self.Owner:GetAngles().r))
			self.ent:SetParent(self.Owner, 1)
			self.ent:SetCollisionGroup( COLLISION_GROUP_WORLD )
			self.ent:SetAngles(Angle(20,90,10))
			self.ent:SetColor(Color(0,0,0,0))
			self.ent:SetModelScale( 0.6, 0.1 )
			self.ent.Shield = true
			self.ent:SetRenderMode( RENDERMODE_TRANSCOLOR )
			self.ent:Spawn()
			self.ent:Activate()

		hook.Add( "EntityTakeDamage", "EntityDamageExample", function( target, dmginfo )
			if target.Shield then
				if self:GetNWInt("Rised_Shield_Power") >= -50 then
					self:SetNWInt("Rised_Shield_Power", self:GetNWInt("Rised_Shield_Power") - dmginfo:GetDamage())
				end
			end
		end )
	end
	return true
end

function SWEP:PrimaryAttack()
end

function SWEP:Holster()
	if SERVER then
		if not IsValid(self.ent) then return end
		self.entvisual:Remove()
		self.ent:Remove()
	end
	return true
end

function SWEP:OnDrop()
	if SERVER then
		self:SetColor(Color(255,255,255,255))
		if not IsValid(self.ent) then return end
		self.entvisual:Remove()
		self.ent:Remove()
	end
end

function SWEP:OnRemove()
	if SERVER then
		self:SetColor(Color(255,255,255,255))
		if not IsValid(self.ent) then return end
		self.entvisual:Remove()
		self.ent:Remove()
	end
end

function SWEP:Reload()
	if SERVER then
		if self:GetNWBool("Rised_Shield_Restore") then
			self:SetNWBool("Rised_Shield_Restore", true)
			self:SetNWInt("Rised_Shield_Power", 0)
			self.Owner:EmitSound("npc/turret_floor/die.wav", 75)
		end
	end
end

local cd = 0
function SWEP:Think()
	if SERVER then

		if cd <= CurTime() and self:GetNWBool("Rised_Shield_Restore") then
			cd = CurTime() + 0.2
			if self:GetNWInt("Rised_Shield_Power") < 0 then
				self:SetNWInt("Rised_Shield_Power", 0)
				self:SetNWBool("Rised_Shield_Restore", true)
				self.Owner:EmitSound("npc/roller/mine/rmine_explode_shock1.wav", 75)
			end
			if self:GetNWInt("Rised_Shield_Power") < 1500 then
				self:SetNWInt("Rised_Shield_Power", self:GetNWInt("Rised_Shield_Power") + 5)
			elseif self:GetNWInt("Rised_Shield_Power") >= 1500 then
				self:SetNWBool("Rised_Shield_Restore", false)
				self.Owner:EmitSound("npc/roller/mine/rmine_predetonate.wav", 75)
			end
		end

		if self:GetNWInt("Rised_Shield_Power") <= 0 then

			self.entvisual:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
			self.ent:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )

			self.entvisual:SetAngles(Angle(-65,self.Owner:GetAngles().y,self.Owner:GetAngles().r + 90))
			self.entvisual:SetColor(Color(145,145,145,0))
			self.entvisual:SetRenderMode( RENDERMODE_TRANSCOLOR )
			self.ent:SetAngles(Angle(-65,self.Owner:GetAngles().y,self.Owner:GetAngles().r + 90))
			self.ent:SetColor(Color(0,0,0,0))
			self.ent:SetRenderMode( RENDERMODE_TRANSCOLOR )
		else

			self.entvisual:SetCollisionGroup( COLLISION_GROUP_WORLD )
			self.ent:SetCollisionGroup( COLLISION_GROUP_WORLD )

			self.entvisual:SetAngles(Angle(-65,self.Owner:GetAngles().y,self.Owner:GetAngles().r + 90))
			self.entvisual:SetColor(Color(145,145,145,55))
			self.entvisual:SetRenderMode( RENDERMODE_TRANSCOLOR )
			self.ent:SetAngles(Angle(-65,self.Owner:GetAngles().y,self.Owner:GetAngles().r + 90))
			self.ent:SetColor(Color(0,0,0,0))
			self.ent:SetRenderMode( RENDERMODE_TRANSCOLOR )
		end
	end
end

function SWEP:DrawHUD()

	local x, y

	x, y = ScrW() / 2.0, ScrH() / 2.0

	surface.SetDrawColor( 255, 255, 255, 255 )
	
	local length = self:GetNWInt("Rised_Shield_Power") * 0.1

	surface.DrawLine( x - length, y, x, y )
	surface.DrawLine( x - length, y, x, y-1 )

end


