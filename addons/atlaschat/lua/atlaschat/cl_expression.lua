-- "addons\\atlaschat\\lua\\atlaschat\\cl_expression.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- refractionservers.net, Chewgum - chewgumtj@gmail.com --

atlaschat.expression = {}

local stored = {}
local object = {}
object.__index = object

----------------------------------------------------------------------
-- Purpose:
--		Creates a new expression.
----------------------------------------------------------------------

function atlaschat.expression.New(text, unique)
	local expression = {}
	
	expression.text = text
	expression.unique = unique
	
	setmetatable(expression, object)
	
	table.insert(stored, expression)

	return expression
end

----------------------------------------------------------------------
-- Purpose:
--		Returns all the stored expressions.
----------------------------------------------------------------------

function atlaschat.expression.GetStored()
	return stored
end

----------------------------------------------------------------------
-- Purpose:
--		Returns an expression based on expression.
----------------------------------------------------------------------

function atlaschat.expression.GetByExpression(expression)
	for i = 1, #stored do
		local object = stored[i]
		
		if (object.text == expression) then
			return object
		end
	end
end

----------------------------------------------------------------------
-- Purpose:
--		Returns an expression based on unique.
----------------------------------------------------------------------

function atlaschat.expression.GetByUnique(unique)
	for i = 1, #stored do
		local expression = stored[i]
		
		if (expression.unique == unique) then
			return expression
		end
	end
end

----------------------------------------------------------------------
-- Purpose:
--		
----------------------------------------------------------------------

function object:GetPlayer()
	return self.player
end

----------------------------------------------------------------------
-- Purpose:
--		
----------------------------------------------------------------------

function object:GetExpression()
	return self.text
end

----------------------------------------------------------------------
-- Purpose:
--		
----------------------------------------------------------------------

function object:GetUnique()
	return self.unique
end

----------------------------------------------------------------------
-- Purpose:
--		
----------------------------------------------------------------------

function object:GetCleanName()
	return self.cleanName and self.cleanName or self.text
end

----------------------------------------------------------------------
-- Purpose:
--		
----------------------------------------------------------------------

local function ExtractColor(color)
	if (!color or color == "") then
		return color_white
	else
		if (string.sub(color, 0, 2) == "c=") then
			local info = string.Explode(",", string.sub(color, 3))

			if (info) then
				local r, g, b = tonumber(info[1]) or 0, tonumber(info[2]) or 0, tonumber(info[3]) or 0
				
				return Color(r, g, b)
			end
		else
			return color_white
		end
	end
end

---------------------------------------------------------
-- Emoticons.
---------------------------------------------------------

-- local emoticons = {}

-- emoticons[":)"] = "icon16/emoticon_smile.png"
-- emoticons[":D"] = "icon16/emoticon_happy.png"
-- emoticons[":O"] = "icon16/emoticon_surprised.png"
-- emoticons[":p"] = "icon16/emoticon_tongue.png"
-- emoticons[":P"] = "icon16/emoticon_tongue.png"
-- emoticons[":("] = "icon16/emoticon_unhappy.png"
-- emoticons["garry"] = {"atlaschat/emoticons/garry.png", 64, 64}
-- emoticons["gaben"] = {"atlaschat/emoticons/gaben.png", 64, 64}

-- emoticons[":smile:"] = "icon16/emoticon_smile.png"
-- emoticons[":online:"] = "icon16/status_online.png"
-- emoticons[":tongue:"] = "icon16/emoticon_tongue.png"
-- emoticons[":offline:"] = "icon16/status_offline.png"
-- emoticons[":unhappy:"] = "icon16/emoticon_unhappy.png"
-- emoticons[":suprised:"] = "icon16/emoticon_surprised.png"
-- emoticons[":exclamation:"] = "icon16/exclamation.png"
-- emoticons[":information:"] = "icon16/information.png"

-- for match, data in pairs(emoticons) do
-- 	local expression = atlaschat.expression.New(match, match)

-- 	expression.image = true
-- 	expression.noPattern = true
-- 	expression.cleanName = match
	
