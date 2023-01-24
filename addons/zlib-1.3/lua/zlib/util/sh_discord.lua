-- "addons\\zlib-1.3\\lua\\zlib\\util\\sh_discord.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (SH) Discord Util
    
    - Utility written for zlib
]]

zlib.util.discord = (zlib.util.discord or {})

--[[
    Discord User Flags

    - User flags defined by the Discord API; 
        keys are the number of bits the user flag needs to be rshifted to determine the value
]]
zlib.util.discord.userFlags = {
    [0] = "Discord Employee",
    [1] = "Discord Partner",
    [2] = "HypeSquad Events",
    [3] = "Bug Hunter Level 1",
    [6]	= "House Bravery",
    [7]	= "House Brilliance",
    [8] = "House Balance",
    [9] = "Early Supporter",
    [10] = "Team User",
    [12] = "System",
    [14] = "Bug Hunter Level 2",
    [16] = "Verified Bot",
    [17] = "Verified Bot Developer"
}

function zlib.util.discord:getUserFlagName(flagVal)
    return self[flagVal]
end

function zlib.util.discord:getUserFlag(flagVal, flagID)
    return bit.rshift(flagVal, flagID) == 1
end

function zlib.util.discord:getFullRPCURI(callback, rpcURI, port)
    if !(callback) then return end

    local portRange = {6463, 6472}

    if (port && port > portRange[2]) then callback(false) return end

    local port = (port or portRange[1])
    local uri = (rpcURI || "127.0.0.1") .. ":" .. port
    
    zlib.http:JSONFetch(uri,
    function(data)
        callback(uri)
    end,
    function(...)
        self:getFullRPCURI(callback, rpcURI, port + 1) 
    end)
end

--[[
    zlib.util.discord:CreateAPI(data [table = {}])

    - Instantiates an API object that can be used to communicate w/the Discord API
]]
function zlib.util.discord:CreateAPI(data)
    local newAPI = {}

    zlib.object:SetMetatable("zlib.util.DiscordAPI", newAPI)
    
    if (data) then
        for k,v in pairs(data) do
            newAPI:setData(k,v)
        end
    end

    return newAPI
end

--[[
    Discord API Object
]]
local discAPI = zlib.object:Create("zlib.util.DiscordAPI")

discAPI:setData("GuildID", nil, {})
discAPI:setData("BotToken", nil, {})
discAPI:setData("ClientID", nil, {})
discAPI:setData("ClientSecret", nil, {})
discAPI:setData("APIURI", "https://zephruz.net/api/discord/?api=", {})
discAPI:setData("RPCURI", "http://rpc.garrysmod.site", {})

function discAPI:getUser(token, callback)
    if !(token) then return false end

    // Fetch user information
    zlib.http:JSONFetch(self:GetAPIURI() .. "/users/@me", 
    function(data)
        if (data == nil || data.error != nil) then
            callback(false, "Failed to retrieve user information " .. data.error)

            return
        end

        callback(data)
    end, nil, {
        ["Authorization"] = "Bearer " .. token,
        ["Content-Length"] = "0",
    })

    return true
end

function discAPI:getGuildMember(token, callback)
    // Fetch user information
    return self:getUser(token,
    function(data, errMsg)
        if !(data) then
            callback(false, errMsg)
            return
        end

        local memId = data.id
        local getMemRes = self:getGuildMemberByID(memId, 
        function(data, errMsg)
            if (data == nil) then
                callback(false, "Failed to retreive member information " .. (errMsg || "unknown error"))

                return
            end

            callback(data)
        end)

        if !(getMemRes) then
            callback(false, "Failed to retrieve member information") 
        end
    end, nil, {
        ["Authorization"] = "Bearer " .. token,
        ["Content-Length"] = "0",
    })
end

function discAPI:getGuildMemberByID(memId, callback)
    local botToken, guildID = self:GetBotToken(), self:GetGuildID()

    if (!botToken or !guildID or !memId) then 
        callback(false, "Invalid bot token, guild ID, or member ID.") 

        return false // failed request
    end
    
    zlib.http:JSONFetch(self:GetAPIURI() .. "/guilds/" .. guildID .. "/members/" .. memId, 
    function(data)
        callback(data)
    end, 
    function(errData)
        callback(false, (errData != nil && errData.error || "Unknown error"))
    end, 
    {
        ["Authorization"] = "Bot " .. botToken
    })

    return true // successful request
end

function discAPI:getUserToken(ply, authCode, callback)
    if (CLIENT or !IsValid(ply) or !authCode) then return false end

    local stid = ply:SteamID()

    zlib.http:JSONPost(self:GetAPIURI() .. "/oauth2/token", {
        grant_type = "authorization_code",
        code = authCode,
        client_id = self:GetClientID(),
        client_secret = self:GetClientSecret(),
    }, 
    nil, 
    function(data)
        local token = data.access_token

        if !(token) then
            callback(false, "Invalid access token. (" .. stid .. ")") 

            if (istable(data)) then
                zlib:ConsoleMessage("[discordapi] Request table:")

                for k,v in pairs(data) do
                    print("\t", k, ": ", v)

                    if (istable(v)) then 
                        PrintTable(v)
                    else
                        print(v)
                    end
                end
            end

            return
        end

        callback(token)
    end,
    function(errData)
        local errMsg = (errData != nil && errData.error)

        callback(false, "Failed to retreive user token. " .. (errMsg || "Unknown error"))
    end)

    return true
end

function discAPI:getUserAuthCode(clientid, callback, nonce)
    if (SERVER) then callback(false) return end

    zlib.util.discord:getFullRPCURI(
    function(uri)
        if !(uri) then
            zlib.notifs:Create("Discord application is not open")

            return
        end

        zlib.http:Request("POST", uri .. "/rpc?v=1&client_id=" .. clientid, {
            cmd = "AUTHORIZE",
            args = {
                client_id = clientid,
                scopes = {"guilds", "identify", "connections"},
            },
            nonce = (nonce || string.random(15)),
        },
        function(response,payload) 
            payload = zlib.util:Deserialize(payload)

            if !(istable(payload)) then return end

            local code = payload.data
            code = (code && code.code)

            if !(code) then return end

            callback(code)
        end)
    end, 
    self:GetRPCURI())
end