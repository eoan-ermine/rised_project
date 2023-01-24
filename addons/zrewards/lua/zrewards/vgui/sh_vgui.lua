-- "addons\\zrewards\\lua\\zrewards\\vgui\\sh_vgui.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (CL) VGUI
    Developed by Zephruz
]]

zrewards.vgui = (zrewards.vgui or {})

function zrewards.vgui:Load()
    local defTheme = zrewards.config.defaultTheme
    defTheme = (defTheme || "Default")

    self:SetCurrentTheme(defTheme)
end

--[[
    Includes
]]

-- Menus
AddCSLuaFile("sh_menus.lua")
include("sh_menus.lua")

-- Themes
AddCSLuaFile("sh_themes.lua")
include("sh_themes.lua")

-- [[Elements]]
local files, dirs = file.Find("zrewards/vgui/elements/cl_*", "LUA")

for k,v in pairs(files) do
    zlib.util:IncludeByPath(v, "elements/")
end