-- 	function expression:Execute(base)
-- 		local type = type(data)
-- 		local image = base:Add("DImage")
		
-- 		if (type == "table") then
-- 			image:SetImage(data[1])
-- 			image:SetSize(data[2], data[3])
-- 		else
-- 			image:SetImage(data)
-- 			image:SetSize(16, 16)
-- 		end

-- 		image:SetToolTip(self.text)
-- 		image:SetMouseInputEnabled(true)
		
-- 		image.toolTip = self.text
		
-- 		function image:OnCopiedText()
-- 			return self.toolTip
-- 		end
		
-- 		return image
-- 	end
	
-- 	function expression:GetExample(base)
-- 		return self.text, self:Execute(base)
-- 	end
-- end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<noparse>(.-)</noparse>", "noparse")

expression.cleanName = "<noparse> </noparse>"

function expression:Execute(base, text)
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetColor(color_white)
	label:SizeToContents()
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("<red>This would be a red text</red>")
	label:SetSkin("atlaschat")
	label:SizeToContents()
	
	return "<noparse><red>This would be a red text</red></noparse>", label
end

---------------------------------------------------------
-- URL.
---------------------------------------------------------

local color_url = Color(1, 192, 253)

local expression = atlaschat.expression.New("<url>(.-)</url>", "url")

expression.cleanName = "<url> </url>"

function expression:Execute(base, text)
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetColor(color_url)
	label:SizeToContents()
	
	label.url = text
	label.cursor = true
	
	function label:PaintOver(w, h)
		surface.SetDrawColor(color_url)
		surface.DrawLine(0, h -1, w, h -1)
	end
	
	function label:OnCursorEntered()
		self:SetCursor("hand")
	end
	
	function label:OnCursorExited()
		self:SetCursor("arrow")
	end
	
	function label:OnMousePressed(code)
		if (code == MOUSE_LEFT) then
			self.wasPressed = CurTime()
		end
	end
	
	function label:OnMouseReleased()
		if (self.wasPressed and CurTime() -self.wasPressed <= 0.16) then
			gui.OpenURL(self.url)
		end
		
		self.wasPressed = nil
	end
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("http://www.youtube.com")
	label:SetColor(color_url)
	label:SizeToContents()
	
	label.cursor = true
	
	function label:PaintOver(w, h)
		surface.SetDrawColor(self.visited and color_url_visited_line or color_url)
		surface.DrawLine(0, h -1, w, h -1)
	end
	
	function label:OnCursorEntered()
		self:SetCursor("hand")
	end
	
	function label:OnCursorExited()
		self:SetCursor("arrow")
	end
	
	function label:OnMousePressed(code)
		if (code == MOUSE_LEFT) then
			self.wasPressed = CurTime()
		end
	end
	
	function label:OnMouseReleased()
		if (self.wasPressed and CurTime() -self.wasPressed <= 0.16) then
			gui.OpenURL(self:GetText())
			
			self:SetColor(color_url_visited)
			
			self.visited = true
		end
		
		self.wasPressed = nil
	end
	
	return "<url>http://www.youtube.com</url>", label
end

---------------------------------------------------------
-- Text color. <c=r,g,b> Text </c>
---------------------------------------------------------

local expression = atlaschat.expression.New("<c=(%d+,%d+,%d+)>(.-)</c>", "color")

expression.cleanName = "<c> </c>"

function expression:Execute(base, color, text)
	local color = string.Explode(",", color)
	color = Color(color[1], color[2], color[3])

	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetColor(color)
	label:SizeToContents()
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("This is a red colored text")
	label:SetColor(color_red)
	label:SizeToContents()
	
	return "<c=255,0,0>This is a red colored text</c>", label
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<avatar>", "avatar")

expression.noPattern = true

function expression:Execute(base)
	local player = self:GetPlayer()
	local size = atlaschat.smallAvatar:GetBool() and 24 or 32

	local avatar = vgui.Create("AvatarImage")
	avatar:SetParent(base)
	avatar:SetSize(size, size)
	avatar:SetPlayer(player, size)
	
	function avatar:OnCopiedText()
		return "<avatar>"
	end
	
	return avatar
end

