-- "addons\\rised_character_system\\lua\\entities\\character_creator_menuopen\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

--[[
 _____ _                          _                   _____                _             
/  __ \ |                        | |                 /  __ \              | |            
| /  \/ |__   __ _ _ __ __ _  ___| |_ ___ _ __ ______| /  \/_ __ ___  __ _| |_ ___  _ __ 
| |   | '_ \ / _` | '__/ _` |/ __| __/ _ \ '__|______| |   | '__/ _ \/ _` | __/ _ \| '__|
| \__/\ | | | (_| | | | (_| | (__| ||  __/ |         | \__/\ | |  __/ (_| | || (_) | |   
|_____/_| |_|\__,_|_|  \__,_|\___|\__\___|_|          \____/_|  \___|\__,_|\__\___/|_|   
                                                                                         
]]       

include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 85)	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		if (self:GetDTInt(1) == 0) then
			cam.Start3D2D(pos + ang:Up()*0, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.07)
				
				draw.SimpleText("Рита Андреева", "marske6", -20, -1100, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
				surface.SetDrawColor( 255, 255, 255, 50 )
				surface.DrawLine( -90, -1085, 50, -1085 )
				draw.SimpleText("Смена персонажа", "Trebuchet18", -20, -1075, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			cam.End3D2D();
		end
	end 
end 