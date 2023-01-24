-- "addons\\led_screens\\lua\\weapons\\gmod_tool\\stools\\ledscreen.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TOOL.Category		= "Construction"
TOOL.Name			= "LED screens"
TOOL.Command		= nil
TOOL.ConfigName		= ""

local TextBox = {}
local slider = {}
local slider2 = {}
local slider3 = {}
local frame = {}
TOOL.ClientConVar[ "text" ] = ""
TOOL.ClientConVar[ "type" ] = 1
TOOL.ClientConVar[ "speed" ] = 1.5
TOOL.ClientConVar[ "wide" ] = 6
TOOL.ClientConVar[ "fx" ] = 0
TOOL.ClientConVar[ "wire" ] = 0
TOOL.ClientConVar[ "r"] = 255
TOOL.ClientConVar[ "g" ] = 200
TOOL.ClientConVar[ "b" ] = 0

if (SERVER) then
	CreateConVar('sbox_maxledscreens', 5)
end

cleanup.Register("ledscreens")

TOOL.Information = {
	{ name = "left" },
	{ name = "right" }
}

if (CLIENT) then
	language.Add("Tool.ledscreen.name", "LED screen")
	language.Add("Tool.ledscreen.desc", "Create a LED panel")	

	language.Add("Tool.ledscreen.left", "Spawn a LED panel");
	language.Add("Tool.ledscreen.right", "Update LED panel");
	language.Add("Tool.ledscreen.reload", "Copy LED panel's settings");
	
	language.Add("Undone.ledscreens", "Undone ledscreen")
	language.Add("Undone_ledscreens", "Undone ledscreen")
	language.Add("Cleanup.ledscreens", "ledscreens")
	language.Add("Cleanup_ledscreens", "ledscreens")
	language.Add("Cleaned.ledscreens", "Cleaned up all ledscreens")
	language.Add("Cleaned_ledscreens", "Cleaned up all ledscreens")
	
	language.Add("SBoxLimit.ledscreens", "You've hit the ledscreen limit!")
	language.Add("SBoxLimit_ledscreens", "You've hit the ledscreen limit!")
end

local function GetConvars(self)
	local type = tonumber(self:GetClientInfo("type"))
	if !isnumber(type) then type = 1 end
	
	local speed = tonumber(self:GetClientInfo("speed"))
	if !isnumber(speed) then speed = 1.5 end
	
	local wide = tonumber(self:GetClientInfo("wide"))
	if !isnumber(wide) then wide = 6 end
	
	local fx = tonumber(self:GetClientInfo("fx"))
	if !isnumber(fx) then fx = 0 end
	
	local r, g, b = tonumber(self:GetClientInfo("r")), tonumber(self:GetClientInfo("g")), tonumber(self:GetClientInfo("b"))
	if !isnumber(r) or !isnumber(g) or !isnumber(b) then r, g, b = 255, 200, 100 end
	
	return math.Clamp(type, 1, 4), math.Clamp(speed, 1, 10), math.Clamp(wide, 3, 8), math.Clamp(fx, 0, 1), r, g, b
end