function expression:GetExample(base)
	local size = atlaschat.smallAvatar:GetBool() and 24 or 32
	
	local avatar = base:Add("AvatarImage")
	avatar:SetSize(size, size)
	avatar:SetPlayer(LocalPlayer(), size)
	
	return "<avatar>", avatar
end

local expression = atlaschat.expression.New("<avatar=(STEAM_[0-5]:[01]:%d+)>", "avatar_steamid")

expression.cleanName = "<avatar=STEAMID>"

function expression:Execute(base, steamID)
	if (steamID) then
		local size = atlaschat.smallAvatar:GetBool() and 24 or 32
		local communityID = util.SteamIDTo64(steamID)
		
		local avatar = vgui.Create("AvatarImage")
		avatar:SetParent(base)
		avatar:SetSize(size, size)
		avatar:SetSteamID(communityID, size)
		
		avatar.steamID = steamID

		function avatar:OnCopiedText()
			return "<avatar=" .. self.steamID .. ">"
		end
		
		return avatar
	end
end

function expression:GetExample(base)
	local size = atlaschat.smallAvatar:GetBool() and 24 or 32
	
	local avatar = base:Add("AvatarImage")
	avatar:SetSize(size, size)
	avatar:SetPlayer(LocalPlayer(), size)
	
	return "<avatar=" .. LocalPlayer():SteamID() .. ">", avatar
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<font=(.-)>(.-)</font>", "font")

expression.cleanName = "<font> </font>"

function expression:Execute(base, font, text)
	local ok = pcall(draw.SimpleText, text, font, 0, 0, color_transparent, 1, 1)
	local font = font
	
	if (!ok) then
		local eugh = font
		
		timer.Simple(0.05, function() chat.AddText(":exclamation: The font \"" .. eugh .. "\" is invalid!") end)
		
		font = atlaschat.font:GetString()
	end
	
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetFont(font)
	label:SetText(text)
	label:SetColor(color_white)
	label:SizeToContents()
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("This is a different font")
	label:SetSkin("atlaschat")
	label:SetFont("DermaDefaultBold")
	label:SizeToContents()
	
	return "<font=DermaDefaultBold>This is a different font</font>", label
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("OverRustle", "overrustle")

expression.noPattern = true

function expression:Execute(base)
	local image = base:Add("DImage")
	image:SetImage("atlaschat/emoticons/overrustle.png")
	image:SetSize(32, 32)
	image:SetToolTip("OverRustle")
	image:SetMouseInputEnabled(true)
	
	function image:Paint(w, h)
		if (vgui.GetHoveredPanel() == self) then
			local x = math.sin(CurTime() *80) *3
			local y = math.cos(CurTime() *60) *1.5
			
			self:PaintAt(x, y, self:GetWide(), self:GetTall())
		else
			self:PaintAt(0, 0, self:GetWide(), self:GetTall())
		end
	end
	
	function image:OnCopiedText()
		return "OverRustle"
	end
	
	return image
end

function expression:GetExample(base)
	return "OverRustle", self:Execute(base)
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<lg>(.-)</lg>", "limegreen")

expression.cleanName = "<lg> </lg>"

function expression:Execute(base, text)
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetColor(color_limegreen)
	label:SizeToContents()
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("This is a limegreen text")
	label:SetColor(color_limegreen)
	label:SizeToContents()

	return "<lg>This is a limegreen text</lg>", label
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<spoiler>(.-)</spoiler>", "spoiler")

expression.cleanName = "<spoiler> </spoiler>"

function expression:Execute(base, text)
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetColor(color_white)
	label:SizeToContents()
	label:SetMouseInputEnabled(true)
	
	function label:PaintOver(w, h)
		if (!self.clicked) then
			draw.SimpleRect(0, 0, w, h, color_black)
		end
	end
	
	function label:OnMousePressed()
		self.clicked = true
	end
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("This is a spoiler text")
	label:SetSkin("atlaschat")
	label:SizeToContents()
	label:SetMouseInputEnabled(true)
	
	function label:PaintOver(w, h)
		if (!self.clicked) then
			draw.SimpleRect(0, 0, w, h, color_black)
		end
	end
	
	function label:OnMousePressed()
		self.clicked = true
	end

	return "<spoiler>This is a spoiler text</spoiler>", label
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<hsv>(.-)</hsv>", "hsv")

