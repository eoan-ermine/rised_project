-- "addons\\led_screens\\lua\\entities\\gb_rp_sign\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

surface.CreateFont( "InfoRUS2", { font = "Enhanced Dot Digital-7", extended = true, size = 90, weight = 800, antialias = true })
surface.CreateFont( "InfoRUS3", { font = "Enhanced Dot Digital-7", extended = true, size = 50, weight = 800, antialias = true })

local font = "InfoRUS2"

local sizetable = {
	[3] = {350, 0.5},
	[4] = {470, -11.5},
	[5] = {590, -11.5},
	[6] = {710, 0.5},
	[7] = {830, 0.5},
	[8] = {950, 0.5},
}

function ENT:Initialize()
	
	self.OldWide = self:GetWide()

	self.frame = vgui.Create( "DPanel" )
	self.frame:SetSize( sizetable[self:GetWide()][1], 120 )
	self.frame.Text = self:GetText()
	self.frame.Type = self:GetType()
	self.frame.col = self:GetTColor()
	self.frame.damage = 0
	self.frame.appr = nil
	self.frame.FX = self:GetFX()
	self.frame.On = self:GetOn()
	self.frame.alfa = 0
	self.frame.speed = self:GetSpeed()
	self.frame:SetPaintedManually( true )
	self.frame.Paint = function(self,w,h)
		
		if self.On <= 0 then 
			if self.alfa < 1 then return end
			self.alfa = Lerp(FrameTime() * 5,self.alfa,0)
		else
			if self.FX > 0 then
				self.alfa = math.random(100,220)
			else
				self.alfa = 255
			end
		end
		
		surface.DisableClipping( false )
		surface.SetFont(font)
		local ww,hh = surface.GetTextSize(self.Text)
		local multiplier = self.speed * 100
		
		self.static = false
		
		if self.damage < CurTime() and self.On then
			if self.Type == 1 then
				
				local xs = (math.fmod(SysTime() * multiplier,w+ww)) - ww
				
				draw.DrawText(self.Text,font,xs,10,Color(self.col.x * 100, self.col.y * 100, self.col.z * 100, self.alfa),0)
			elseif self.Type == 2 then
				
				if !self.appr or self.appr > ww  then
					self.appr = -w
				else
					self.appr = math.Approach(self.appr, ww+w, FrameTime() * multiplier) 
				end
				
			draw.DrawText(self.Text,font,self.appr * -1,10,Color(self.col.x * 100, self.col.y * 100, self.col.z * 100, self.alfa),0)
			else
				if !self.appr then
					self.appr = 0
				end
				
				if w > ww then
					if self.Type == 3 then
						if self.appr < w-ww and !self.refl then
							self.appr = math.Approach(self.appr, ww+w, FrameTime() * multiplier) 
						else
							if self.appr <= 0 then
								self.refl = nil
							else
								self.refl = true
								self.appr = math.Approach(self.appr, 0, FrameTime() * multiplier) 
							end
						end
					else
						self.static = true
					end
				else
					if self.appr > w-ww-50 and !self.refl then
						self.appr = math.Approach(self.appr, w-ww-50, FrameTime() * multiplier) 
					else
						if self.appr >= 50 then
							self.refl = nil
						else
							self.refl = true
							self.appr = math.Approach(self.appr, 50, FrameTime() * multiplier) 
						end
					end
				end
				
				if self.static then
					draw.DrawText(self.Text,font,w/2,10,Color(self.col.x * 100, self.col.y * 100, self.col.z * 100, self.alfa),1)
				else
					draw.DrawText(self.Text,font,self.appr,10,Color(self.col.x * 100, self.col.y * 100, self.col.z * 100, self.alfa),0)
				end
			end
		else	
			draw.DrawText(self.Text,font,math.random(0,w-ww),10,Color(self.col.x * 100, self.col.y * 100, self.col.z * 100, math.random(0,255)),0)
		end
		surface.DisableClipping( true )
	end
end

function ENT:Draw()
	
	self:DrawModel()
	
	if self.frame then
		self.frame.Text = self:GetText()
		self.frame.Type = self:GetType()
		self.frame.col = self:GetTColor()
		self.frame.FX = self:GetFX()
		self.frame.On = self:GetOn()
		self.frame.damage = self:GetNWInt("LastDamaged")
		self.frame.speed = self:GetSpeed()
	end
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local hight = 12
	
	if self.OldWide != self:GetWide() then
		self.frame:SetSize( sizetable[self:GetWide()][1], 120 )
		self.OldWide = self:GetWide()
	end
	
	if self:GetWide() == 3 then
		hight = 6
	end
	
	cam.Start3D2D(Pos + Ang:Up() * 1.1 - Ang:Right() * hight + Ang:Forward() * sizetable[self:GetWide()][2], Ang, 0.1)
		self.frame:PaintManual()
	cam.End3D2D()

end