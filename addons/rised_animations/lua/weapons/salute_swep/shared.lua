-- "addons\\rised_animations\\lua\\weapons\\salute_swep\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
Only allowed to use in Addons by
​Mattis 'Mattzimann' Krämer
]]--

SWEP.Purpose				= "You can salute!"
SWEP.Instructions 			= "Click to salute."

SWEP.Category 				= "EGM Animation SWEPs"
SWEP.PrintName				= "Salute"
SWEP.Spawnable				= true
SWEP.deactivateOnMove		= 100

SWEP.Base = "animation_swep_base"

if CLIENT then
	function SWEP:GetGesture()
		return {
	        ["ValveBiped.Bip01_R_UpperArm"] = Angle(80, -95, -77.5),
	        ["ValveBiped.Bip01_R_Forearm"] = Angle(35, -125, -5),
	    }
	end
end
