-- "addons\\zrewards\\lua\\zrewards\\vgui\\themes\\zrew_theme_default.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI THEME - Default
    Developed by Zephruz
]]

local DEFAULT_THEME = zrewards.vgui:RegisterTheme("Default")

--[[BUTTON]]
DEFAULT_THEME:AddColor("button.Background", Color(183,75,75))
DEFAULT_THEME:AddColor("button.BackgroundHover", Color(163,55,55))
DEFAULT_THEME:AddColor("button.Text", Color(255,255,255))

--[[CLOSE BUTTON]]
DEFAULT_THEME:AddColor("closeButton.Background", Color(183,75,75))
DEFAULT_THEME:AddColor("closeButton.BackgroundHover", Color(163,55,55))
DEFAULT_THEME:AddColor("closeButton.Text", Color(255,255,255))

--[[FRAME]]
DEFAULT_THEME:AddColor("frame.Background", Color(55,55,55,175))
DEFAULT_THEME:AddColor("frame.TopNav.Background", Color(30,30,30))
DEFAULT_THEME:AddColor("frame.TopNav.Title", Color(255,255,255))

--[[CONTAINER]]
DEFAULT_THEME:AddColor("container.Background", Color(45,45,45))

--[[SCROLLPANEL]]
DEFAULT_THEME:AddColor("scrollpanel.ScrollBar.GRIP", Color(35,35,35,125))

--[[TEXT ENTRY]]
DEFAULT_THEME:AddColor("textentry.Background", Color(65,65,65))
DEFAULT_THEME:AddColor("textentry.BackgroundActive", Color(75,75,75))
DEFAULT_THEME:AddColor("textentry.Text", Color(255,255,255))

--[[CHECK BOX]]
DEFAULT_THEME:AddColor("checkBox.Background", Color(55,55,55))
DEFAULT_THEME:AddColor("checkBox.Background.Active", Color(85,175,85))

--[[HEADER]]
DEFAULT_THEME:AddColor("header.Background", Color(30,30,30))
DEFAULT_THEME:AddColor("header.Text", Color(255,255,255))