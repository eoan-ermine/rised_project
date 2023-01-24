-- "addons\\rised_medical_system\\lua\\autorun\\client\\rms_cl_virus.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

surface.CreateFont( "i_like_dis_font", { -- Font settings
	font = "TargetID",
	size = 20,
	weight = 800,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

net.Receive("VirusSystem-Client", function(len, pl)
	local value = net.ReadInt(16)
	local ply = net.ReadEntity()
	local lply = LocalPlayer()
	if value == 1 then
		 
		timer.Create("VirusSystem_" .. lply:GetNWString("VirusSystem_VirusName") .. "_" .. lply:Nick(), 1, 1, function()
			chat.AddText( "В крови найден вирус - ", Color( 255, 0, 0 ), ply:GetNWString("VirusSystem_VirusName") )
			chat.AddText( "Инкубационный период: ", Color( 255, 0, 0 ), ply:GetNWString("VirusSystem_Virus_IncubationTime"))
			chat.AddText( "Путь передачи: ", Color( 255, 0, 0 ), ply:GetNWString("VirusSystem_Virus_TransmissionRoutes"))
			chat.AddText( "Симптом: ", Color( 255, 0, 0 ), ply:GetNWString("VirusSystem_Virus_Symptom"))
			chat.AddText( "Мутация: ", Color( 255, 0, 0 ), ply:GetNWString("VirusSystem_Virus_Mutation"))
		end)
		
	elseif value == -1 then
		chat.AddText( "Вы излечились от вируса - ", Color( 255, 0, 0 ), ply:GetNWString("VirusSystem_VirusName") )
	elseif value == 50 then
		chat.AddText( "В крови найден вирус - ", Color( 255, 0, 0 ), ply:GetNWString("VirusSystem_VirusName") )
	end
end)