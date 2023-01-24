-- "addons\\zrewards\\lua\\zrewards\\methods\\types\\zrew_method_steamgroup.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) METHOD TYPE: Steam Group
    Developed by Zephruz

    - https://api.steampowered.com/ISteamUser/GetUserGroupList/v1/?key=API_KEY&steamid=STEAMID
]]

local TYPE_STEAMGROUP = zrewards.methods:RegisterType("steamgroup", {APIKey = false, GroupID = false, GroupLink = false})
TYPE_STEAMGROUP:SetName("Steam Group")
TYPE_STEAMGROUP:SetDescription("Join our Steam Group!")
TYPE_STEAMGROUP:SetIcon("materials/zrew/icon_steam.png")

function TYPE_STEAMGROUP:isUserMethodVerified(ply, callback)
    local stid = ply:SteamID64()
    local apiKey, groupID, groupLink = self:GetAPIKey(), self:GetGroupID(), self:GetGroupLink()
    
    if (!apiKey or !groupID) then
        callback(false, "Invalid API Key or Group ID.")

        return false 
    end

    zlib.http:JSONFetch("https://api.steampowered.com/ISteamUser/GetUserGroupList/v1/?key=" .. apiKey .. "&steamid=" .. stid, 
    function(data)
        data = (data && data.response)

        if (!data or !data.success) then
            local result = (!data && "Invalid Steam user data response." || "An error has occured: " .. (data.error or "Undescribed Error"))

            callback(false, result .. " (" .. stid .. ")")

            return
        end

        local inGroup = false
        local groups = data.groups

        if (groups && istable(groups)) then
            for k,v in pairs(groups) do
                local gid = v.gid

                if (gid && tostring(gid) == tostring(groupID)) then
                    inGroup = true

                    break
                end
            end
        else
            callback(false, "Invalid Steam user group table. (" .. stid .. ")")

            return
        end

        if (!inGroup && groupLink) then
            zlib.notifs:Send(ply, zrewards.lang:GetTranslation("steamArentInGroup"), (self:GetIcon() or false))

            zlib.util:OpenURL(groupLink, ply)
        end

        callback(inGroup)
    end)
end

--[[
    Extra Options/Buttons
]]
TYPE_STEAMGROUP:addOption("Open Group Link", {
    icon = "icon16/world_go.png",
    doClick = function(s)
        net.Start("zrew.steamgroup.OpenGroup")
        net.SendToServer()
    end,
})

--[[
    Networking
]]
if (SERVER) then
    util.AddNetworkString("zrew.steamgroup.OpenGroup")

    net.Receive("zrew.steamgroup.OpenGroup",
    function(len, ply)
        local groupLink = TYPE_STEAMGROUP:GetGroupLink()

        if (groupLink) then
            zlib.util:OpenURL(groupLink, ply)
        end
    end)
end