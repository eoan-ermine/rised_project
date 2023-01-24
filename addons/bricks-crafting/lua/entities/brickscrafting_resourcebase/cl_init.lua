-- "addons\\bricks-crafting\\lua\\entities\\brickscrafting_resourcebase\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	if( BRICKSCRAFTING.CONFIG.Resources[self.ResourceType or ""] ) then
		if( BRICKSCRAFTING.CONFIG.Resources[self.ResourceType or ""].material ) then
			self:SetMaterial( BRICKSCRAFTING.CONFIG.Resources[self.ResourceType or ""].material )
		end		
		if( BRICKSCRAFTING.CONFIG.Resources[self.ResourceType or ""].color ) then
			self:SetColor( BRICKSCRAFTING.CONFIG.Resources[self.ResourceType or ""].color )
		end
	end
end

BCS_RESOURCE_ENTS = {}
function ENT:Initialize()
	BCS_RESOURCE_ENTS[self:EntIndex()] = self
end

function ENT:OnRemove()
	BCS_RESOURCE_ENTS[self:EntIndex()] = nil
end

hook.Add( "HUDPaint", "BCSHooks_HUDPaint_DrawResource", function()
	for k, v in pairs( BCS_RESOURCE_ENTS ) do
		local Distance = LocalPlayer():GetPos():DistToSqr( v:GetPos() )

		local AlphaMulti = 1-(Distance/BRICKSCRAFTING.LUACONFIG.Defaults.DisplayDist3D2D)

		if( Distance < BRICKSCRAFTING.LUACONFIG.Defaults.DisplayDist3D2D ) then
			local zOffset = 20
			local x = v:GetPos().x
			local y = v:GetPos().y
			local z = v:GetPos().z
			local pos = Vector(x,y,z+zOffset)
			local pos2d = pos:ToScreen()

			surface.SetAlphaMultiplier( AlphaMulti )
				draw.SimpleText( string.Comma(v:GetAmount() or 1) .. " " .. v.ResourceType, "BCS_Roboto_25", pos2d.x, pos2d.y, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			surface.SetAlphaMultiplier( 1 )
		end
	end
end )