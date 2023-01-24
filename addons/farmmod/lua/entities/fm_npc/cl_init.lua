-- "addons\\farmmod\\lua\\entities\\fm_npc\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal




include("shared.lua")

surface.CreateFont( "crop_font_17", {
	font = "Lato",
	size = 17,
	weight = 500,
	antialias = true
} )

surface.CreateFont( "crop_font_19", {
	font = "Lato",
	size = 28,
	weight = 500,
	antialias = true
} )

local ahshop3_icon1 = Material("materials/farm/icon.png")

function ENT:Draw()

	self:DrawModel()

	local leng = self:GetPos():Distance(EyePos())
	local clam = math.Clamp(leng, 0, 255 )
	local main = (255 - clam)
	
	if (main <= 0) then return end
	self.price = 0
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "fm_crate" then
			if !(self:GetPos():Distance(v:GetPos()) > fastfarm2.NpcSellDistance) then 
				self.price = ((self.price or 0) + v:GetValue())
			end
		end
	end
	
	local value = self.price or 0
	local ahAngle = self:GetAngles()
	local AhEyes = LocalPlayer():EyeAngles()
	
	ahAngle:RotateAroundAxis(ahAngle:Forward(), 90)
	ahAngle:RotateAroundAxis(ahAngle:Right(), -90)		
	
	cam.Start3D2D(self:GetPos()+self:GetUp()*79, Angle(0, AhEyes.y-90, 90), 0.08)
	
		surface.SetDrawColor( 150, 150, 150, 70 + main )
		draw.SimpleText( "Фермер", "crop_font_19", -45, 23, Color( 168, 167, 168, 70 + main ), 0, 1 )
		draw.SimpleText( "Я заплачу вам "..value.."T.", "crop_font_17", -60, 51, Color( 113, 111, 113, 70 + main ), 0, 1 )
		surface.SetDrawColor( Color(77, 75, 77 , 70 + main) )
		surface.DrawOutlinedRect( -80,10,160,60 )
		
	cam.End3D2D()	
	
end		
