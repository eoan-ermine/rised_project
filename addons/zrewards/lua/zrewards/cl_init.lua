-- "addons\\zrewards\\lua\\zrewards\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (CL) Init
    Developed by Zephruz
]]

function zrewards:Notification(...)
    chat.AddText(Color(125,255,0), "[ZRewards] ", Color(255,255,255), ...)
end