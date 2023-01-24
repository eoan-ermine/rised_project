-- "addons\\rised_f4menu\\lua\\bb_f4menu\\derma\\fonts.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Raleway, Raleway ExtraBold
do 	--- Fonts creating
	for i = 9, 36 do
		surface.CreateFont( "Raleway "..i, {
			font = "CloseCaption_Normal",
			size = i,
			weight = 100
		} );

		surface.CreateFont( "Raleway ExtraBold "..i, {
			font = "CloseCaption_BoldItalic",
			size = i,
			weight = 100
		} );

		surface.CreateFont( "Raleway Bold "..i, {
			font = "CloseCaption_Bold",
			size = i,
			weight = 100
		} );
	end;
end