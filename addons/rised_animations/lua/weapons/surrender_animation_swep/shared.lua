-- "addons\\rised_animations\\lua\\weapons\\surrender_animation_swep\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
Only allowed to use in Addons by
​Mattis 'Mattzimann' Krämer
]]--

SWEP.Purpose				= "You can now surrender!"
SWEP.Instructions 			= "Click to surrender."

SWEP.Category 				= "EGM Animation SWEPs"
SWEP.PrintName				= "Surrender"
SWEP.Spawnable				= true
SWEP.deactivateOnMove		= 110

SWEP.Base = "animation_swep_base"

if CLIENT then
	function SWEP:GetGesture()
		return {
	        ["ValveBiped.Bip01_L_Forearm"] = Angle(25,-65,25),
	        ["ValveBiped.Bip01_R_Forearm"] = Angle(-25,-65,-25),
	        ["ValveBiped.Bip01_L_UpperArm"] = Angle(-70,-180,70),
	        ["ValveBiped.Bip01_R_UpperArm"] = Angle(70,-180,-70),
	    }
	end
end