expression.cleanName = "<hsv> </hsv>"

function expression:Execute(base, text)
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetColor(color_white)
	label:SizeToContents()
	
	label.color = color_white
	
	function label:Think()
		local hue = math.abs(math.sin(CurTime() *0.9) *335)

		self.color = HSVToColor(hue, 1, 1)
		
		self:SetFGColor(self.color.r, self.color.g, self.color.b, self.color.a)
	end
	
	function label:ApplySchemeSettings()
	end
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("This is a hsv text")
	label:SetColor(color_white)
	label:SizeToContents()

	label.color = color_white
	
	function label:Think()
		local hue = math.abs(math.sin(CurTime() *0.9) *335)

		self.color = HSVToColor(hue, 1, 1)
		
		self:SetFGColor(self.color.r, self.color.g, self.color.b, self.color.a)
	end
	
	function label:ApplySchemeSettings()
	end

	return "<hsv>This is a hsv text</hsv>", label
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<flash%s*(c?=?%d-,-%d-,-%d-)>(.-)</flash>", "flash")

expression.cleanName = "<flash> </flash>"

function expression:Execute(base, color, text)
	color = ExtractColor(color)
	
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetColor(color)
	label:SizeToContents()
	
	local hue, saturation = ColorToHSV(color)
	
	label.hue = hue
	label.color = saturation
	label.saturation = saturation
	
	function label:Think()
		local value = math.abs(math.sin(CurTime() *0.9) *1)

		self.color = HSVToColor(self.hue, self.saturation, value)
		
		self:SetFGColor(self.color.r, self.color.g, self.color.b, self.color.a)
	end
	
	function label:ApplySchemeSettings()
	end
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("This is a red flashing text")
	label:SetColor(color_white)
	label:SizeToContents()

	local hue, saturation = ColorToHSV(color_red)
	
	label.hue = hue
	label.color = saturation
	label.saturation = saturation
	
	function label:Think()
		local value = math.abs(math.sin(CurTime() *0.9) *1)

		self.color = HSVToColor(self.hue, self.saturation, value)
		
		self:SetFGColor(self.color.r, self.color.g, self.color.b, self.color.a)
	end
	
	function label:ApplySchemeSettings()
	end

	return "<flash c=255,0,0>This is a red flashing text</flash>", label
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<vscan%s*(c?=?%d-,-%d-,-%d-)>(.-)</vscan>", "vscan")

expression.cleanName = "<vscan> </vscan>"

function expression:Execute(base, color, text)
	color = ExtractColor(color)
	
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetColor(color_white)
	label:SizeToContents()

	label.scanColor = color
	
	function label:PaintOver(w, h)
		local y = -h +(h *2) *((CurTime() %1) ^2)

		draw.SimpleRect(0, y, w, h, self.scanColor)
	end
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("This is a vertical scan")
	label:SetSkin("atlaschat")
	label:SizeToContents()

	label.scanColor = color_red
	
	function label:PaintOver(w, h)
		local y = -h +(h *2) *((CurTime() *0.8 %1) ^2)

		draw.SimpleRect(0, y, w, h, self.scanColor)
	end

	return "<vscan c=255,0,0>This is a vertical scan</vscan>", label
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<hscan%s*(c?=?%d-,-%d-,-%d-)>(.-)</hscan>", "hscan")

expression.cleanName = "<hscan> </hscan>"

function expression:Execute(base, color, text)
	color = ExtractColor(color)
	
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetColor(color_white)
	label:SizeToContents()
	
	label.scanX = -4
	label.scanColor = color
	
	function label:PaintOver(w, h)
		local width = math.max(1, w *0.2)
		local x = (CurTime() %1) ^2 *(w +width) -width
		
		draw.SimpleRect(x, 0, width, h, self.scanColor)
	end
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("This is a horizontal scan")
	label:SetSkin("atlaschat")
	label:SizeToContents()

	label.scanColor = color_red
	
	function label:PaintOver(w, h)
		local width = math.max(1, w *0.2)
		local start = (CurTime() %1) ^2 *(w +width) -width
	
		draw.SimpleRect(start, 0, width, h, self.scanColor)
	end

	return "<hscan c=255,0,0>This is a horizontal scan</hscan>", label
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<reverse>(.-)</reverse>", "reverse")

