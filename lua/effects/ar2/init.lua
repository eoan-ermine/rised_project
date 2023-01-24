-- "lua\\effects\\ar2\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Position = self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)
	self.Forward = data:GetNormal()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	self.Up = self.Angle:Up()
	local AddVel = self.WeaponEnt:GetOwner():GetVelocity()
	local emitter = ParticleEmitter(self.Position)
	for i=1,2 do 
		local particle = emitter:Add("effects/combinemuzzle"..math.random(1,2), self.Position + 100/self.Forward)
		particle:SetVelocity(350*self.Forward + 1.1*AddVel)
		particle:SetDieTime(0.08)
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(4*i)
		particle:SetEndSize(2*i)
		particle:SetRoll(math.Rand(120,480))
		particle:SetRollDelta(math.Rand(-1,1))
		particle:SetColor(255,255,255)	
		particle:SetAirResistance(120)
	end
	for j = 2,3 do
	for i = -1,1,2 do 
		local particle = emitter:Add( "effects/combinemuzzle"..math.random(2,2), self.Position + 2 * self.Forward - 2 * j * i * self.Right )
		particle:SetVelocity( 60 * j * i * self.Right + AddVel )
		particle:SetGravity( AddVel )
		particle:SetDieTime( 0.08 )
		particle:SetStartAlpha( 250 )
		particle:SetStartSize( j/2 )
		particle:SetEndSize( 2 * j )
		particle:SetRoll( math.Rand( 180, 480 ) )
		particle:SetRollDelta( math.Rand( -1, 1 ) )
		particle:SetColor( 255, 255, 255 , 255)	
	end
	end
	emitter:Finish()
	
	local dlight = DynamicLight(self.WeaponEnt:EntIndex())

	if (dlight) then
		dlight.pos = self.Position + self.Angle:Up() * 3 + self.Angle:Right() * -2
		dlight.r = 255
		dlight.g = 192
		dlight.b = 64
		dlight.brightness = 5
		dlight.Size = math.Rand(32, 64)
		dlight.Decay = math.Rand(32, 64) / 0.05
		dlight.DieTime = CurTime() + 0.05
	end
	
	
end
function EFFECT:Think()
	return false
end
function EFFECT:Render()
end