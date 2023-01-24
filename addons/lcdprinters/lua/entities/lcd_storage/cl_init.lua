-- "addons\\lcdprinters\\lua\\entities\\lcd_storage\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel();

	local Pos = self:GetPos()
	local Ang = self:GetAngles()


	local title = LCD.Config.StorageText
	surface.SetFont("Digital")
	local titlewidth = surface.GetTextSize(title) * 0.5

	Ang:RotateAroundAxis( Ang:Up(), 90 )

	cam.Start3D2D(Pos + Ang:Up() * 3.2, Ang, 0.11)
		surface.SetDrawColor(25, 25, 25, 255)
		surface.DrawRect( -96, -24, 192, 48 )

		surface.SetTextColor( 0, 255, 0, 255 )
		surface.SetTextPos( -titlewidth, -16 )
		surface.SetFont("Digital")
		surface.DrawText(title)
	cam.End3D2D()
end