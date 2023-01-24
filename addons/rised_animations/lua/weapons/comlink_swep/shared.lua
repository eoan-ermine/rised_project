-- "addons\\rised_animations\\lua\\weapons\\comlink_swep\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
Only allowed to use in Addons by
​Mattis 'Mattzimann' Krämer
]]--

SWEP.Purpose				= "You can now Comlink to your friends!"
SWEP.Instructions 			= "Click to use your Comlink"

SWEP.Category 				= "EGM Animation SWEPs"
SWEP.PrintName				= "Comlink"
SWEP.Spawnable				= true

SWEP.Base = "animation_swep_base"

if CLIENT then
	function SWEP:GetGesture()
		return {
	        ["ValveBiped.Bip01_R_UpperArm"] = Angle(32.9448, -103.5211, 2.2273),
	        ["ValveBiped.Bip01_R_Forearm"] = Angle(-90.3271, -31.3616, -41.8804),
	        ["ValveBiped.Bip01_R_Hand"] = Angle(0,0,-24),
	    }
	end
end
