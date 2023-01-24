-- "addons\\rised_animations\\lua\\weapons\\animation_swep_base\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
Only allowed to use in Addons by
​Mattis 'Mattzimann' Krämer
]]--

SWEP.Author					= "Mattzimann & Oninoni"
SWEP.Purpose				= "Base class for animations"
SWEP.Instructions 			= "Click to play the animation"
SWEP.Category 				= "EGM Animation SWEPs"

SWEP.PrintName				= "Animation SWEP"
SWEP.Slot					= 4
SWEP.SlotPos				= 5
SWEP.DrawAmmo				= false

SWEP.Spawnable				= false

SWEP.DefaultHoldType = "normal"

SWEP.ViewModel 				= "models/weapons/v_357.mdl"
SWEP.WorldModel 			= "models/weapons/w_357.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight					= 1
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.deactivateOnMove		= 0

function SWEP:DrawWorldModel()
end

function SWEP:PreDrawViewModel()
    render.SetBlend(0)
end

function SWEP:PostDrawViewModel()
    render.SetBlend(1)
end

function SWEP:Initialize()
	self:SetHoldType(self.DefaultHoldType)

	if CLIENT then
		AnimationSWEP.GestureAngles[self:GetClass()] = self:GetGesture()
	end

	if SERVER then

		if PlayerConfig and PlayerConfig.NoDropWeapons then
			table.insert(PlayerConfig.NoDropWeapons, self:GetClass())
		end
	end
end

if CLIENT then
	-- Should be overidden in child file.
	function SWEP:GetGesture()
		return {}
	end

	function SWEP:PrimaryAttack()
	end
	function SWEP:SecondaryAttack()
	end
end

if SERVER then
	function SWEP:PrimaryAttack()
		ply = self.Owner

		if not ply:GetNWBool("animationStatus") then
			if not ply:Crouching() and ply:GetVelocity():Length() < 5 and not ply:InVehicle() then
				AnimationSWEP:Toggle(ply, true, self:GetClass(), self.deactivateOnMove)
			end
		else
			AnimationSWEP:Toggle(ply, false)
		end
	end

	function SWEP:SecondaryAttack()
		ply = self.Owner
		
		if not ply:GetNWBool("animationStatus") then
			if not ply:Crouching() and ply:GetVelocity():Length() < 5 and not ply:InVehicle() then
				AnimationSWEP:Toggle(ply, true, self:GetClass(), self.deactivateOnMove)
			end
		else
			AnimationSWEP:Toggle(ply, false)
		end
	end

	function SWEP:OnRemove()
		local ply = self.Owner
		AnimationSWEP:Toggle(ply, false)
	end

	function SWEP:OnDrop()
		local ply = self.Owner
		AnimationSWEP:Toggle(ply, false)
	end

	function SWEP:Holster()
		local ply = self.Owner
		AnimationSWEP:Toggle(ply, false)
		return true
	end
end