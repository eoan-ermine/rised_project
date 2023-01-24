-- "lua\\entities\\base_att_ent\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Initialize()

end

function ENT:Draw()
    self:DrawModel()

    if GetConVar("cl_tfa_attachments_ents_name"):GetInt() == 0 then return end

    local offset = Vector(0, 0, 13)
    local ang = LocalPlayer():EyeAngles()
    local pos = self:LocalToWorld(self:OBBCenter()) + offset + ang:Up()

    ang:RotateAroundAxis( ang:Forward(), 90 )
    ang:RotateAroundAxis( ang:Right(), 90 )

    cam.Start3D2D(pos, Angle(0, ang.y, ang.z), 0.18)
        draw.SimpleTextOutlined(self.PrintName, "DermaLarge", 0, 0, Color(190,190,190), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(24, 24, 24))
    cam.End3D2D()
end