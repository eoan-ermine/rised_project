-- "addons\\bricks-crafting\\lua\\entities\\brickscrafting_benchbase\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()
	self:DrawModel()

	local Distance = LocalPlayer():GetPos():DistToSqr( self:GetPos() )

	if( Distance >= BRICKSCRAFTING.LUACONFIG.Defaults.DisplayDist3D2D ) then return end
	
	local AlphaMulti = 1-(Distance/BRICKSCRAFTING.LUACONFIG.Defaults.DisplayDist3D2D)

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	//TOP PANEL
	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Up(), 270)
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), 270)
	Ang:RotateAroundAxis(Ang:Forward(), -58)
	
	cam.Start3D2D(Pos + Ang:Up() * 37.1, Ang, 0.06)
		surface.SetAlphaMultiplier( AlphaMulti )
		surface.SetAlphaMultiplier( 1 )
	cam.End3D2D()
end

net.Receive( "BCS_Net_UseBench", function( len, ply )
	local BenchType = net.ReadString()
	
	if( not IsValid( BCS_BenchMenu ) ) then
		BCS_BenchMenu = vgui.Create( "brickscrafting_vgui_bench" )

		BCS_BenchMenu.BenchType = BenchType or ""
		BCS_BenchMenu:RefreshBCS()
		BCS_BenchMenu:RefreshInv()
	end
end )