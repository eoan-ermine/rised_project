-- "addons\\zrewards\\lua\\zrewards\\methods\\types\\zrew_method_discordserver.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) METHOD TYPE: Discord Server
    Developed by Zephruz

    - https://discordapp.com/developers/docs/resources/guild#get-guild-member
    - https://discordapp.com/developers/docs/resources/user#get-current-user-guilds
    - RCP Port range: https://discordapp.com/developers/docs/topics/rpc#rpc-server-ports
]]

--[[
    DISCORD API
]]
local DISCORD_API = zlib.util.discord:CreateAPI(zrewards.config.discordInfo || {})
DISCORD_API._requests = {}

function DISCORD_API:getRequest(nonce)
    return self._requests[nonce]
end

function DISCORD_API:closeRequest(nonce)
    self._requests[nonce] = nil
end

function DISCORD_API:openRequest(nonce, callback)
    self._requests[nonce] = callback
end

function DISCORD_API:requestAuthCode(ply, callback, nonce)
    local nonce = (nonce || string.random(15)) // generate nonce to track request

    // Send request to player
    self:openRequest(nonce, callback)

    // Send request for auth code
    netPoint:SendCompressedNetMessage("zrew.discordserver.RequestCode", ply, 
    { 
        nonce = nonce,
        clientid = self:GetClientID()
    })
end

function DISCORD_API:onRequestAuthCode(clientid, nonce)
    self:getUserAuthCode(clientid, 
    function(code)
        netPoint:SendCompressedNetMessage("zrew.discordserver.ReceiveCode", "SERVER", 
        {
            nonce = nonce, 
            code = code
        })
    end, 
    nonce)
end

function DISCORD_API:onReceiveAuthCode(ply, authCode, nonce)
    local req = self:getRequest(nonce)

    if (req) then
        req(authCode)
        self:closeRequest(req)
    end
end

--[[
    DISCORD SERVER (JOIN) REWARD  
]]
local TYPE_DISCORDSERVER = zrewards.methods:RegisterType("discordserver", {InviteLink = false})
TYPE_DISCORDSERVER:SetName("Discord Server")
TYPE_DISCORDSERVER:SetDescription("Join our Discord Server!")
TYPE_DISCORDSERVER:SetIcon("materials/zrew/icon_discord.png")

function TYPE_DISCORDSERVER:isUserMethodVerified(ply, callback)
    if !(DISCORD_API) then zrewards:ConsoleMessage("[discordserver] Invalid API.") return false end

    // send request to the client for the authCode
    DISCORD_API:requestAuthCode(ply, 
    function(authCode)
        if (!IsValid(ply) or !authCode) then 
            callback(false, "Failed to retrieve user auth code")

            return 
        end

        local inviteLink = self:GetInviteLink()
 
        DISCORD_API:getUserToken(ply, authCode,
        function(token, errMsg)
            if !(token) then
                callback(false, string.format("Failed to retrieve user token %s", (errMsg || "unknown error")))

                return
            end

            DISCORD_API:getGuildMember(token,
            function(member, errMsg)
                if !(member) then
                    callback(false, string.format("Failed to retrieve member information %s", (errMsg || "unknown error")))

                    return
                end

                local roles, inGuild = member.roles, member.user

                callback((inGuild && true) || false)

                if !(inGuild) then
                    zlib.notifs:Send(ply, zrewards.lang:GetTranslation("discordArentInGuild"), (self.GetIcon != nil && self:GetIcon() || false))

                    if (inviteLink != nil) then
                        zlib.util:OpenURL(inviteLink, ply)
                    end
                end
            end)
        end)
    end)
end

--[[
    Client Events
]]
function TYPE_DISCORDSERVER:onClaimClicked(callback)
    if !(callback) then return end
    if (SERVER or !zrewards.config.notifications.showDisclaimer) then callback(true) return end

    local prompt = vgui.Create("zrewards.Prompt")
    prompt:SetConfirmText(zrewards.lang:GetTranslation("accept"))
    prompt:SetDeclineText(zrewards.lang:GetTranslation("decline"))
    prompt:SetQuestion(zrewards.lang:GetTranslation("discordDisclaimer"))
    prompt:Open()

    function prompt:onConfirm() callback(true) end
    function prompt:onDecline() callback(false) end
end

