-- "addons\\lcdprinters\\lua\\entities\\lcd_printer\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
include("shared.lua")

surface.CreateFont( "Digital", {
	font = "Digital-7 Mono",
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = true,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "Jura", {
	font = "Jura Medium",
	size = 12,
	weight = 500,
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

surface.CreateFont( "Jura2", {
	font = "Jura Medium",
	size = 20,
	weight = 500,
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


function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is need for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end


function surface.DrawTexturedRectRotatedPoint( x, y, w, h, rot, x0, y0 )

	local c = math.cos( math.rad( rot ) )
	local s = math.sin( math.rad( rot ) )

	local newx = y0 * s - x0 * c
	local newy = y0 * c + x0 * s

	surface.DrawTexturedRectRotated( x + newx, y + newy, w, h, rot )

end



local thermometerIcon = Material( "lcdprinters/thermometer.png" )

local overflowIcon = Material( "lcdprinters/printer-alert.png" )

local armorIcon = Material( "lcdprinters/shield.png" )

local storageIcon = Material( "lcdprinters/harddisk.png" )


local fan11 = Material( "lcdprinters/fan1-1.png" )

local fan12 = Material( "lcdprinters/fan1-2.png" )

local fan21 = Material( "lcdprinters/fan2-1.png" )

local fan22 = Material( "lcdprinters/fan2-2.png" )

local eight4 = "8888"



local fadedRed = Color( 35, 25, 25, 255 )

local Red = Color( 255, 0, 0, 255 )


local fadedGreen = Color( 25, 35, 25, 255 )

local Green = Color( 0, 255, 0, 255 )


local fadedBlue = Color( 25, 25, 35, 255 )

local Blue = Color( 0, 0, 255, 255 )

function ENT:Draw()
	local ply = LocalPlayer()

	local Pos = self:GetPos()

	local Ang = self:GetAngles()

	self:DrawModel()
	self:SetColor( Color( 255, 255, 255, 255 ) )

	if Pos:Distance( ply:GetPos() ) > LCD.Config.DrawDistance then return end

	local PrinterStoredMoney = self:GetNWInt( "StoredMoney", 0) -- AIZ26 for Error
	local PrinterTemperature = self:GetNWInt( "StoredTemp", 0) -- AIZ26 for Error
	local PrinterExplosion = self:GetNWInt( "StoredExpl", 0)
	local PrinterCoolant = self:GetNWInt( "StoredCool", 0)
	local PrinterFan = self:GetNWBool( "StoredFan", false)
	local PrinterScreen = self:GetNWBool( "StoredScreen", false)
	local PrinterStorage = self:GetNWBool( "StoredStorage", false)
	local PrinterArmor = self:GetNWBool( "StoredArmor", false)
	local PrinterCountdown = self:GetNWInt( "StoredCount", 0)
	local PrinterMode = self:GetNWInt( "StoredMode", 0)

	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")


	local title = LCD.Config.TitleText
	local ownedby = LCD.Config.OwnershipText .. owner

	surface.SetFont("Jura2")
	local titlewidth = surface.GetTextSize(title) * 0.5
	local ownedbywidth = surface.GetTextSize(ownedby) * 0.5
	surface.SetFont("Jura")
	local thermometerwidth = surface.GetTextSize(LCD.Config.ThermometerText) * 0.5
	local timerwidth = surface.GetTextSize(LCD.Config.TimerText) * 0.5
	local cashwidth = surface.GetTextSize(LCD.Config.CashText) * 0.5
	local coolantwidth = surface.GetTextSize(LCD.Config.CoolantText) * 0.5
	local coolantwidth1 = surface.GetTextSize(LCD.Config.CoolantText1) * 0.5
	local coolantwidth2 = surface.GetTextSize(LCD.Config.CoolantText2) * 0.5
	local coolantwidth3 = surface.GetTextSize(LCD.Config.CoolantText3) * 0.5


	if PrinterMode == 0 then
		fadecolor = fadedGreen
		normcolor = Green
	elseif PrinterMode == 1 then
		fadecolor = fadedRed
		normcolor = Red
	end

	Ang:RotateAroundAxis(Ang:Up(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 10.8, Ang, 0.11)



		-- Coolant Bar



		local trapezoid = {
		{ x = -42, y = 70 },
		{ x = 42, y = 70 },
		{ x = 42, y = 90 },
		{ x = 0, y = 100 },
		{ x = -42, y = 90 },

		}

		surface.SetDrawColor( 35, 35, 35, 255 )
		draw.NoTexture()
		surface.DrawPoly(trapezoid)
		surface.SetDrawColor( 20, 20, 20, 255 )


		surface.SetDrawColor( fadecolor )	
		local increment = -47
		local increment3 = 15
		for i=0,4 do
			increment = increment + 8
			increment3 = increment3 + 2
			surface.DrawRect( increment, 71, 6, increment3 )
		end
		increment3 = 27
		for i=0,4 do
			increment = increment + 8
			increment3 = increment3 - 2
			surface.DrawRect( increment, 71, 6, increment3 )
		end

		local increment = -47
		local increment2 = 0
		local increment3 = 15

		surface.SetDrawColor( normcolor )
		for i=0,4 do
			increment = increment + 8
			increment2 = increment2 + 2
			increment3 = increment3 + 2
			if PrinterCoolant >= increment2 then
				surface.DrawRect( increment, 71, 6, increment3 )
			end
		end

		local increment3 = 27

		for i=0,4 do
			increment = increment + 8
			increment2 = increment2 + 2
			increment3 = increment3 - 2
			if PrinterCoolant >= increment2 then
				surface.DrawRect( increment, 71, 6, increment3 )
			end
		end



		-- Print Timer



		local trapezoid2 = {
		{ x = -65, y = 5 },
		{ x = -65, y = 35 },
		{ x = -120, y = 35 },
		{ x = -130, y = 20 },
		{ x = -120, y = 5 },
		}

		surface.SetFont( "Digital" )

		surface.SetDrawColor( 25, 25, 25, 255 )
		surface.DrawPoly(trapezoid2)
		surface.SetTextPos( -122, 5 )
		surface.SetTextColor( fadecolor )
		surface.DrawText( eight4 )
		draw.SimpleText( PrinterCountdown, "Digital", -67, 5, normcolor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )



		-- Storage 



		local trapezoid3 = {
		{ x = 130, y = 20 },
		{ x = 120, y = 35 },
		{ x = 65, y = 35 },
		{ x = 65, y = 5 },
		{ x = 120, y = 5 },
		}

		surface.SetFont( "Digital" )

		surface.SetDrawColor( 25, 25, 25, 255 )
		surface.DrawPoly(trapezoid3)
		surface.SetTextPos( 67, 5 )
		surface.SetTextColor( fadecolor )	
		surface.DrawText( eight4 )
		draw.SimpleText( PrinterStoredMoney, "Digital", 123, 5, normcolor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
		


		-- Temp Gauge



		surface.SetDrawColor( 20, 20, 20, 155 )
		draw.NoTexture()
		draw.Circle( 0, 25, 65, 50 )
		surface.SetDrawColor( 20, 20, 20, 255 )
		draw.NoTexture()
		draw.Circle( 0, 20, 67, 50 )
		surface.SetDrawColor( 25, 25, 25, 255 )
		draw.NoTexture()
		draw.Circle( 0, 20, 65, 50 )

		local xl, yt = -50, -30
		local rad = 100 / 2
		local pi = math.pi

		local numcnt = math.ceil( 50 / 5 )
		local step = (3 * (pi / 2)) / numcnt
		local offset = 3 * (pi / 4)
		local ang, x, y, ismajor

		for i=0,numcnt do
			ang = (i * step) + offset

			x = xl + rad + (math.cos( ang ) * (rad))
			y = yt + rad + (math.sin( ang ) * (rad))

			draw.SimpleText(
				tostring( i * 10 ),
				"Jura",
				x, y,
				color_numbers,
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
			)
		end

		local barcnt = numcnt * 4
		step = (3 * (pi / 2)) / barcnt

		surface.SetDrawColor(Color(255,255,255,255) )

		for i=0,barcnt do
			ismajor = (i % 4) == 0
			ang = (i * step) + offset

			x = xl + rad + (math.cos( ang ) * (rad + 12))
			y = yt + rad + (math.sin( ang ) * (rad + 12))

			surface.DrawTexturedRectRotated( 
				x, y, 
				ismajor and 5 or 5, 
				ismajor and 2 or 1, 
				math.deg( -ang )
			)
		end
		surface.SetDrawColor( normcolor )
		local ang = (-45 - (2.7 * PrinterTemperature))
		surface.DrawTexturedRectRotatedPoint( 0, 20, 2, 64, ang, 0, 32 )



		-- Temp Warning



		if LCD.Config.WarningPosition == false then
			if PrinterTemperature < LCD.Config.TempWarning then
				surface.SetDrawColor( fadecolor )
			else
				surface.SetDrawColor( normcolor )
			end
			surface.SetMaterial( thermometerIcon )
			surface.DrawTexturedRect( -24, 55, 24, 24 )
		else
			if PrinterTemperature < LCD.Config.TempWarning then
				surface.SetDrawColor( fadecolor )
			else
				surface.SetDrawColor( normcolor )
			end
			surface.SetMaterial( thermometerIcon )
			surface.DrawTexturedRect( -70, 65, 24, 24 )
		end


		-- OVERFLOW INDICATOR


		local effectivestorage
		if PrinterStorage == true then
			effectivestorage = LCD.Config.UpgradeMaximum
		else
			effectivestorage = LCD.Config.PrintMaximum
		end

		if LCD.Config.WarningPosition == false then
			if PrinterStoredMoney < effectivestorage then
				surface.SetDrawColor( fadecolor )
			else
				surface.SetDrawColor( 0, 255, 0, 255 )
			end
			surface.SetMaterial( overflowIcon )
			surface.DrawTexturedRect( 0, 55, 24, 24 )
		else
			if PrinterStoredMoney < effectivestorage then
				surface.SetDrawColor( 25, 35, 25, 255 )
			else
				surface.SetDrawColor( normcolor )
			end
			surface.SetMaterial( overflowIcon )
			surface.DrawTexturedRect( 46, 65, 24, 24 )
		end


		-- ARMOR INDICATOR


		if PrinterArmor then
			surface.SetDrawColor( normcolor )
			surface.SetMaterial( armorIcon )
			surface.DrawTexturedRect( -110, -138, 19, 23 )
		end



		-- STORAGE INDICATOR



		if PrinterStorage then
			surface.SetDrawColor( normcolor )
			surface.SetMaterial( storageIcon )
			surface.DrawTexturedRect( 100, -138, 19, 23 )
		end


		-- The text bit



		surface.SetTextColor( 255, 255, 255, 255 )
		draw.WordBox( 4, -titlewidth, -140, title, "Jura2", Color( 25, 25, 25, 255 ), Color( 255, 255, 255, 255 ) )
		draw.WordBox( 4, -ownedbywidth, -110, ownedby, "Jura2", Color( 25, 25, 25, 255 ), Color( 255, 255, 255, 255 ) )
		surface.SetFont("Jura")
		surface.SetTextPos( -thermometerwidth, 25 )
		surface.DrawText(LCD.Config.ThermometerText)
		surface.SetTextColor(Color( 0, 0, 0, 255 ))
		surface.SetTextPos( -100 - timerwidth, 35 )
		surface.DrawText(LCD.Config.TimerText)
		surface.SetTextPos( 100 - cashwidth, 35 )
		surface.DrawText(LCD.Config.CashText)
		surface.SetTextPos( -coolantwidth, 110 )
		surface.DrawText(LCD.Config.CoolantText)
		surface.SetTextPos( -40 -coolantwidth1, 90 )
		surface.DrawText(LCD.Config.CoolantText1)
		surface.SetTextPos( -coolantwidth2, 98 )
		surface.DrawText(LCD.Config.CoolantText2)
		surface.SetTextPos( 40 -coolantwidth3, 90 )
		surface.DrawText(LCD.Config.CoolantText3)
	cam.End3D2D()


	-- Side bit


	Ang:RotateAroundAxis( Ang:Forward(), 90 )

	cam.Start3D2D(Pos + Ang:Up() * 16.3, Ang, 0.11)
		if PrinterScreen == true then
			surface.SetDrawColor(25, 25, 25, 255)
			surface.DrawRect( -107, -42, 156, 32)
			surface.SetDrawColor(20, 20, 20, 255)
			surface.DrawOutlinedRect( -107, -42, 156, 32)

			surface.SetTextColor( fadecolor )
			surface.SetTextPos( -106, -40 )
			surface.SetFont("Digital")

			surface.DrawText("0000 000 00")

			draw.SimpleText( PrinterStoredMoney, "Digital", -50, -40, normcolor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
			draw.SimpleText( PrinterTemperature, "Digital", 6, -40, normcolor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
			draw.SimpleText( PrinterCoolant, "Digital", 48, -40, normcolor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
		end
	cam.End3D2D()



	cam.Start3D2D(Pos + Ang:Up() * 17, Ang, 0.11)
		-- UPGRADE BITS

		-- FAN

		if PrinterFan == true then

			if LCD.Config.AlternateFan == true then
				surface.SetMaterial( fan21 )
			else
				surface.SetMaterial( fan11 )
			end

			surface.DrawTexturedRect( 75, -65, 64, 64 )

			if LCD.Config.AlternateFan == true then
				surface.SetMaterial( fan22 )
			else
				surface.SetMaterial( fan12 )
			end

			surface.DrawTexturedRectRotated( 107, -33, 64, 64, CurTime() * LCD.Config.FanSpeed)
		
		end
	cam.End3D2D()
end

function ENT:Think()
end
