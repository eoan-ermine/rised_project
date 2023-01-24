-- "lua\\effects\\effect_cube\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self:SetModel("models/editor/cube_small.mdl")
	self.m_bVisible = true
end

function EFFECT:SetID(ID) self.m_id = ID end
function EFFECT:GetID() return self.m_id end

function EFFECT:OnRemove()
end

function EFFECT:SetOrigin(pos) self.m_origin = pos; self:SetPos(pos) end

function EFFECT:SetVisible(b) self.m_bVisible = b end

function EFFECT:Think()
	self:SetPos(self.m_origin)
	return !self.m_bRemove
end

local colText = Color(255,255,255,255)
function EFFECT:Render()
	if(!self.m_bVisible) then return end
	self:DrawModel()
	local id = self:GetID()
	if(id) then
		local ang = LocalPlayer():EyeAngles()
		local pos = self:GetPos() +Vector(0,0,30)
		ang:RotateAroundAxis(ang:Forward(),90)
		ang:RotateAroundAxis(ang:Right(),90)
		cam.Start3D2D(pos,Angle(0,ang.y,90),0.5)
			draw.DrawText(id,"default",2,2,colText,TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end
end