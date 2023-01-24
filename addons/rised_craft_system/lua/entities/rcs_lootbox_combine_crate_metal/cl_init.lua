-- "addons\\rised_craft_system\\lua\\entities\\rcs_lootbox_combine_crate_metal\\cl_init.lua"
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
				draw.DrawNonParsedSimpleText("Поиск" .. self.Dots, "Trebuchet18", w / 2, y + height / 4, Color(255, 195, 87, 255), 1, 1)
			end
		end
	end )
end
