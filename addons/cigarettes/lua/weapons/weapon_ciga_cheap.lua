-- "addons\\cigarettes\\lua\\weapons\\weapon_ciga_cheap.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-- Cigarette SWEP by Mordestein (based on Vape SWEP by Swamp Onions)

if CLIENT then
	include('weapon_ciga/cl_init.lua')
else
	include('weapon_ciga/shared.lua')
end

SWEP.PrintName = "Сигарета"

SWEP.Instructions = "LMB: deshevo kurit"

SWEP.ViewModel = "models/mordeciga/mordes/ciga.mdl"
SWEP.WorldModel = "models/mordeciga/mordes/ciga.mdl"

SWEP.cigaID = 3

SWEP.cigaAccentColor = Vector(1,1,1.1)

SWEP.Weight = 0.02
