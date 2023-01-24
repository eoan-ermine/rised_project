-- "addons\\vendingmachine\\lua\\darkrp_config\\vm_settings.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
	Author: Koz
	Steam: http://steamcommunity.com/profiles/76561197989811664
	Contact: mybbkoz@gmail.com

	License:
	You are free to use this software however you like; however,
	you cannot redistribute this code in any way without consent
	from the original author, Koz.
]]--

AddCSLuaFile() -- Do not edit this line.
vm = vm or {} -- Do not edit this line.
vm.config = {} -- Do not edit this line.

-- Configuration - Edit below this line

-- Toggle the soda effect on and off.
vm.config.enableheal		= false
vm.config.enablearmor		= false
vm.config.enablespeed		= false
vm.config.enablehunger		= true

-- Sounds annoying you? Disable them.
vm.config.enablesounds		= true

-- Disable vending machine when there is a cook.
-- vm.config.disablewithcook	= false

-- Controls how much soda will cost from vending machine.
vm.config.sodaprice		= 1
-- Controls how much health the soda will give.
vm.config.sodaheal			= 15
-- Controls how much energy the soda will give. (HungerMod Only)
vm.config.sodaenergy		= 5
-- Control how much armor the soda will give.
vm.config.sodasuit			= 10
-- Control the amount of time the speed boost will last.
vm.config.speedtimer		= 5
-- Controls the speed multiplier.
vm.config.speedmult		= 1.5

-- Spawn locations of your vending machines.
vm.config.mapspawn = {} -- Do not edit this line

--[[
	vm.config.mapspawn["map_name"] = {		-- Specifies map that Vending Machine spawns on.
		pos = Vector( 0, 0, 0 ),	-- Specifies the vector of the Vending Machine.
		ang = Angle( 0, 0, 0 )		-- Specifies the angle of the Vending Machine.
	}
]]--

vm.config.mapspawn["rp_downtown_v4c_v2"] = {
	{
		pos = Vector( -1780, -677, -148 ),
		ang = Angle( 0, -90, 0 )
	},
	{
		pos = Vector( 1319, -1100, -148 ),
		ang = Angle( 0, -180, 0 )
	},
	{
		pos = Vector( -1430, -7136, -148 ),
		ang = Angle( 0, 90, 0 )
	}
}