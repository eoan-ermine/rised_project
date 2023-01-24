-- "addons\\rised_animations\\lua\\weapons\\point_in_direction_swep\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
Only allowed to use in Addons by
​Mattis 'Mattzimann' Krämer
]]--

SWEP.Purpose				= "You can now point in a direction!"
SWEP.Instructions 			= "Click to point."

SWEP.Category 				= "EGM Animation SWEPs"
SWEP.PrintName				= "Point"
SWEP.Spawnable				= true
SWEP.deactivateOnMove		= 110

SWEP.Base = "animation_swep_base"

if CLIENT then
	function SWEP:GetGesture()
		return {
	        ["ValveBiped.Bip01_R_Finger2"] = Angle(4.151602268219, -52.963024139404, 0.42117667198181),
	        ["ValveBiped.Bip01_R_Finger21"] = Angle(0.00057629722869024, -58.618747711182, 0.001297949347645),
	        ["ValveBiped.Bip01_R_Finger3"] = Angle(4.151602268219, -52.963024139404, 0.42117667198181),
	        ["ValveBiped.Bip01_R_Finger31"] = Angle(0.00057629722869024, -58.618747711182, 0.001297949347645),
	        ["ValveBiped.Bip01_R_Finger4"] = Angle(4.151602268219, -52.963024139404, 0.42117667198181),
	        ["ValveBiped.Bip01_R_Finger41"] = Angle(0.00057629722869024, -58.618747711182, 0.001297949347645),
	        ["ValveBiped.Bip01_R_UpperArm"] = Angle(25.019514083862, -87.288040161133, -0.0012286090059206),
	    }
	end
end
