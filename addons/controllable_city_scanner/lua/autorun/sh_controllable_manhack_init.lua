-- "addons\\controllable_city_scanner\\lua\\autorun\\sh_controllable_manhack_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

ControllableScanner = ControllableScanner or {}

ControllableScanner.INSTANCE = {}
ControllableScanner.INSTANCE.SHARED = 1
ControllableScanner.INSTANCE.SERVER = 2
ControllableScanner.INSTANCE.CLIENT = 3

--Easier way to include files
function ControllableScanner.Include(path, instance)
	if SERVER then
		if instance == ControllableScanner.INSTANCE.SHARED or instance == ControllableScanner.INSTANCE.CLIENT then
			AddCSLuaFile(path)
		end

		if instance == ControllableScanner.INSTANCE.SHARED or instance == ControllableScanner.INSTANCE.SERVER then
			include(path)
		end
	end

	if CLIENT and (instance == ControllableScanner.INSTANCE.SHARED or instance == ControllableScanner.INSTANCE.CLIENT) then
		include(path)
	end
end

ControllableScanner.Include("controllable_scanner/sh_convars.lua", ControllableScanner.INSTANCE.SHARED)

ControllableScanner.Include("controllable_scanner/sh_misc.lua", ControllableScanner.INSTANCE.SHARED)
ControllableScanner.Include("controllable_scanner/sv_misc.lua", ControllableScanner.INSTANCE.SERVER)

ControllableScanner.Include("controllable_scanner/sh_hook_override.lua", ControllableScanner.INSTANCE.SHARED)

ControllableScanner.Include("controllable_scanner/sh_ammo_types.lua", ControllableScanner.INSTANCE.SHARED)
ControllableScanner.Include("controllable_scanner/cl_ammo_types.lua", ControllableScanner.INSTANCE.CLIENT)

ControllableScanner.Include("controllable_scanner/cl_kill_icons.lua", ControllableScanner.INSTANCE.CLIENT)
