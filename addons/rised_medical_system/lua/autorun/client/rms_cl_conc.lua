-- "addons\\rised_medical_system\\lua\\autorun\\client\\rms_cl_conc.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function number_format(n)
    local t = ''

    if n <= 10 or n > 20 then
        if table.HasValue({2, 3, 4}, n % 10) then
            t = 'секунды'
        elseif n % 10 == 1 then
            t = 'секунду'
        else
            t = 'секунд'
        end
    else
        t = 'секунд'
    end


    return n .. ' ' .. t
end

local f

net.Receive('conc effect', function(l, ply)
    local ply = net.ReadEntity()
    local time = CurTime() + conc.time
    
    f = vgui.Create("DFrame")
    f:SetPos(0, 0)
    f:SetSize(ScrW(), ScrH())
    f:SetSizable(false)
    f:SetDraggable(false)
    f:ShowCloseButton(false)
    f:SetTitle('')

    ply:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 1, conc.time )

    f.Paint = function(self, w, h) 
        surface.SetDrawColor(color_black) surface.DrawRect(0, 0, w, h)
        draw.SimpleText('Вы потеряли сознание...', "Trebuchet18", ScrW() / 2, ScrH() / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText('Вы встанете через ' .. number_format(math.Round(time - CurTime())), "Trebuchet18", ScrW() / 2, ScrH() / 2 + 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    timer.Create("Conc_Client", conc.time, 1, function() 
        f:Remove() 
        ply:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 1, 1 ) 
    end)
end)

net.Receive("death effect", function(l, ply)
    local ply = net.ReadEntity()
    local to_respawn = GAMEMODE.Config.respawntime
    local time = CurTime() + to_respawn

    if timer.Exists('Conc_Client') then timer.Stop('Conc_Client') end

    if IsValid(f) then
        f:Remove()
    end
end)