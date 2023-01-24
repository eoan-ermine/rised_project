-- "addons\\rised_animations\\lua\\weapons\\middlefinger_animation_swep\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
Only allowed to use in Addons by
​Mattis 'Mattzimann' Krämer
]]--

SWEP.Purpose				= "You can show the middle one!"
SWEP.Instructions 			= "Click to show the Middle one."

SWEP.Category 				= "EGM Animation SWEPs"
SWEP.PrintName				= "Middlefinger"
SWEP.Spawnable				= true
SWEP.deactivateOnMove		= 110

SWEP.Base = "animation_swep_base"

if CLIENT then
	function SWEP:GetGesture()
		return {
	        ["ValveBiped.Bip01_R_UpperArm"] = Angle(15,-55,-0),
	        ["ValveBiped.Bip01_R_Forearm"] = Angle(0,-55,-0),
	        ["ValveBiped.Bip01_R_Hand"] = Angle(20,20,90),
	        ["ValveBiped.Bip01_R_Finger1"] = Angle(20,-40,-0),
	        ["ValveBiped.Bip01_R_Finger3"] = Angle(0,-30,0),
	        ["ValveBiped.Bip01_R_Finger4"] = Angle(-10,-40,0),
	        ["ValveBiped.Bip01_R_Finger11"] = Angle(-0,-70,-0),
	        ["ValveBiped.Bip01_R_Finger31"] = Angle(0,-70,0),
	        ["ValveBiped.Bip01_R_Finger41"] = Angle(0,-70,0),
	        ["ValveBiped.Bip01_R_Finger12"] = Angle(-0,-70,-0),
	        ["ValveBiped.Bip01_R_Finger32"] = Angle(0,-70,0),
	        ["ValveBiped.Bip01_R_Finger42"] = Angle(0,-70,-0),
	    }
	end
end
