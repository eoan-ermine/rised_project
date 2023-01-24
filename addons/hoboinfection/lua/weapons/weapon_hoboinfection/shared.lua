-- "addons\\hoboinfection\\lua\\weapons\\weapon_hoboinfection\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if (SERVER) then --the init.lua stuff goes in here
 
 
   AddCSLuaFile ("shared.lua");
 
 
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = false;
   SWEP.AutoSwitchFrom = false;
 
end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "Инфекция";
   SWEP.Slot = 1;
   SWEP.SlotPos = 30;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end
 
 
SWEP.Author = "D-Rised";
SWEP.Contact = "";
SWEP.Purpose = "Контаминация...";
SWEP.Instructions = "";
SWEP.Category = "A - Rised - [Другое]"
 
SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
 
SWEP.ViewModel = "models/weapons/c_bugbait.mdl";
SWEP.WorldModel = "models/weapons/w_bugbait.mdl";
SWEP.ViewModelFOV			= 50
SWEP.HoldType				= "grenade"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.UseHands = true
SWEP.DrawCrosshair = true

SWEP.Primary.ClipSize = -1;
SWEP.Primary.DefaultClip = -1;
SWEP.Primary.Automatic = false;
SWEP.Primary.Ammo = "none";
SWEP.Primary.Delay		= 1.5


SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";
SWEP.Secondary.Delay		= 2
 

function SWEP:Reload()
	self.Owner:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE, true )

end

function SWEP:PrimaryAttack()
	self.Weapon:SendWeaponAnim( ACT_VM_HAULBACK )
	timer.Simple( 1, function() 
		if self:IsValid() then
			self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		end
	end )


self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
self.Owner:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE, true )
timer.Simple(0.1, function()
	if SERVER then
		local infect = ents.Create("hoboinfection") 
		local vec = Vector(0,0,0)
		infect:SetModel("models/weapons/w_bugbait.mdl")
		
		if self.Owner:EyeAngles().y > 25 && self.Owner:EyeAngles().y < 155 then
			vec = Vector(-15,0,0)
		elseif self.Owner:EyeAngles().y < -25 && self.Owner:EyeAngles().y > -155 then
			vec = Vector(15,0,0)
		elseif self.Owner:EyeAngles().y < 25 && self.Owner:EyeAngles().y > -25 then
			vec = Vector(0,15,0)
		elseif self.Owner:EyeAngles().y < -155 || self.Owner:EyeAngles().y > 155 then
			vec = Vector(0,-15,0)
		end
		
		infect:SetPos((self.Owner:EyePos() - vec) + (self.Owner:GetForward() * 26)) 
		infect:SetAngles(self.Owner:EyeAngles())
		infect:Spawn()
		infect:SetNWBool("InfectCanRemove", true)
		local infectphys = infect:GetPhysicsObject()
		infectphys:Wake()
		infectphys:ApplyForceCenter(self.Owner:GetAimVector():GetNormalized() * 800)   
	end
end)
	return true
end

 
function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
end