expression.cleanName = "<reverse> </reverse>"

function expression:Execute(base, text)
	local text = string.utf8reverse(text)
	
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetSkin("atlaschat")
	label:SizeToContents()
	
	return label
end

function expression:GetExample(base)
	local text = string.utf8reverse("This is a reversed text")
	
	local label = base:Add("DLabel")
	label:SetText(text)
	label:SetSkin("atlaschat")
	label:SizeToContents()

	return "<reverse>This is a reversed text</reverse>", label
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<cflash%s*(c?=?%d-,-%d-,-%d-)%s*(c?=?%d-,-%d-,-%d-)>(.-)</cflash>", "cflash")

expression.cleanName = "<cflash> </cflash>"

function expression:Execute(base, color, color2, text)
	color = ExtractColor(color)
	color2 = ExtractColor(color2)
	
	local label = atlaschat.GenericLabel()
	label:SetParent(base)
	label:SetText(text)
	label:SetColor(color)
	label:SizeToContents()
	
	label.color = color
	label.first = Color(color.r, color.g, color.b)
	label.second = Color(color2.r, color2.g, color2.b)
	label.reach = label.first
	
	function label:Think()
		if (self.color == self.first) then
			self.reach = self.second
		elseif (self.color == self.second) then
			self.reach = self.first
		end
		
		self.color.r = math.Approach(self.color.r, self.reach.r, 1.5)
		self.color.g = math.Approach(self.color.g, self.reach.g, 1.5)
		self.color.b = math.Approach(self.color.b, self.reach.b, 1.5)
		
		self:SetFGColor(self.color.r, self.color.g, self.color.b, self.color.a)
	end
	
	function label:ApplySchemeSettings()
	end
	
	return label
end

function expression:GetExample(base)
	local label = base:Add("DLabel")
	label:SetText("This is a colored flash")
	label:SetSkin("atlaschat")
	label:SizeToContents()

	label.color = Color(255, 0, 255)

	label.first = Color(255, 0, 255)
	label.second = Color(0, 255, 0)
	label.reach = label.first
	
	function label:Think()
		if (self.color == self.first) then
			self.reach = self.second
		elseif (self.color == self.second) then
			self.reach = self.first
		end
		
		self.color.r = math.Approach(self.color.r, self.reach.r, 1.5)
		self.color.g = math.Approach(self.color.g, self.reach.g, 1.5)
		self.color.b = math.Approach(self.color.b, self.reach.b, 1.5)
		
		self:SetFGColor(self.color.r, self.color.g, self.color.b, self.color.a)
	end
	
	function label:ApplySchemeSettings()
	end
	
	return "<cflash c=255,0,255 c=0,255,0> This is a colored flash </cflash>", label
end

---------------------------------------------------------
--
---------------------------------------------------------

local expression = atlaschat.expression.New("<icon%s?(%d+),-(%d+)>(.-)</icon>", "icon")

expression.cleanName = "<icon> </icon>"

function expression:Execute(base, width, height, icon)
	local image = base:Add("DImage")
	local icon = icon or ""
	local width = tonumber(width) or 64
	local height = tonumber(height) or 64
	
	width = math.Clamp(width, 0, 64)
	height = math.Clamp(height, 0, 64)

	image:SetImage(icon)
	image:SetSize(width, height)
	image:SetToolTip(icon)
	image:SetMouseInputEnabled(true)
	
	image.toolTip = icon
	
	function image:OnCopiedText()
		return self.toolTip
	end
	
	return image
end

function expression:GetExample(base)
	return "<icon 64,64>icon16/user.png</icon>", self:Execute(base, 64, 64, "icon16/user.png")
end

---------------------------------------------------------
--
---------------------------------------------------------