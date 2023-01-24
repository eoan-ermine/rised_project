-- "addons\\rised_combine_entities\\lua\\entities\\combine_post\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel();

	local Pos = self:GetPos()
	local Ang = self:GetAngles()


	local title = "Пост Альянса"
	surface.SetFont("Digital")
	local titlewidth = surface.GetTextSize(title) * 0.5

	Ang:RotateAroundAxis( Ang:Up(), 0 )
	Ang:RotateAroundAxis( Ang:Forward(), 27 )

	cam.Start3D2D(Pos + Ang:Right() * -14 + Ang:Forward() * -2 + Ang:Up() * 40, Ang, 0.10)
		surface.SetDrawColor(0, 0, 0, 155)
		surface.DrawRect( -96, -24, 192, 48 )

		surface.SetTextColor( 255, 255, 255, 255 )
		surface.SetTextPos( -titlewidth, -8 )
		surface.SetFont("marske6")
		surface.DrawText(title)
	cam.End3D2D()
end