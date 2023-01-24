-- "addons\\controllable_city_scanner\\lua\\autorun\\sh_screenshot.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PhotoRequested = false
function CityScannerTakePhoto()
	if LocalPlayer():Team() == TEAM_OWUDISPATCH then
		PhotoRequested = true
	end
end

concommand.Add( "cityscanner_takephoto", CityScannerTakePhoto )

local nShots = 0

local frame
function showCapture(img, w, h)

    if (IsValid(frame)) then frame:Remove() end
    frame = vgui.Create("DFrame")
    frame:SetTitle("ComBot | SHOT#" .. nShots)
    function frame:PaintOver()
    end
    surface.SetFont("DermaDefault")
    frame:SetSize(530, 550)
    frame:Center()
    frame.image = nil
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(0,0,0,155))
	end
	frame:ShowCloseButton(false)
	frame.OnClose = function()
		showCaptureBut(img, w, h)
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(505,5)
	buttonClose.Paint = function(me, w, h)
		draw.SimpleText("X", "zejton20", 0, 0, Color(125,125,125), 0, 0)
	end
	buttonClose.DoClick = function()
		frame:Close()
	end
	
    if (img) then
        local image = vgui.Create("HTML", frame)
        image:SetPos(0,25)
        image:SetSize(550,550)
        frame.image = img
        frame.PaintOver = nil
        timer.Simple(.01, function()
            image:SetHTML( [[ <img width="]]..w..[[" height="]]..h..[[" src="data:image/jpeg;base64, ]]..img..[["/> ]] )
        end)
    end
    frame:MakePopup()
end

function showCaptureBut(img, w, h)
	nShots = nShots + 1
	
    local frameBut = vgui.Create("DFrame")
    frameBut:SetTitle("ComBot | SHOT#" .. nShots)
    function frameBut:PaintOver()
    end
    surface.SetFont("DermaDefault")
    frameBut:SetSize(150, 40)
    frameBut:AlignTop(ScrH()/12 + 60 * nShots)
	frameBut.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(255,165,0,75))
	end
	frameBut:ShowCloseButton(false)
	frameBut.OnClose = function()
		nShots = nShots - 1
	end
	
	local buttonClose = vgui.Create("DButton", frameBut)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(135,0)
	buttonClose.Paint = function(me, w, h)
		draw.SimpleText("X", "zejton20", 0, 0, Color(125,125,125), 0, 0)
	end
	buttonClose.DoClick = function()
		frameBut:Close()
	end
	
	local button01 = vgui.Create("DButton", frameBut)
	button01:SetText( ">>>" )
	button01:SetPos( 25, 20 )
	button01:SetSize( 100, 17 )
	button01.DoClick = function()
		showCapture(img, 512, 512)
		frameBut:Close()
	end
	function button01:Paint( w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 155 ) )
	end
end


hook.Add( "PostRender", "example_screenshot", function()
	if ( !PhotoRequested ) then return end
	PhotoRequested = false

    local RCD = {}
    RCD.format = 'jpeg'
    RCD.h = 512
    RCD.w = 512
    RCD.quality = 5
    RCD.x = ScrW() / 2 - 256
    RCD.y = ScrH() / 2 - 256
    RCD.alpha = false
    local data = util.Base64Encode(render.Capture( RCD ))
	
	net.Start("CityScanner.TakePhoto.Server")
	net.WriteString(data)
	net.SendToServer()
end )

net.Receive( "CityScanner.TakePhoto.Server" , function ( len, ent, ply )
	
	local data = net.ReadString()
	
    for k,v in pairs (player.GetAll()) do
		if v:isCP() then
			net.Start("CityScanner.TakePhoto.Client")
			net.WriteString(data)
			net.Send(v)
		end
	end
end)

net.Receive( "CityScanner.TakePhoto.Client" , function ( len, ent, ply )
	
	local data = net.ReadString()
	
	showCaptureBut(data, 512, 512)
end)

