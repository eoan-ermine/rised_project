-- "addons\\zrewards\\lua\\zrewards\\methods\\types\\zrew_method_nametag.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) METHOD TYPE: Name Tag
    Developed by Zephruz
]]

local TYPE_NAMETAG = zrewards.methods:RegisterType("nametag", {APIKey = false, NameTag = false, IsPeriodic = false, Interval = 86400})
TYPE_NAMETAG:SetName("Name Tag")
TYPE_NAMETAG:SetDescription("Add our name tag to your name!")
TYPE_NAMETAG:SetIcon("materials/zrew/icon_nametag.png")

function TYPE_NAMETAG:getNameTagString()
    local tag = self:GetNameTag()

    if !(istable(tag)) then return tag end

    return table.concat(tag, ", ")
end

function TYPE_NAMETAG:getExtraValue(ply, callback)
    local isPeriodic = self:GetIsPeriodic()

    if !(isPeriodic) then
        if (callback) then callback(false) end

        return
    end

    local extraVal = os.time()

    zrewards.methods:GetMethod(ply, self:GetUniqueName(),
    function(methods)
        if (methods) then
            local interval = (self:GetInterval() || 86400)
            local lastClaim = 0

            // Get last claim
            for k,v in pairs(methods) do
                local eVal = tonumber(v.extraVal)

                if (!eVal || eVal < lastClaim) then continue end

                lastClaim = eVal
            end

            // Validate claim
            local canClaim = extraVal > (lastClaim + interval)

            if !(canClaim) then
                extraVal = false
            end
        end

        callback(extraVal)
    end)
end

function TYPE_NAMETAG:isUserMethodVerified(ply, callback)
    local nick, stid = ply:Name(), ply:SteamID64()
    local apiKey, nameTag = self:GetAPIKey(), self:GetNameTag()

    if (!nick or !stid or !apiKey or !nameTag) then
        callback(false, "Invalid player, API Key, or name tag.")

        return false 
    end

    zlib.http:JSONFetch("https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=" .. apiKey .. "&steamids=" .. stid, 
    function(data)
        local resp = (data && data.response)
        local players = (resp && resp.players)
        local sPly = (players && players[1] || false)
        local sName = (sPly && sPly.personaname)
        local hasTag = false

        if (sName) then
            sName = sName:lower()

            if (istable(nameTag)) then
                for k,v in pairs(nameTag) do
                    hasTag = sName:find(v:lower(), 1, true)
                        
                    if (hasTag) then break end
                end
            else
                hasTag = sName:find(nameTag, 1, true)
            end
        end

        if !(hasTag) then
            zlib.notifs:Send(ply, zrewards.lang:GetTranslation("nametagAddTagToName", (self:getNameTagString() or "INVALID")), (self:GetIcon() or false))
        end

        callback(hasTag)
    end,
    function(data)
        local errStr = (istable(data) && data.error || "Unknown error.")
        
        zrewards:ConsoleMessage("[nametag] Error when validating users name. Error: " .. errStr)
        zlib.notifs:Send(ply, zrewards.lang:GetTranslation("nametagError"))
    end)
end

--[[
    Extra Options/Buttons
]]
TYPE_NAMETAG:addOption("Copy Nametag", {
    icon = "icon16/paste_plain.png",
    doClick = function(s)
        local nTag = TYPE_NAMETAG:GetNameTag()

        if (istable(nTag)) then
            nTag = table.GetFirstValue(nTag)
        end

        if (nTag) then
            SetClipboardText(nTag)

            zlib.notifs:Create("Copied nametag!")
        end
    end,
})

--[[
    Networking
]]
if (SERVER) then
    util.AddNetworkString("zrewards.regtype[nametag].SendTag")
end

if (CLIENT) then
    net.Receive("zrewards.regtype[nametag].SendTag",
    function()
        local tag = net.ReadString()

        if !(tag) then return end

        TYPE_NAMETAG:SetNameTag(tag)
        //TYPE_NAMETAG:SetName(TYPE_NAMETAG:GetName() .. " (" .. tag .. ")")
    end)
end

--[[
    Hooks
]]
if (SERVER) then
    hook.Add("PlayerInitialSpawn", "zrewards.regtype[nametag][PlayerInitialSpawn]",
    function(ply)
        net.Start("zrewards.regtype[nametag].SendTag")
            net.WriteString(TYPE_NAMETAG:getNameTagString())
        net.Send(ply)
    end)
end