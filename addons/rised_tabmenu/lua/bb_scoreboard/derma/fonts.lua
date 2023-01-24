-- "addons\\rised_tabmenu\\lua\\bb_scoreboard\\derma\\fonts.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Raleway, Raleway ExtraBold
do 	--- Fonts creating
	for i = 9, 36 do
		surface.CreateFont( "Raleway "..i, {
			font = "Raleway",
			size = i,
			weight = 200
		} );

		surface.CreateFont( "Raleway ExtraBold "..i, {
			font = "Raleway ExtraBold",
			size = i,
			weight = 200
		} );

		surface.CreateFont( "Raleway Bold "..i, {
			font = "Raleway Bold",
			size = i,
			weight = 200
		} );
	end;
end