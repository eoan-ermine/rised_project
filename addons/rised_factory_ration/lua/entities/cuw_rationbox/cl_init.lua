-- "addons\\rised_factory_ration\\lua\\entities\\cuw_rationbox\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua");

function ENT:Initialize()	

end;

net.Receive("rationbox_showinfo", function()
	local box = net.ReadEntity()
	chat.AddText( Color( 51, 255, 65 ), "Данный набор для заправки рациона питания состоит из:")
	chat.AddText( Color( 51, 255, 65 ), "Вода: "..box:GetNWInt("BoxWater"))
	chat.AddText( Color( 51, 255, 65 ), "Мясо: "..box:GetNWInt("BoxMeat"))
	chat.AddText( Color( 51, 255, 65 ), "Энзимы: "..box:GetNWInt("BoxEnzymes"))
	if box:GetNWInt("BoxWater") == 8 && box:GetNWInt("BoxMeat") == 3 && box:GetNWInt("BoxEnzymes") == 6 then
		chat.AddText( Color( 51, 255, 65 ), "Рассчетное качество рациона от данного набора: ИДЕАЛЬНОЕ")
	elseif box:GetNWInt("BoxWater") < 4 || box:GetNWInt("BoxWater") > 12 || box:GetNWInt("BoxMeat") < 1 || box:GetNWInt("BoxMeat") > 6 || box:GetNWInt("BoxEnzymes") < 3 || box:GetNWInt("BoxEnzymes") > 9 then
		chat.AddText( Color( 51, 255, 65 ), "Рассчетное качество рациона от данного набора: УЖАСНОЕ")
	elseif box:GetNWInt("BoxWater") < 7 || box:GetNWInt("BoxWater") > 9 || box:GetNWInt("BoxMeat") < 2 || box:GetNWInt("BoxMeat") > 4 || box:GetNWInt("BoxEnzymes") < 5 || box:GetNWInt("BoxEnzymes") > 7 then
		chat.AddText( Color( 51, 255, 65 ), "Рассчетное качество рациона от данного набора: ПЛОХОЕ")
	elseif box:GetNWInt("BoxWater") < 8 || box:GetNWInt("BoxWater") > 8 || box:GetNWInt("BoxMeat") < 3 || box:GetNWInt("BoxMeat") > 3 || box:GetNWInt("BoxEnzymes") < 6 || box:GetNWInt("BoxEnzymes") > 6 then
		chat.AddText( Color( 51, 255, 65 ), "Рассчетное качество рациона от данного набора: СРЕДНЕЕ")
	end
end)