-- "addons\\bricks-crafting\\lua\\entities\\brickscrafting_garbage\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

hook.Add("HUDPaint", "BCSHooks_HUDPaint_GarbageCollecting", function()
	local CollectTime = LocalPlayer():GetNWInt( "BCS_GarbageTime", 0 )

	if( CollectTime >= CurTime() ) then
		local status = math.Clamp(1-((CollectTime-CurTime())/BRICKSCRAFTING.CONFIG.Garbage.CollectTime), 0, 1)
		BCS_DRAWING.DrawProgress( BRICKSCRAFTING.L("collectingGarbage"), status )
	end
end)

BCS_GARBAGE_ENTS = {}
function ENT:Initialize()
	BCS_GARBAGE_ENTS[self:EntIndex()] = self
end

function ENT:OnRemove()
	BCS_GARBAGE_ENTS[self:EntIndex()] = nil
end

hook.Add( "HUDPaint", "BCSHooks_HUDPaint_DrawGarbage", function()
	for k, v in pairs( BCS_GARBAGE_ENTS ) do
		local Distance = LocalPlayer():GetPos():DistToSqr( v:GetPos() )

		local AlphaMulti = 1-(Distance/BRICKSCRAFTING.LUACONFIG.Defaults.DisplayDist3D2D)

		if( Distance < BRICKSCRAFTING.LUACONFIG.Defaults.DisplayDist3D2D ) then
			local zOffset = 10+v:OBBMaxs().z
			local Pos = v:GetPos()
			local x = Pos.x
			local y = Pos.y
			local z = Pos.z
			local pos = Vector(x,y,z+zOffset)
			local pos2d = pos:ToScreen()

			surface.SetAlphaMultiplier( AlphaMulti )
				draw.SimpleText( v.PrintName or "", "BCS_Roboto_25", pos2d.x, pos2d.y, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
			surface.SetAlphaMultiplier( 1 )
		end
	end
end )