-- "addons\\rised_debug_tools\\lua\\autorun\\rdt_functions.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function rprint(value, time)
	if time == nil then time = 0 end
	timer.Simple(time, function()
		MsgC("\n")
		MsgC(Color(0,255,0), "-=-=-=-=-=-=-=-=-=-=-=-=-=-", "\n")
		if istable(value) then
			PrintTable(value)
		else
			MsgC(Color(0,255,0), value, "\n")
			
			for k,v in pairs(player.GetAll()) do
				if v:SteamID() == RISED.OwnerId then
					v:ChatPrint(tostring(value))
				end
			end
		end
	end)
end

function log(value, time)
	rprint(value, time)
end

function rprinte(value, time)
	if time == nil then time = 0 end
	timer.Simple(time, function()
		MsgC("\n")
		MsgC(Color(255,0,0), "-=-=-=-=-=-=-=-=-=-=-=-=-=-", "\n")
		if istable(value) then
			MsgC(Color(255,0,0), value, "\n")
		else
			MsgC(Color(255,0,0), value, "\n")
			
			for k,v in pairs(player.GetAll()) do
				if v:SteamID() == RISED.OwnerId then
					v:ChatPrint(tostring(value))
				end
			end
		end
	end)
end

if CLIENT then

	function draw.Test(s,w,h)
        draw.RoundedBox(0, 0, 0, w, h, Color(255,5,5))
	end

    concommand.Add("seq_sel", function(p,_,a)
        local mdl = a[1]
        local vg = vgui.Create("DFrame")
        vg:SetSize(ScrW()*.7,ScrH()*.8)
        vg:Center()
        vg.Think = function(s)
            if input.IsKeyDown(KEY_ESCAPE) then
                s:Remove()
                s = nil
            end
        end
        vg.pnl = vgui.Create("DScrollPanel", vg)
        vg.pnl:SetPos(0,20)
        vg.pnl:SetSize(vg:GetWide()/2,vg:GetTall()-20)
    
        vg.pnlp = vgui.Create("DModelPanel", vg)
        vg.pnlp:SetPos(vg:GetWide()/2,0)
        function vg.pnlp:LayoutEntity( Entity ) return end

        vg.pnlp:SetModel(mdl)
        vg.pnlp:SetSize(vg:GetWide()/2,vg:GetTall())
        for z,x in pairs(vg.pnlp:GetEntity():GetSequenceList()) do
            vg.pnlp.btn = vgui.Create("DButton", vg.pnl)
            vg.pnlp.btn:Dock(TOP)
            vg.pnlp.btn:SetText(x)
            vg.pnlp.btn.DoClick = function()
                SetClipboardText(z)
                vg.pnlp:GetEntity():SetSequence(z)
                chat.AddText(Color(235,75,75), z)
            end
        end
    end)
end

timer.Create("CameraRemoveTimer", 3600, 0, function()
	if SERVER then
		for k,v in pairs(ents.FindByClass("npc_combine_camera")) do
			v:Remove()
		end
	end
end)