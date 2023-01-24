-- "addons\\zrewards\\lua\\zrewards\\methods\\types\\zrew_method_dailylogin.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) METHOD TYPE: Daily Login
    Developed by Zephruz
]]

local TYPE_DAILYLOGIN = zrewards.methods:RegisterType("dailylogin", {})
TYPE_DAILYLOGIN:SetName("Daily Login")
TYPE_DAILYLOGIN:SetDescription("Login daily!")
TYPE_DAILYLOGIN:SetIcon("materials/zrew/icon_dailylogin.png")

function TYPE_DAILYLOGIN:isUserMethodVerified(ply, callback)
    self:getExtraValue(ply,
    function(val)
        zrewards.methods:SetMethod(ply, "dailylogin", val, 
        function(res)
            callback(res)
        end)
    end)
end

function TYPE_DAILYLOGIN:getExtraValue(ply, callback)
    local rewDay = os.date("%m/%d/%Y", os.time())

    callback(rewDay)
end