--[[
    Extra Options/Buttons
]]
TYPE_DISCORDSERVER:addOption("Open Invite Link", {
    icon = "icon16/world_go.png",
    doClick = function(s)
        net.Start("zrew.discordserver.OpenInvite")
        net.SendToServer()
    end,
})

--[[
    DISCORD BOOST REWARD
]]
local TYPE_DISCORDBOOST = zrewards.methods:RegisterType("discordboost", {BoostRoleID = false})
TYPE_DISCORDBOOST:SetName("Discord Boost")
TYPE_DISCORDBOOST:SetDescription("Boost our Discord server!")
TYPE_DISCORDBOOST:SetIcon("materials/zrew/icon_discord_boost.png")

function TYPE_DISCORDBOOST:getExtraValue(ply, callback)
    local extraVal = os.time()

    zrewards.methods:GetMethod(ply, self:GetUniqueName(),
    function(methods)
        if (methods) then
            local interval = 7 * 86400 // 7 days
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

function TYPE_DISCORDBOOST:isUserMethodVerified(ply, callback)
    if !(DISCORD_API) then
        callback(false, "Invalid API.")
        return 
    elseif (ply == nil || !ply) then
        callback(false, "Invalid player.")
        return
    end

    local stid = ply:SteamID64()

    // send request to the client for the authCode
    DISCORD_API:requestAuthCode(ply, 
    function(authCode)
        if (!IsValid(ply) or !authCode) then 
            callback(false, "Failed to retrieve user auth code")

            return 
        end

        DISCORD_API:getUserToken(ply, authCode,
        function(token, errMsg)
            if !(token) then
                callback(false, string.format("Failed to retrieve user token %s", (errMsg || "unknown error")))

                return
            end

            DISCORD_API:getGuildMember(token,
            function(member, errMsg)
                if !(member) then
                    callback(false, string.format("Failed to retrieve member information %s", (errMsg || "unknown error")))
    
                    return
                end
    
                local roles, inGuild = member.roles, member.user
                local isBooster, boostRoleID = false, self:GetBoostRoleID()
                
                if !(isstring(boostRoleID)) then
                    callback(false, string.format("Invalid boost role ID (must be a string, received %s)", type(boostRoleID)))

                    return
                elseif (boostRoleID != nil) then
                    boostRoleID = string.Trim(boostRoleID)

                    if istable(roles) then
                        for k,v in pairs(roles) do
                            if (string.Trim(v) == boostRoleID) then
                                isBooster = true
                                break
                            end
                        end
                    else
                        callback(false, string.format("Invalid Discord roles for user, please verify user has role on server. (SteamID: %s)", stid))

                        return
                    end
                end

                callback((isBooster && true) || false)

                if !(inGuild) then
                    zlib.notifs:Send(ply, zrewards.lang:GetTranslation("discordArentInGuild"), (self.GetIcon != nil && self:GetIcon() || false))
                elseif !(isBooster) then
                    zlib.notifs:Send(ply, zrewards.lang:GetTranslation("discordArentBooster"), (self.GetIcon != nil && self:GetIcon() || false))
                end
            end)
        end)
    end)
end

--[[
    Networking
]]
if (SERVER) then

    util.AddNetworkString("zrew.discordserver.OpenInvite")

    net.Receive("zrew.discordserver.OpenInvite",
    function(len, ply)
        local inviteLink = TYPE_DISCORDSERVER:GetInviteLink()

        if (inviteLink) then
            zlib.util:OpenURL(inviteLink, ply)
        end
    end)

    util.AddNetworkString("zrew.discordserver.ReceiveCode")
    util.AddNetworkString("zrew.discordserver.RequestCode")

    net.Receive("zrew.discordserver.ReceiveCode",
    function(len, ply)
        if !(IsValid(ply)) then return end
        
        local data, dataBInt = netPoint:DecompressNetData()
        local code, nonce = (data && data.code), (data && data.nonce)

        if (!code || !nonce) then return end

        // Check if user is in guild
        DISCORD_API:onReceiveAuthCode(ply, code, nonce)
    end)

else

    net.Receive("zrew.discordserver.RequestCode",
    function()
        local data, dataBInt = netPoint:DecompressNetData()

        local clientid, nonce = (data && data.clientid), (data && data.nonce)

        if (!clientid || !nonce) then return end

        DISCORD_API:onRequestAuthCode(clientid, nonce)
    end)

end