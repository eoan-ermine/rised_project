-- "addons\\rised_forcefields\\lua\\weapons\\gmod_tool\\stools\\tool_forcefield.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local tool_information01 = "Forcefield Tool"
local tool_information02 = "Позволяет создавать кастомные силовые поля Альянса."
local tool_information03 = "Left Click: Установить первый барьер, Right Click: Установить второй барьер, Reload: Удалить барьер"

CreateClientConVar( "cvar_forcefield_offset_y", 39, true, false );

TOOL.Category = "Rised Project"
TOOL.Name = "#tool.tool_forcefield.name"
TOOL.Command 		= nil
TOOL.ConfigName 	= nil

if CLIENT then
	language.Add( "Tool.tool_forcefield.name", tool_information01 )
	language.Add( "Tool.tool_forcefield.desc", tool_information02 )
	language.Add( "Tool.tool_forcefield.0", tool_information03 )
	
	surface.CreateFont ( "tool_ruler_fontdisplay", 
	{
	
		font = "ChatFont",
		size = 23,
		weight = 900,
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
		outline = false
		
	})
	
	surface.CreateFont ( "tool_ruler_font_large2", 
	{

		font = "ChatFont",
		size = 45,
		weight = 900,
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
		outline = false
			
	})
	
	local smooth = 0

	local function SmoothThis( target, speed )
		if speed == nil then speed = 3 end
		if target == nil then target = 0 end
		smooth = Lerp( speed * FrameTime(), smooth, target ) 
	end
	
	function TOOL:DrawToolScreen()
		cam.Start2D()
			surface.SetDrawColor( Color( 32, 32, 32, 255 ) )
			surface.DrawRect(0, 0, 256, 256)
			
			surface.SetDrawColor( Color( 20, 20, 20, 255 ) )
			surface.DrawRect( 13, 13, 230, 230 )
					
			draw.NoTexture()
			surface.SetDrawColor( Color( 255, 165, 0, math.random(175,255) ) )
			surface.DrawTexturedRectRotated( 290, 100, 25, 300, 45 )

			draw.SimpleText( "Forcefield", "tool_ruler_font_large2", 25, 50, Color(255,255,255, math.random(75,255)), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText( "Tool", "tool_ruler_font_large2", 115, 85, Color(255,255,255, math.random(75,255)), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			local is_fence_1 = LocalPlayer():GetNWEntity("tool_forcefield_fence_1")
			local is_fence_2 = LocalPlayer():GetNWEntity("tool_forcefield_fence_2")
			local offset_y = LocalPlayer():GetNWInt("tool_forcefield_offset_y", 0)
			local fixed_angle = LocalPlayer():GetNWBool("tool_forcefield_fixed_angle", false)

			if IsValid(is_fence_1) then
				if IsValid(is_fence_2) then
					draw.SimpleText( "ЛКМ - сохранить в БД", "tool_ruler_fontdisplay", 25, 165, Color(255,255,255, math.random(75,255)), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
				else
					draw.SimpleText( "ПКМ - установить II", "tool_ruler_fontdisplay", 25, 165, Color(255,255,255, math.random(75,255)), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
				end
				draw.SimpleText( "R: очистить", "tool_ruler_fontdisplay", 25, 185, Color(255,255,255, math.random(75,255)), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			else
				draw.SimpleText( "ЛКМ - установить I", "tool_ruler_fontdisplay", 25, 165, Color(255,255,255, math.random(75,255)), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
				draw.SimpleText( "R: удалить", "tool_ruler_fontdisplay", 25, 185, Color(255,255,255, math.random(75,255)), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			end

			draw.SimpleText( "Смещение по Y: " .. tostring(offset_y), "tool_ruler_fontdisplay", 25, 220, Color(255,255,255, math.random(75,255)), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			draw.SimpleText( "Прямой угол: " .. tostring(fixed_angle), "tool_ruler_fontdisplay", 25, 240, Color(255,255,255, math.random(75,255)), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		cam.End2D()
	end


	
	function TOOL.BuildCPanel( panel )
		panel:AddControl("Header", { 
			Text = tool_information01, 
			Description = tool_information02
		})
		
		panel:AddControl("textbox", { 
			Label = "Локация", 
			Command = "tool_forcefield_location"
		})
		
		panel:AddControl("checkbox", { 
			Label = "Прямой угол", 
			Command = "tool_forcefield_fixed_angle",
			Help = false
		})
		
		local slider = panel:AddControl("slider", { 
			Label = "Смещение по Y", 
			Command = "cvar_forcefield_offset_y",
			Type = "float",
			Min = "-250",
			Max = "250"
		})

		timer.Simple(1, function()
			local cvar = GetConVar("cvar_forcefield_offset_y")
			slider:SetValue(cvar:GetFloat())
			RunConsoleCommand("command_forcefield_offset_y", cvar:GetFloat())
			slider.OnValueChanged = function(self, value)
				RunConsoleCommand("command_forcefield_offset_y", value)
			end
		end)
	end
end

function TOOL:ToolGunPrint( text )
	if SERVER then
		local ply = self:GetOwner()
		umsg.Start( "tool_forcefield_print", ply )
		umsg.String( text )
		umsg.End()
	end
end

function TOOL:LeftClick( trace )
	
	local ply = self:GetOwner()
	
	local fence_2 = ply:GetNWEntity("tool_forcefield_fence_2")
	if IsValid(fence_2) then
		if SERVER then
			SaveForcefield(ply)
		end
		return
	end

	local location = ply:GetNWString("tool_forcefield_location", "")
	if location == "" then
		self:ToolGunPrint("Необходимо ввесли локацию.")
		return
	end

	local offset_y = ply:GetNWInt("tool_forcefield_offset_y")
	local selection_pos = trace.HitPos
	local fixed_angle = ply:GetNWBool("tool_forcefield_fixed_angle", false)

	local selection_ang = fixed_angle and Angle(0, ply:GetAngles().y, 0):SnapTo("y", 45) or Angle(0, ply:GetAngles().y, 0)
	selection_ang:RotateAroundAxis(selection_ang:Up(), -90)

	local ent = trace.Entity
	if IsValid(ent) then return false end

	if SERVER then
		local place_data = {}
		place_data.offset_y = offset_y
		place_data.selection_pos = selection_pos
		place_data.selection_ang = selection_ang

		PlaceFence01(ply, place_data)
	end

	self:ToolGunPrint("Установлен первый барьер.")
	return true
end
	
function TOOL:RightClick( trace )
	
	local ply = self:GetOwner()
	
	local fence_1 = ply:GetNWEntity("tool_forcefield_fence_1")
	if !IsValid(fence_1) then return false end

	local selection_pos = fence_1:GetPos()
	local distance = selection_pos:Distance(trace.HitPos)

	if distance > 1000 then
		self:ToolGunPrint("Расстояние слишком большое.")
		return
	end

	selection_pos = selection_pos + fence_1:GetRight() * distance

	local selection_ang = fence_1:GetAngles()
	local ent = trace.Entity
	
	if IsValid(ent) then return false end

	if SERVER then
		local place_data = {}
		place_data.selection_pos = selection_pos
		place_data.selection_ang = selection_ang

		PlaceFence02(ply, place_data)
	end

	self:ToolGunPrint( "Установлен второй барьер." )
	return true
end
 
function TOOL:Reload(trace)

	local ply = self:GetOwner()
	local ent = trace.Entity
	
	if SERVER then
		ReloadFields(ply, ent)
	end
	
	self:ClearFields()
	return true
end

function TOOL:ClearFields()
	local ply = self:GetOwner()
	if SERVER then
		RemoveFields(ply)
	end
	self:ToolGunPrint( "Удалены несохраненные силовые поля." )
end
 
function TOOL:Deploy()
	self:ClearFields()
end
 
function TOOL:Holster()
	self:ClearFields()
end