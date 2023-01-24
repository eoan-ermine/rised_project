-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_circleimage.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards 2 - (SH) VGUI ELEMENT - Circle image & HTTP Image
    Developed by Zephruz
]]

--[[------------------
	Circular Image
---------------------]]
local CIRCLEIMG = {}

function CIRCLEIMG:Init()
	self.Image = vgui.Create("DImage", self)
	self.Image:SetPaintedManually(true)
	self.material = Material( "effects/flashlight001" )
	
	self:OnSizeChanged(self:GetWide(), self:GetTall())
end

function CIRCLEIMG:PerformLayout(w,h)
	self:OnSizeChanged(w,h)
end

function CIRCLEIMG:SetImage(...)
	self.Image:SetImage(...)
end

function CIRCLEIMG:SetMaterial(...)
	self.Image:SetMaterial(..., "noclamp smooth")
end

function CIRCLEIMG:OnSizeChanged(w,h)
	self.Image:SetSize(self:GetWide(), self:GetTall())
	self.points = math.Max((self:GetWide()/4), 96)
	self.poly = draw.CirclePoly(self:GetWide()/2, self:GetTall()/2, self:GetWide()/2, self.points)
end

function CIRCLEIMG:DrawMask(w,h)
	draw.NoTexture()
	surface.SetMaterial(self.material)
	surface.SetDrawColor(color_white)
	surface.DrawPoly(self.poly)
end

function CIRCLEIMG:Paint(w,h)
	//draw.RoundedBoxEx(4, 0, 0, w, h, Color(45,45,45,225), true, true, true, true)

	render.ClearStencil()
	render.SetStencilEnable(true)

	render.SetStencilWriteMask(1)
	render.SetStencilTestMask(1)

	render.SetStencilFailOperation( STENCILOPERATION_REPLACE )
	render.SetStencilPassOperation( STENCILOPERATION_ZERO )
	render.SetStencilZFailOperation( STENCILOPERATION_ZERO )
	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_NEVER )
	render.SetStencilReferenceValue( 1 )

	self:DrawMask(w, h)

	render.SetStencilFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	render.SetStencilReferenceValue(1)

	self.Image:SetPaintedManually(false)
	self.Image:PaintManual()
	self.Image:SetPaintedManually(true)

	render.SetStencilEnable(false)
	render.ClearStencil()
end

vgui.Register("zrewards.CircularImage", CIRCLEIMG, "DImage")

--[[-----------------------
	HTTP/URL Material Image
--------------------------]]
local function validateHTTPURL(url)
	-- Check if it's a secure connection (we can't use this)
	if (url:StartWith("https://")) then
		url = url:Replace("https://", "http://")
	end

	return url
end

local HTTPIMG = {}

function HTTPIMG:Init()
	self.DHTMLImg = vgui.Create("DHTML", self)
	self.DHTMLImg:SetSize(self:GetWide(), self:GetTall())
	self.DHTMLImg:SetAlpha(0)
	self.DHTMLImg:SetMouseInputEnabled( false )
end

function HTTPIMG:SetURL(url)
	url = validateHTTPURL(url)
	
	self.DHTMLImg:SetHTML([[
		<body style="overflow: hidden; margin: 0;">
			<img src="]] .. url .. [[" width=]] .. self:GetWide() .. [[px height=]] .. self:GetTall() .. [[px />
		</body>]])
	self.DHTMLImg.ImageMatLoaded = false

	self.DHTMLImg.LoadImageMat = function()
		if !(self.DHTMLImg) then return false end

		local html_mat = self.DHTMLImg:GetHTMLMaterial()

		if (!html_mat) then return false end

		local scale_x, scale_y = (self:GetWide()/html_mat:Width()),(self:GetTall()/html_mat:Height())

		local matdata = {
			["$basetexture"] = html_mat:GetName(),
			["$basetexturetransform"] = "center 0 0 scale " .. scale_x .. " " .. scale_y .. " rotate 0 translate 0 0",
			["$model"] = 1,
			["$alphatest"] = 1,
			["$nocull"] = 1,
		}

		local uid = string.Replace(html_mat:GetName(),"__vgui_texture_","zlib_web_mat_")

		self.mg_webmat = CreateMaterial(uid, "UnlitGeneric", matdata)

		self:SetMaterial(self.mg_webmat)
	end

	self.DHTMLImg.Think = function()
		if (self.DHTMLImg:GetHTMLMaterial() && !self.DHTMLImg.ImageMatLoaded) then
			self.DHTMLImg.ImageMatLoaded = true
				
			self.DHTMLImg.LoadImageMat()
		end
	end
end

vgui.Register("zrewards.HTMLImage", HTTPIMG, "zrewards.CircularImage")


-- [[Draw Circle]]
function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )

	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 )
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	surface.DisableClipping( false )
	surface.DrawPoly( cir )
end

-- [[Draw Circle Poly func (for avatar)]]
function draw.CirclePoly( pos_x, pos_y, radius, ang_pts )
    local _u = ( pos_x + radius * 320 ) - pos_x
    local _v = ( pos_y + radius * 320 ) - pos_y

    local _slices = ( 2 * math.pi ) / ang_pts
    local _poly = { }

    for i = 0, ang_pts - 1 do
        local _angle = ( _slices * i ) % ang_pts
        local x = pos_x + radius * math.cos( _angle )
        local y = pos_y + radius * math.sin( _angle )
        table.insert( _poly, { x = x, y = y, u = _u, v = _v } )
    end

    return _poly
end