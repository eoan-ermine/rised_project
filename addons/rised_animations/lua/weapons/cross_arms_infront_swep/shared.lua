-- "addons\\rised_animations\\lua\\weapons\\cross_arms_infront_swep\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
Only allowed to use in Addons by
​Mattis 'Mattzimann' Krämer
]]--

SWEP.Purpose				= "You can now cross your arms infront of your chest!"
SWEP.Instructions 			= "Click to cross your arms."

SWEP.Category 				= "EGM Animation SWEPs"
SWEP.PrintName				= "Cross Arms (Infront)"
SWEP.Spawnable				= true

SWEP.Base = "animation_swep_base"

if CLIENT then
	function SWEP:GetGesture()
		return {
            ["ValveBiped.Bip01_R_Forearm"] = Angle(-43.779933929443,-107.18412780762,15.918969154358),
            ["ValveBiped.Bip01_R_UpperArm"] = Angle(20.256689071655, -57.223915100098, -6.1269416809082),
            ["ValveBiped.Bip01_L_UpperArm"] = Angle(-28.913911819458, -59.408206939697, 1.0253102779388),
            ["ValveBiped.Bip01_R_Thigh"] = Angle(4.7250719070435, -6.0294013023376, -0.46876749396324),
            ["ValveBiped.Bip01_L_Thigh"] = Angle(-7.6583762168884, -0.21996378898621, 0.4060270190239),
            ["ValveBiped.Bip01_L_Forearm"] = Angle(51.038677215576, -120.44165039063, -18.86986541748),
            ["ValveBiped.Bip01_R_Hand"] = Angle(14.424224853516, -33.406204223633, -7.2624106407166),
            ["ValveBiped.Bip01_L_Hand"] = Angle(25.959447860718, 31.564517974854, -14.979378700256),
	    }
	end
end
