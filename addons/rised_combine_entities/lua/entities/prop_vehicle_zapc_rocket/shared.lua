-- "addons\\rised_combine_entities\\lua\\entities\\prop_vehicle_zapc_rocket\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = 'anim'
ENT.Base = 'base_anim'

ENT.PrintName = 'Zaco\'s favorite APC rocket'
ENT.Author = 'Zaubermuffin'
ENT.Contact = 'zaubermuffin@gmail.com'
ENT.Purpose = 'wooosh wooosh'
ENT.Instructions = 'run. run faster.'

ENT.Spawnable = false
ENT.AdminSpawnable = false


function ENT:CanTool()
	return false
end