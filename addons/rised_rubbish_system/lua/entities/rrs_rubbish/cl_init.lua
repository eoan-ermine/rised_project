-- "addons\\rised_rubbish_system\\lua\\entities\\rrs_rubbish\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Initialize()
	self.NextDotsTime = 0
end

function ENT:Draw()
	self:DrawModel()

	hook.Add( "HUDPaint", "HUDPaint_DrawABox"..self:EntIndex(	), function()
		if IsValid(self) and self:GetOpeningPlayer() == LocalPlayer() then
			local dist = LocalPlayer():GetPos():DistToSqr(self:GetPos())
			if dist > 25000 then return end
			
			if self.NextDotsTime and CurTime() >= self.NextDotsTime then
				self.NextDotsTime = CurTime() + 0.5
				self.Dots = self.Dots or ""
				local len = string.len(self.Dots)
				local dots = {
					[0] = ".",
					[1] = "..",
					[2] = "...",
					[3] = ""
				}
				self.Dots = dots[len]
			end
		
			if self:GetIsOpening() and self:GetEndCheckTime() != 0 then
				
				self.Dots = self.Dots or ""
				local w = ScrW()
				local h = ScrH()
				local x, y, width, height = w / 2 - w / 10, h / 1.9, w / 5, h / 15
				local time = self:GetEndCheckTime() - self:GetStartCheckTime()
				local curtime = CurTime() - self:GetStartCheckTime()
				local status = math.Clamp(curtime / time, 0, 1)
				local BarWidth = status * (width - 16)
				local cornerRadius = math.Min(8, BarWidth / 3 * 2 - BarWidth / 3 * 2 % 2)

				draw.RoundedBox(4, x, y, width - 4, 2, Color(0, 0, 0, 150))
				draw.RoundedBox(4, x, y, BarWidth, 2, Color(255, 195, 87, 255))
				draw.DrawNonParsedSimpleText("Уборка" .. self.Dots, "Trebuchet18", w / 2, y + height / 4, Color(255, 195, 87, 255), 1, 1)
			end
		end
	end )

	local p = LocalPlayer()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)

	if p:GetEyeTrace().Entity == self and LocalPlayer():GetPos():Distance(self:GetPos()) < 150 and p:GetNWString("Player_WorkStatus") == "Уборщик" then
		cam.Start3D2D(Pos + Ang:Up() * 10, Angle( 0, p:EyeAngles().yaw - 90, 15 ), 0.1)
			surface.SetFont('Trebuchet18')

			local W, H = surface.GetTextSize( "Нажмите E чтобы собрать" )
			local Ww, H = surface.GetTextSize( "Мусор" )

			draw.SimpleText( "Мусор", "Trebuchet18", 20 - 0.5 * Ww, -20, Color(255, 195, 87, 255), 0, 0)
			draw.SimpleText( "Нажмите E чтобы собрать", "Trebuchet18", 20 - 0.5 * W, 0, Color(255, 195, 87, 255), 0, 0)
		cam.End3D2D()
	end
end
