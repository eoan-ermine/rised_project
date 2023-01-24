-- "addons\\bricks-crafting\\lua\\entities\\brickscrafting_treebase\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()
	self:DrawModel()

	if( BRICKSCRAFTING.CONFIG.WoodCutting[self.TreeType or ""] ) then
		if( BRICKSCRAFTING.CONFIG.WoodCutting[self.TreeType or ""].material ) then
			self:SetMaterial( BRICKSCRAFTING.CONFIG.WoodCutting[self.TreeType or ""].material )
		end		
		if( BRICKSCRAFTING.CONFIG.WoodCutting[self.TreeType or ""].color ) then
			self:SetColor( BRICKSCRAFTING.CONFIG.WoodCutting[self.TreeType or ""].color )
		end
	end
end