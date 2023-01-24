-- "addons\\darkrpmodification\\lua\\entities\\rebel_resources\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua");

function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 270);
	ang:RotateAroundAxis(ang:Forward(), 90);	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 250 then	
		cam.Start3D2D(pos+ang:Up()*17, ang, 0.12)
			--draw.SimpleText("Оружие:", "marske4", -200, -10, Color(1, 241, 249, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1);
			--draw.SimpleText(GetGlobalInt("CombineResource_Weapons"), "marske4", 0, -10, Color(1, 241, 249, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1);
			
			--draw.SimpleText("Патроны:", "marske4", -200, 15, Color(1, 241, 249, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1);
			--draw.SimpleText(GetGlobalInt("CombineResource_Ammo"), "marske4", 0, 15, Color(1, 241, 249, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1);
			
			draw.SimpleText("Компоненты для крафта", "marske4", -200, 40, col_rebel, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1);
			--draw.SimpleText(GetGlobalInt("CombineResource_Micro"), "marske4", 0, 40, Color(1, 241, 249, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1);
			
			--draw.SimpleText("Энергия:", "marske4", -200, 65, Color(1, 241, 249, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1);
			--draw.SimpleText(GetGlobalInt("CombineResource_Energy"), "marske4", 0, 65, Color(1, 241, 249, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1);
		cam.End3D2D();
	end;
end;

