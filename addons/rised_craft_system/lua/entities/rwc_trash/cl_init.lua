-- "addons\\rised_craft_system\\lua\\entities\\rwc_trash\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

local line = 0

function ENT:Draw()

	local p = LocalPlayer()

    self:DrawModel()

	local Pos = self:GetPos()

	local Ang = self:GetAngles()
	
	Ang:RotateAroundAxis(Ang:Up(), 90)

	if p:GetEyeTrace().Entity == self and LocalPlayer():GetPos():Distance(self:GetPos()) < 150 and GAMEMODE.Rebels[p:Team()] then

		cam.Start3D2D(Pos + Ang:Up(), Angle( 0, p:EyeAngles().yaw - 90, 15 ), 0.1)

			surface.SetFont('Trebuchet18')

			local W, H = surface.GetTextSize( "Нажмите E чтобы собрать" )

			local Ww, H = surface.GetTextSize( "Мусор" )

			draw.SimpleText( "Мусор", "Trebuchet18", 20 - 0.5 * Ww, -20, Color(255, 195, 87, 255), 0, 0)

			draw.SimpleText( "Нажмите E чтобы собрать", "Trebuchet18", 20 - 0.5 * W, 0, Color(255, 195, 87, 255), 0, 0)

		cam.End3D2D()

	end

end

local dots = {

	[0] = ".",
	
	[1] = "..",
	
	[2] = "...",
	
	[3] = ""
	
}

local dodik = 0

local function Trash_Bar3()

	local p = LocalPlayer()

	local w = ScrW()

	local h = ScrH()
	
	local x, y, width, height = w / 2 - w / 10, h / 1.9, w / 5, h / 15
	
	if (!p.StartedTrash3) or !p:Alive() then return end

	if p:GetEyeTrace().Entity:GetClass() ~= "rwc_trash" and (!p.StartedTrash3) then line = 0 dodik = 0 if timer.Exists('TTS') then timer.Stop('TTS') end return end

	local x,y = ScrW() / 2, ScrH() / 2
	
	if line < width - 4 and p:GetEyeTrace().Entity:GetClass() == "rwc_trash" then

		line = line + 0.15 --0.1

		draw.RoundedBox(4, x - 0.5 * width, y, width - 4, 2, Color(40, 40, 40, 255))

		draw.RoundedBox(4, x - 0.5 * width, y, line, 2, Color(255, 195, 87, 255))
		
		draw.DrawNonParsedSimpleText("Поиск" .. dots[math.Round(dodik)], "Trebuchet18", w / 2, y + height / 4, Color(255, 195, 87, 255), 1, 1)

		dodik = dodik + 0.01

		if dodik > 3 then dodik = 0 end
		
	elseif line < 360 and p:GetEyeTrace().Entity:GetClass() ~= "rwc_trash" then

		line = 0

		dodik = 0

		timer.Stop('TTS')
		
		p.StartedTrash3 = false
		
	else

		line = 0

		dodik = 0

		timer.Stop('TTS')
		
		p.StartedTrash3 = false

		timer.Create('NewTrash', 0.1, 1, function()

			net.Start('TimeToPay_Rebel')

			net.SendToServer()

		end)

		return
		
    end

end

hook.Add("HUDPaint", 'Bar3', Trash_Bar3)

local function TrashUI()

	local p = net.ReadEntity()

	local time = tonumber(net.ReadString())

	tdelay = time

	endTime = time + CurTime()

	p.StartedTrash3 = true

	if p.StartedTrash3 then

		timer.Create('TTS', 1, 0, function() p:GetEyeTrace().Entity:EmitSound( "physics/cardboard/cardboard_box_impact_soft" .. math.random(1, 7) .. ".wav", 75, 100, 1, CHAN_AUTO ) end)

	else

		timer.Stop('TTS')

	end

end


net.Receive('TrashStarted_Rebel', TrashUI)