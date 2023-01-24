-- "addons\\zrewards\\lua\\zrewards\\methods\\sh_methods.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) Methods
    Developed by Zephruz

    - Methods are what a player can be rewarded FOR
        - EXAMPLE: A player can be rewarded FOR joining the discord server or steam group
        - These methods can be found (and created) in 'zrewards/lua/zrewards/methods/types/'
        - You can create your own, but it may be difficult without any prior Lua knowledge
]]

zrewards.methods = (zrewards.methods or {})
zrewards.methods.types = (zrewards.methods.types or {})

--[[
    zrewards.methods:RegisterType(name [string], data [table])
]]
function zrewards.methods:RegisterType(name, data)
    local rType = {}

    zlib.object:SetMetatable("zrewards.methodsType", rType)

    rType:SetUniqueName(name)

    if (data) then
        for k,v in pairs(data) do
            rType:setData(k,v)
        end
    end
    
    -- Config Settings
    local cfgData = zrewards.config.methodsSettings
    cfgData = (cfgData && cfgData[name])
    
    if (cfgData) then
        for k,v in pairs(cfgData) do
            rType:setData(k,v)
        end
    end

    self.types[name] = rType

    return self.types[name]
end

--[[
    zrewards.methods:GetType(name [string])
]]
function zrewards.methods:GetType(name)
    return self.types[name]
end

--[[
    zrewards.methods:GetAllTypes()
]]
function zrewards.methods:GetAllTypes()
    return self.types
end

--[[
    zrewards.methods:GetTypeRewards(name [string])

    - Returns a types rewards
]]
function zrewards.methods:GetTypeRewards(name)
    local rType = self:GetType(name)

    if !(rType) then return end

    local typeRews = {}
    local rUName = rType:GetUniqueName()

    -- Get rewards
    local rews = zrewards.config.rewards

    for k,v in pairs(rews) do
        local rewFor = v.RewardFor
        local rew = (rewFor && rewFor[rUName])

        typeRews[k] = (rew or nil)
    end

    return typeRews
end

--[[
    Method Type Metastructure
]]
local regType = zlib.object:Create("zrewards.methodsType")

regType:setData("UniqueName", "TYPE.UNIQUENAME", {})
regType:setData("Name", "TYPE.NAME", {})
regType:setData("Description", "TYPE.DESCRIPTION", {})
regType:setData("Icon", false, {})
regType:setData("VerifyOnSpawn", true, {})
regType:setData("ExtraOptions", {}, {shouldSave = false})
regType:setData("Enabled", true, {
    onGet = function(s,val)
        local isDisabled = zrewards.config.disabledMethods[s:GetUniqueName()]

        return (!isDisabled || isDisabled == false)
    end,
    onSet = function(s,val,oVal)
        local uName = s:GetUniqueName()

        val = !val // Boolean flip

        zrewards.config.disabledMethods[uName] = val

        return val
    end
})

function regType:isUserMethodVerified(ply, callback) callback(false) return false end
function regType:getExtraValue(ply, callback) callback(false) return false end

function regType:removeOption(name)
    local options = self:GetExtraOptions()

    if !(istable(options)) then options = {} end

    options[name] = nil 

    self:SetExtraOptions(options)
end

function regType:addOption(name, data)
    local options = self:GetExtraOptions()

    if !(istable(options)) then options = {} end

    options[name] = data

    self:SetExtraOptions(options)
end

--[[
    Player Meta
]]
local plyMeta = FindMetaTable("Player")

function plyMeta:SetMethodVerified(name, val)
    self:SetNW2Bool("zrew.MethodVerified[" .. name .. "]", val)
end

function plyMeta:GetMethodVerified(name)
    return self:GetNW2Bool("zrew.MethodVerified[" .. name .. "]", val)
end

--[[
    Networking
]]

--[[USER REQUESTS]]
local userReqs = {}

userReqs["getMethods"] = function(ply, val, cb)
    zrewards.methods:GetMethods(ply,
    function(regs)
        cb(regs)
    end)
end

userReqs["verifyMethod"] = function(ply, val, cb)
    local methodName = val.methodName

    if !(methodName) then return end

    -- Limit the number of requests to one every waitTime (in seconds)
    local waitTime = 1
    local nextClaim = ply[methodName .. "_nextClaim"]

    if (nextClaim && nextClaim > os.time()) then cb(false) return end

    ply[methodName .. "_nextClaim"] = (os.time() + waitTime)
    
    zrewards.methods:VerifyPlayerMethod(ply, methodName,
    function(methodName, isReg)
        cb(isReg or false)
    end)
end

zlib.network:RegisterAction("zrewards.methods.userRequest", {
    onReceive = function(ply, val, cb)
        if !(istable(val)) then return end

        local reqName, data = val.reqName, (val.data or {})
        local req = userReqs[reqName]
        
        if (req) then
            req(ply, val, cb)
        end
    end,
})

--[[ADMIN REQUESTS]]
local adminReqs = {}

adminReqs["getTotalMethods"] = function(ply, val, cb)
    local dType = zlib.data:GetConnection("zrewards.Main")

    if !(dType) then cb(0) return end

    dType:Query("SELECT COUNT(*) FROM `zrewards_methods`",
    function(data)
        data = (data && data[1])
        
        local count = (data && data["COUNT(*)"])

        cb(count or 0)
    end)
end

adminReqs["clearUserMethods"] = function(ply, val, cb)
    local stid = val.steamid

    if !(stid) then return end
    
    zrewards.methods:ClearMethods(stid, 
    function(res)
        cb(res)
    end)
end

zlib.network:RegisterAction("zrewards.methods.adminRequest", {
    adminOnly = zrewards.config.adminGroups,
    onReceive = function(ply, val, cb)
        if !(istable(val)) then return end

        local reqName, data = val.reqName, (val.data or {})
        local req = adminReqs[reqName]
        
        if (req) then
            req(ply, val, cb)
        end
    end,
})

--[[
    Includes
]]
AddCSLuaFile("cl_methods.lua")
include((SERVER && "sv" || "cl") .. "_methods.lua")

-- Method Types
local files, dirs = file.Find("zrewards/methods/types/zrew_method_*", "LUA")

for k,v in pairs(files) do
    zlib.util:IncludeByPath(v, "types/")
end