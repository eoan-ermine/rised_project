-- "igs\\extensions\\levels.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[-------------------------------------------------------------------------
	Поддержка вот этого говнокода:
	https://github.com/vrondakis/Leveling-System
---------------------------------------------------------------------------]]
local STORE_ITEM = FindMetaTable("IGSItem")

function STORE_ITEM:SetLevels(iAmount)
	return self:SetInstaller(function(pl)
		pl:addLevels(iAmount)
	end)
end

function STORE_ITEM:SetEXP(iAmount)
	return self:SetInstaller(function(pl)
		pl:addXP(iAmount)
	end)
end
