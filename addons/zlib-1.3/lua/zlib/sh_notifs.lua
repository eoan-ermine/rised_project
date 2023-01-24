-- "addons\\zlib-1.3\\lua\\zlib\\sh_notifs.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (CL) Notifications
    Developed by Zephruz
]]

zlib.notifs = (zlib.notifs or {})

--[[Config]]
zlib.notifs.enableChatText = true
zlib.notifs.speed = 7
zlib.notifs.length = 5
zlib.notifs.size = {
	w = 200,
	h = 35,
}
zlib.notifs.position = {
	x = 10,
	y = 5,
}

--[[--------
    SERVER
----------]]
if (SERVER) then
    util.AddNetworkString("zlib.notifs.Send")

    function zlib.notifs:Send(ply, msg, icon)
        if (!ply or !msg) then return end

        netPoint:SendCompressedNetMessage("zlib.notifs.Send", ply, {msg = msg, icon = (icon or false)})
    end
end

--[[--------
    CLIENT
----------]]
if (CLIENT) then
    surface.CreateFont("zlib.Notification", {
        text = "Abel",
        size = 17,
    })

    local notifications = {}

    function zlib.notifs:Create(msg, icon)
        if (istable(msg)) then
            for k,v in pairs(msg) do
                if !(isstring(v)) then
                    table.remove(msg, k)
                end
            end

            msg = table.concat(msg, " ")
        end

        local newNotif = {}
        newNotif.msg = msg
        newNotif.icon = (icon && Material(icon, "noclamp smooth") || false)
        newNotif.delAt = (os.time() + self.length)
        newNotif.curPos = {x = -200, y = self.position.y}
        newNotif.size = {w = self.size.w, h = self.size.h}
        
        table.insert(notifications, newNotif)

        -- Chat text
        if (zlib.notifs.enableChatText) then
            chat.AddText(Color(255,255,255), msg)
        end
    end

    local function removeNotification(id)
        if !(notifications[id]) then return false end

        table.remove(notifications, id)
    end

    --[[HOOKS]]
    hook.Add("zlib.notifs.Receive", "zlib.notifs.Receive[zlib.notifs.Receive]", 
    function(...)
        zlib.notifs:Create({...}) 
    end)

    hook.Add("DrawOverlay", "zlib.notifs[DrawOverlay]",
    function()
        local zlibNotifs = zlib.notifs

        for i=1,#notifications do
            local notif = notifications[i]

            if (notif) then
                local msg, icon = (notif.msg or "No message"), notif.icon
                local nW, nH = notif.size.w, notif.size.h
                local nX, nY = (notif.curPos.x < zlibNotifs.position.x && notif.curPos.x || zlibNotifs.position.x), notif.curPos.y
                
                if (i>1) then nY = nY + (nH*(i-1)) end
                nY = nY + (5*i)

                notif.curPos.x = notif.curPos.x + (notif.delAt <= os.time() && -zlibNotifs.speed || zlibNotifs.speed)

                if (notif.delAt <= os.time() && notif.curPos.x < -nW) then removeNotification(i) end

                local w, h = zlib.util:GetTextSize(msg, "zlib.Notification")
                nW, nH = w+10, h+10

                -- Icon
                if (icon) then
                    local iSize = 28

                    surface.SetMaterial(icon)
                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.DrawTexturedRect(nX, nY + (nH/2 - iSize/2), iSize, iSize)

                    nX = nX + 35
                end

                draw.RoundedBoxEx(4, nX, nY, nW, nH, Color(45,45,45,235), true, true, true, true)
                draw.SimpleText(msg, "zlib.Notification", nX + 5, nY + (nH/2), Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
        end
    end)

    --[[NETWORKING]]
    net.Receive("zlib.notifs.Send",
	function()
		local data, dataBInt = netPoint:DecompressNetData()

		if !(data) then return end
		
        local msg, icon = data.msg, data.icon
		
		if !(msg) then return end

		zlib.notifs:Create(msg, icon)
	end)
end