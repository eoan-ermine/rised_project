-- "addons\\combine_swep_pack\\lua\\entities\\stunstick_shot\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()
self.Entity:DrawModel()
//render.SetMaterial(Material("sprites/glow04_noz"))
//render.DrawSprite(self.Entity:GetPos(),math.Rand(150,80),25,White)
end

function ENT:OnRemove()
end

function ENT:Think()

end
