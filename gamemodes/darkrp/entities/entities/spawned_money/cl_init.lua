-- "gamemodes\\darkrp\\entities\\entities\\spawned_money\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
    self:DrawModel()
	
	if ply:GetEyeTrace().Entity:GetClass() ~= "spawned_money" then return end

    local Pos = self:GetPos()
    local Ang = self:GetAngles()

    surface.SetFont("marske4")
    local text = DarkRP.formatMoney(self:Getamount())
    local TextWidth = surface.GetTextSize(text)

    cam.Start3D2D(Pos + Ang:Up() * 0.82, Ang, 0.1)
        draw.WordBox(4, -TextWidth * 0.5, -9, text, "marske4", Color(0, 0, 0, 100), Color(255, 255, 255, 255))
    cam.End3D2D()

    Ang:RotateAroundAxis(Ang:Right(), 180)
end

function ENT:Think()
end
