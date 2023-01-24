-- "gamemodes\\sandbox\\gamemode\\cl_notice.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

function GM:AddNotify( str, type, length )

	notification.AddLegacy( str, type, length )

end

function GM:PaintNotes()
end
