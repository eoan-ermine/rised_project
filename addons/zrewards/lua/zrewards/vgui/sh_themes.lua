-- "addons\\zrewards\\lua\\zrewards\\vgui\\sh_themes.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) THEMES
    Developed by Zephruz
]]

zrewards.vgui.themes = (zrewards.vgui.themes or {})
zrewards.vgui._currentTheme = (zrewards.vgui._currentTheme or false)

function zrewards.vgui:SetCurrentTheme(name)
    local theme = self:GetTheme(name)

    if !(theme) then return end

    self._currentTheme = theme
end

function zrewards.vgui:GetCurrentTheme()
    return self._currentTheme
end

function zrewards.vgui:GetTheme(name)
    return self.themes[name]
end

function zrewards.vgui:RegisterTheme(name, data)
    local themeTbl = {}

    zlib.object:SetMetatable("zrewards.Theme", themeTbl)

    themeTbl:SetName(name)

    if (data) then
        for k,v in pairs(data) do
            themeTbl:setData(k,v)
        end
    end

    self.themes[name] = themeTbl

    return self.themes[name]
end

--[[
    Theme Metastructure
]]
local themeMeta = zlib.object:Create("zrewards.Theme", {})

themeMeta:setData("Name", "THEME.NAME", {})
themeMeta:setData("Colors", {}, {})

function themeMeta:AddColor(id, color)
    local colors = self:GetColors()

    colors[id] = color

    self:SetColors(colors)
end

function themeMeta:GetColor(id)
    local colors = self:GetColors()

    return colors[id]
end

--[[
    Includes
]]

-- Themes
local files, dirs = file.Find("zrewards/vgui/themes/zrew_theme_*", "LUA")

for k,v in pairs(files) do
    zlib.util:IncludeByPath(v, "themes/")
end