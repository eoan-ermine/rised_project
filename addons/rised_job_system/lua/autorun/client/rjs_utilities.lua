-- "addons\\rised_job_system\\lua\\autorun\\client\\rjs_utilities.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

COLOR_WHITE = Color(255, 255, 255, 255)
COLOR_HOVER = Color(241, 209, 94, 255)
COLOR_BLACK = Color(0, 0, 0, 255)

FADE_DELAY = 0.3

ENABLE_GRADIENT = file.Exists("materials/overlay_final.png", "GAME")

surface.CreateFont( "HeaderFont3", {
	font = "b52",
	size = 55,
	weight = 900
})

surface.CreateFont( "HeaderFont", {
	font = "b52",
	size = 40,
	weight = 900
})

surface.CreateFont( "HeaderFont1", {
	font = "b52",
	size = 25,
	weight = 900
})

surface.CreateFont( "HeaderFont2", {
	font = "b52",
	size = 35,
	weight = 900
})

surface.CreateFont( "TextFont", {
	font = "Default",
	size = 18,
})

function surface.GetTextWidth(text, font)
	surface.SetFont(font)
	return surface.GetTextSize(text)
end

function surface.DrawShadowText(text, font, posX, posY, textColor, shadowColor, align, shadowOffsetX, shadowOffsetY)
 	draw.DrawText(text, font, posX + (shadowOffsetY or 1), posY + (shadowOffsetX or 1), shadowColor, align or TEXT_ALIGN_LEFT)
 	draw.DrawText(text, font, posX, posY, textColor, align)
end

function draw.DrawOutlinedRect(x, y, width, height, color)
	surface.SetDrawColor(color)
    surface.DrawOutlinedRect(x, y, width, height)
end

function draw.DrawRect(x, y, width, height, color)
	surface.SetDrawColor(color.r, color.g, color.b, color.a)
	surface.DrawRect(x, y, width, height)
end

function surface.DrawShadowText(text, font, posX, posY, textColor, shadowColor, align, shadowOffsetX, shadowOffsetY)
 	draw.DrawText(text, font, posX + (shadowOfsetX or 1), posY + (shadowOfsetY or 1), shadowColor, align or TEXT_ALIGN_LEFT)
 	draw.DrawText(text, font, posX, posY, textColor, align)
end

function draw.DrawLine(startX, startY, endX, endY, color)
	surface.SetDrawColor(color)
	surface.DrawLine(startX, startY, endX, endY)
end

function draw.DrawOutlinedRoundedRect(width, height, color, x, y)
	x = x or 0
	y = y or 0
	surface.SetDrawColor(color)
	surface.DrawLine(x + 1, y, x + width - 2, y)
	surface.DrawLine(x, y + 1, x, y + height - 2)
	surface.DrawLine(x + width - 1, y + 2, x + width - 1, y + height - 2)
	surface.DrawLine(x + 1, y + height - 1, x + width - 2, y + height -1)
end

function LerpColor(delta, from, to)
	return Color(Lerp(delta, from.r, to.r), Lerp(delta, from.g, to.g), Lerp(delta, from.b, to.b), Lerp(delta, from.a, to.a))
end

function toLines(text, font, mWidth)
	surface.SetFont(font)
	
	local buffer = { }
	local nLines = { }

	for word in string.gmatch(text, "%S+") do
		local w,h = surface.GetTextSize(table.concat(buffer, " ").." "..word)
		if w > mWidth then
			table.insert(nLines, table.concat(buffer, " "))
			buffer = { }
		end
		table.insert(buffer, word)
	end
		
	if #buffer > 0 then -- If still words to add.
		table.insert(nLines, table.concat(buffer, " "))
	end
	
	return nLines
end

function drawMultiLine(text, font, mWidth, spacing, x, y, color, alignX, alignY, oWidth, oColor)
	local mLines = toLines(text, font, mWidth)

	for i,line in pairs(mLines) do
		if oWidth and oColor then
			draw.SimpleTextOutlined(line, font, x, y + (i - 1) * spacing, color, alignX, alignY, oWidth, oColor)
		else
			draw.SimpleText(line, font, x, y + (i - 1) * spacing, color, alignX, alignY)
		end
	end
		
	return (#mLines - 1) * spacing
end

function multilineSize(text, font, mWidth, spacing, x, y, color, alignX, alignY, oWidth, oColor)
	local mLines = toLines(text, font, mWidth)
	return (#mLines - 1) * spacing
end

function linesCount(text, font, mWidth)
	local mLines = toLines(text, font, mWidth)
	return #mLines
end