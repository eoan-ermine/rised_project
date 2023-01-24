-- "addons\\farmmod\\lua\\autorun\\farm_load.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function LoadAllFiles( fdir )

	local files,dirs = file.Find( fdir.."*", "LUA" )
	
	for _,file in ipairs( files ) do
		if string.match( file, ".lua" ) then

			if SERVER then AddCSLuaFile( fdir..file ) end
			include( fdir..file )
		end	
	end
	
	for _,dir in ipairs( dirs ) do
		LoadAllFiles( fdir..dir.."/" )
	
	end
	
end

LoadAllFiles( "farming/" )