-- "addons\\rised_f4menu\\lua\\bb_f4menu\\derma\\menu_button.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.derma = _blackberry.f4menu.derma or {};
local cfg = _blackberry.f4menu.config;

function _blackberry.f4menu.derma.createButtonlist(text, font)
	if (font == 1) then
		font = "Raleway 16";
	else 
		font = "Raleway Bold 19";
	end
	surface.SetFont( font )
	local width, height = surface.GetTextSize(text)

	local _t = vgui.Create("DButton")
	_t:SetSize(width, height+6);
	_t:SetText("");
	_t.Text = text;
	_t.hovered = false;
	_t.active = false;
	_t.disabled = false;
	_t.alpha = 0;
	_t.starttime = SysTime();
	_t.Paint = function(self, w, h)
		if (_t.starttime < SysTime()) then
			_t.alpha = _t.alpha or 0;
			_t.alpha = Lerp(FrameTime()*0.5, _t.alpha, 1);
		end


		--surface.DrawLine(startx, 25+36+24*2+20+2, startx+width, 25+36+24*2+20+2)
		if (self.active) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255,209,55,150*_t.alpha));
			draw.SimpleText(self.Text, font, w/2, h/2, Color(255,209,55,255*_t.alpha), 1, 1);
			return;
		end
		if (self.disabled && self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(0,0,0,100*_t.alpha));
			draw.SimpleText(self.Text, font, w/2, h/2, Color(0,0,0,255*_t.alpha), 1, 1);
			return;
		end
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255,255,255,20*_t.alpha));
			draw.SimpleText(self.Text, font, w/2, h/2, Color(255,255,255,75*_t.alpha), 1, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b,100*_t.alpha));
			draw.SimpleText(self.Text, font, w/2, h/2, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b,255*_t.alpha), 1, 1);

			return;
		end

		draw.RoundedBox(0,0,h-1,w,1,Color(255,200,75,25*_t.alpha));
		draw.SimpleText(self.Text, font, w/2, h/2, Color(255,200,75,150*_t.alpha), 1, 1);
	end;
	_t.OnCursorEntered = function(self)
		self.hovered = true;
		surface.PlaySound(cfg["sound_hover"]);
	end;
	_t.OnMousePressed1 = _t.OnMousePressed;
	_t.OnMousePressed = function(self)
		surface.PlaySound(cfg["sound_click"]);
		if (self.disabled) then return false; end;
		_t.OnMousePressed1(self);
	end;
	_t.OnCursorExited = function(self)
		self.hovered = false;
	end;

	return _t;
end;