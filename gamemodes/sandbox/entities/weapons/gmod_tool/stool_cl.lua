-- "gamemodes\\sandbox\\entities\\weapons\\gmod_tool\\stool_cl.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-- Tool should return true if freezing the view angles
function ToolObj:FreezeMovement()
	return false 
end

-- The tool's opportunity to draw to the HUD
function ToolObj:DrawHUD()
end
