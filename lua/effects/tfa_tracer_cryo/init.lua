-- "lua\\effects\\tfa_tracer_cryo\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
EFFECT.Mat = Material("effects/laser_tracer")
EFFECT.Col1 = Color(255, 255, 255, 255) --Color(225,225,225,225)
EFFECT.Col2 = Color(65, 128, 255, 200)
EFFECT.Speed = 1024*3
EFFECT.TracerLength = 128

--[[---------------------------------------------------------
Init( data table )
-----------------------------------------------------------]]
function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	if IsValid(self.WeaponEnt) and self.WeaponEnt.GetMuzzleAttachment then
		self.Attachment = self.WeaponEnt:GetMuzzleAttachment()
	end

	-- Keep the start and end pos - we're going to interpolate between them
	self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self.EndPos = data:GetOrigin()
	self.Normal = (self.EndPos - self.StartPos):GetNormalized()
	self.Length = (self.EndPos - self.StartPos):Length()
	--self.Alpha = 255
	self.Life = 0
	self.MaxLife = self.Length / self.Speed
	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))
	self.CurPos = self.StartPos
end

--[[---------------------------------------------------------
THINK
-----------------------------------------------------------]]
function EFFECT:Think()
	self.Life = self.Life + FrameTime() * (1 / self.MaxLife)
	--self.Alpha = 255 * ( 1 - self.Life )

	return self.Life < 1
end

--[[---------------------------------------------------------
Draw the effect
-----------------------------------------------------------]]
local lerpedcol = Color(225, 225, 225, 225)

function EFFECT:Render()
render.SetMaterial(self.Mat)
lerpedcol.r = Lerp(self.Life, self.Col1.r, self.Col2.r)
lerpedcol.g = Lerp(self.Life, self.Col1.g, self.Col2.g)
lerpedcol.b = Lerp(self.Life, self.Col1.b, self.Col2.b)
lerpedcol.a = Lerp(self.Life, self.Col1.a, self.Col2.a)
local startbeampos = LerpVector(self.Life, self.StartPos, self.EndPos)
local endbeampos = LerpVector(self.Life + self.TracerLength / self.Length, self.StartPos, self.EndPos)
render.DrawBeam(startbeampos, endbeampos, 8, 0, 1, lerpedcol)
end
