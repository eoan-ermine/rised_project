-- "addons\\rised_tabmenu\\lua\\bb_scoreboard\\derma\\cl_draw.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
draw.scrollingtext_store = {};
draw.particles_store = {};
local lifetime = 3;
local local_version = 812.2200; // Draw release from date 
_blackberry.versions = _blackberry.versions or {};
_blackberry.versions[local_version] = true;


local function Initialize(check)
	if (_blackberry.versions["_init"] and local_version > _blackberry.versions["_latest"] and !check) then 
		_blackberry:Alert("[cl_draw] finded new version "..local_version.."");
	else
		if (_blackberry.versions["_init"] and _blackberry.versions["_latest"] != local_version) then return; end;
		if (check) then _blackberry:Alert("[cl_draw] you are using version "..local_version..""); end;
	end;
	// Start x pos, Start y pos, full width, height, size for 1 dash, size into space of 2 dash, color, align = (0 bot \ 1 center \ 2 top) of y pos
	function draw.DashedLine(startx, starty, width, height, dash_size, dash_space, color, align)
		startx = startx or 0;
		starty = starty or 0;
		width = width or 0;
		height = height or 1;
		dash_size = dash_size or 3;
		dash_space = dash_space or dash_size;
		color = color or Color(255, 255, 255);
		align = align or 0;

		starty = align == 1 and starty - height / 2 or align == 2 and starty - height or starty;
		local dash_count = math.floor(width / (dash_size + dash_space));
		local lastDashSize = width - dash_space - (dash_count * (dash_size + dash_space));

		for i = 1, dash_count do
			draw.RoundedBox(0, startx + dash_size*(i - 1) + dash_space * i, starty, dash_size, height, color);
		end;

		draw.RoundedBox(0, startx + width - lastDashSize, starty, lastDashSize, height, color);
	end

	function draw.DashedLineVertical(startx, starty, width, height, dash_size, dash_space, color, align)
		startx = startx or 0;
		starty = starty or 0;
		width = width or 0;
		height = height or 1;
		dash_size = dash_size or 3;
		dash_space = dash_space or dash_size;
		color = color or Color(255, 255, 255);
		align = align or 0;

		startx = align == 1 and startx - width / 2 or align == 2 and startx - width or startx;
		local dash_count = math.floor(height / (dash_size + dash_space));
		local lastDashSize = height - dash_space - (dash_count * (dash_size + dash_space));

		for i = 1, dash_count do
			draw.RoundedBox(0, startx, starty + dash_size*(i - 1) + dash_space * i, width, dash_size, color);
		end;

		draw.RoundedBox(0, startx, starty + height - lastDashSize, width, lastDashSize, color);
	end

	function draw.AddParticle(startx, starty, directx, directy, color)
		table.insert(draw.particles_store, 1, {
			["startTime"] 	= SysTime(),
			["color"]		= color or HSVToColor(math.random(0,360), 1, 1),
			["direct_x"] 	= directx or math.random(-15, 15)*math.random(4, 7),
			["direct_y"] 	= directy or math.random(-15, 15)*math.random(4, 7),
			["startx"] 		= startx,
			["starty"] 		= starty,
			["lifetime"]	= math.random(0.5,1.5)
		});
	end;

	function draw.DrawParticles()
		for k,v in pairs(draw.particles_store) do
			--if (k > 15) then v.lerp = 0.2; end;	// Fix darken
			v.lerp = Lerp(FrameTime()*v.lifetime, v.lerp or 1, 0);
			v.lerpx = Lerp(FrameTime()*v.lifetime, v.lerpx or v.startx, v.startx+v.direct_x);
			v.lerpy = Lerp(FrameTime()*v.lifetime, v.lerpy or v.starty, v.starty+v.direct_y);

			draw.RoundedBox(0, v.lerpx, v.lerpy, 6*v.lerp, 6*v.lerp, Color(v["color"].r, v["color"].g, v["color"].b, 200*v.lerp - 100 / 15 * k));

			if (v.lerp < 0.2) then
				draw.particles_store[k] = nil;
			end
		end;
	end;

	// Scroling text
	function draw.SimpleScrollingText(scrollid, text, font, x, y, color, ax, ay)
		ax = ax or 0; ay = ay or 0;
		if (!scrollid) then
			scrollid = table.insert(draw.scrollingtext_store, {
				["text"] = "",
				["count"] = 0,
				["next"] = SysTime()
			});
			return scrollid;
		end;
		if (!draw.scrollingtext_store[scrollid]) then return end;
		local nowText = draw.scrollingtext_store[scrollid]["text"];

		surface.SetFont(font);
		local width, height = surface.GetTextSize(nowText);
		draw.SimpleText(nowText, font, x, y, color, ax, ay);

		if (draw.scrollingtext_store[scrollid].next <= SysTime() and draw.scrollingtext_store[scrollid]["count"] < string.len(text)+1) then
			draw.scrollingtext_store[scrollid].next = SysTime() + 0.05;
			draw.scrollingtext_store[scrollid]["text"] = draw.scrollingtext_store[scrollid]["text"] .. string.sub(text, draw.scrollingtext_store[scrollid]["count"], draw.scrollingtext_store[scrollid]["count"]);
			draw.scrollingtext_store[scrollid]["count"] = draw.scrollingtext_store[scrollid]["count"] + 1;
			--surface.PlaySound("items/nvg_off.wav");
		end;

		if (draw.scrollingtext_store[scrollid]["count"] >= string.len(text)) then
			draw.scrollingtext_store[scrollid] = nil;
			return -1;
		end

		return scrollid;
	end;

	if (check) then
		_blackberry.versions["_init"] = true;
	end;
end;

Initialize();

timer.Simple(25, function()
	if (_blackberry.versions["_init"]) then return; end;

	local latest = 0;
	for k, v in pairs(_blackberry.versions) do
		if (k == "_init" or k == "_latest") then continue; end;
		if (latest < k) then
			latest = k;
		end;
	end;

	_blackberry.versions["_latest"] = latest;
	if (local_version == latest) then
		Initialize(true);
	end;
end);