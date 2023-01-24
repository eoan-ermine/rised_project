-- "lua\\entities\\item_gasmask\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

include('shared.lua')

function ENT:Initialize()
	
	self.Color = Color( 255, 255, 255, 255 )
	
end

function ENT:Draw()
	
	--self:DrawEntityOutline( 1 )
	self.Entity:DrawModel()

end