function TOOL:LeftClick(tr)
	if (tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end

	local Ply = self:GetOwner()
	local centerpos = {
		[3] = {18, 0},
		[4] = {11.5, 6},
		[5] = {18, 6},
		[6] = {36, 6},
		[7] = {42, 6},
		[8] = {48, 6},
	}
	
	local type, speed, wide, fx, r, g, b = GetConvars(self)
	
	local angle = tr.HitNormal:Angle()
	local SpawnPos = tr.HitPos + angle:Right() * centerpos[wide][1] - angle:Up() * centerpos[wide][2]
	
	if !self:GetWeapon():CheckLimit("ledscreens") then return false end
	
	local TextScreen
	if tonumber(self:GetClientInfo("wire")) > 0 then
		TextScreen = ents.Create("gb_rp_sign_wire")
	else
		TextScreen = ents.Create("gb_rp_sign")
	end
	TextScreen:SetPos(SpawnPos)
	TextScreen:Spawn()
	
	angle:RotateAroundAxis(tr.HitNormal:Angle():Right(), -90)
	angle:RotateAroundAxis(tr.HitNormal:Angle():Forward(), 90)
	TextScreen:SetAngles(angle)
	TextScreen:SetText(self:GetClientInfo("text"))
	TextScreen:SetType(type)
	TextScreen:SetSpeed(speed)
	TextScreen:SetWide(wide)
	TextScreen:SetModel("models/squad/sf_plates/sf_plate1x"..wide..".mdl")
	TextScreen:SetTColor(Vector(r/100, g/100, b/100))
	TextScreen:SetFX(fx)
	TextScreen:Activate()
	local Phys = TextScreen:GetPhysicsObject()
	Phys:EnableMotion( false )
	
	undo.Create("ledscreens")

	undo.AddEntity(TextScreen)
	undo.SetPlayer(Ply)
	undo.Finish()

	Ply:AddCount("ledscreens", TextScreen)
	Ply:AddCleanup("ledscreens", TextScreen)

	return true
end

function TOOL:RightClick(tr)
	if (tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end

	local TraceEnt = tr.Entity
	
	local type, speed, wide, fx, r, g, b = GetConvars(self)
	
	if (TraceEnt:IsValid() and TraceEnt:GetClass() == "gb_rp_sign") then
		TraceEnt:SetText(self:GetClientInfo("text"))
		TraceEnt:SetType(type)
		TraceEnt:SetSpeed(speed)
		TraceEnt:SetWide(wide)
		TraceEnt:SetFX(fx)
		TraceEnt:SetModel("models/squad/sf_plates/sf_plate1x"..wide..".mdl")
		TraceEnt:SetTColor(Vector(r/100, g/100, b/100))
		return true
	end
	
	
end

function TOOL:Reload(tr)

	if !IsValid(tr.Entity) then return false end
	local TraceEnt = tr.Entity
	
	if (TraceEnt:IsValid() and TraceEnt:GetClass() == "gb_rp_sign") then
		if CLIENT or game.SinglePlayer() then
			local color = TraceEnt:GetTColor()
			RunConsoleCommand("ledscreen_text", TraceEnt:GetText())
			RunConsoleCommand("ledscreen_type", TraceEnt:GetType())
			RunConsoleCommand("ledscreen_r", color.x*100)
			RunConsoleCommand("ledscreen_g", color.y*100)
			RunConsoleCommand("ledscreen_b", color.z*100)
			RunConsoleCommand("ledscreen_speed", TraceEnt:GetSpeed())
			RunConsoleCommand("ledscreen_wide", TraceEnt:GetWide())
			RunConsoleCommand("ledscreen_fx", TraceEnt:GetFX())
		end
	end


	return true

end


function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {	Text = "#Tool.ledscreen.name" } )
	resetall = vgui.Create("DButton", resetbuttons)
	resetall:SetSize(100, 25)	
	resetall:SetText("Reset all")
	resetall.DoClick = function()
		RunConsoleCommand("ledscreen_text", "")
		RunConsoleCommand("ledscreen_type", 1)
		RunConsoleCommand("ledscreen_r", 255)
		RunConsoleCommand("ledscreen_g", 200)
		RunConsoleCommand("ledscreen_b", 0)
		RunConsoleCommand("ledscreen_speed", 1.5)
		RunConsoleCommand("ledscreen_wide", 6)
		RunConsoleCommand("ledscreen_fx", 0)
		RunConsoleCommand("ledscreen_wire", 0)
		slider:SetValue(1)
		slider2:SetValue(1.5)
		slider3:SetValue(6)
		TextBox:SetValue("")

	end
	CPanel:AddItem(resetall)
	local font = "InfoRUS3"
	frame = vgui.Create( "DPanel" )
	frame:SetSize( CPanel:GetWide(), 50 )
	frame.appr = nil
	frame.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0))
		surface.SetFont(font)
		local alfa
		if GetConVarNumber("ledscreen_fx") > 0 then
			alfa = math.random(100,220)
		else
			alfa = 255
		end
		self.Text = GetConVarString("ledscreen_text")
		self.Type = GetConVarNumber("ledscreen_type")
		self.Speed = GetConVarNumber("ledscreen_speed")
		self.static = false
		local ww,hh = surface.GetTextSize(self.Text)
		local multiplier = self.Speed * 100
		self.Color = Color(GetConVarNumber("ledscreen_r"),GetConVarNumber("ledscreen_g"),GetConVarNumber("ledscreen_b"), alfa)
		if self.Type == 1 then	
		
			local xs = (math.fmod(SysTime() * multiplier,w+ww)) - ww
			draw.DrawText(self.Text,font,xs,0,self.Color,0)
			
		elseif self.Type == 2 then
					
				if !self.appr or self.appr > ww  then
					self.appr = -w
				else
					self.appr = math.Approach(self.appr, ww+w, FrameTime() * multiplier) 
				end
					
				draw.DrawText(self.Text,font,self.appr * -1,0,self.Color,0)
				
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
						draw.DrawText(self.Text,font,w/2,0,self.Color,1)
					else
						draw.DrawText(self.Text,font,self.appr,0,self.Color,0)
					end
		end
	end
		
	CPanel:AddItem(frame)

		
	slider = vgui.Create("DNumSlider")
	slider:SetText("Type")
	slider:SetMinMax(1, 4)
	slider:SetDecimals(0)
	slider:SetValue(1)
	slider:SetConVar("ledscreen_type")
	CPanel:AddItem(slider)
	
	slider2 = vgui.Create("DNumSlider")
	slider2:SetText("Speed")
	slider2:SetMinMax(1, 10)
	slider2:SetDecimals(1)
	slider2:SetValue(1)
	slider2:SetConVar("ledscreen_speed")
	CPanel:AddItem(slider2)
	
	slider3 = vgui.Create("DNumSlider")
	slider3:SetText("Wide")
	slider3:SetMinMax(3, 8)
	slider3:SetDecimals(0)
	slider3:SetValue(6)
	slider3:SetConVar("ledscreen_wide")
	CPanel:AddItem(slider3)
		
	TextBox = vgui.Create("DTextEntry")
	TextBox:SetUpdateOnType(true)
	TextBox:SetEnterAllowed(true)
	TextBox:SetConVar("ledscreen_text")
	TextBox:SetValue(GetConVarString("ledscreen_text"))
	CPanel:AddItem(TextBox)
	
	CPanel:AddControl( "CheckBox", { Label = "Flicker effect", Description = "", Command = "ledscreen_fx" } )
	CPanel:AddControl( "CheckBox", { Label = "WireMod support", Description = "", Command = "ledscreen_wire" } )
	
	CPanel:AddControl("Color", {
			Label = "LED color",
			Red = "ledscreen_r",
			Green = "ledscreen_g",
			Blue = "ledscreen_b",
			ShowHSV = 1,
			ShowRGB = 1,
			Multiplier = 255
		})
	
	CPanel:AddControl("Label", {	Text = "Gmod-Best.Ru ©2013-2019\nWith <3 from Mac" } )
	
end
