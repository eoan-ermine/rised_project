-- "addons\\simple_thirdperson\\lua\\autorun\\thirdperson.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if CLIENT then

	local on = false
	
	thirdviewenabled = false		
	
	local thirdpersonview_enable = GetConVar( "rised_thirdpersonview_enable" )
	on = thirdpersonview_enable:GetBool()
	thirdviewenabled = thirdpersonview_enable:GetBool()	
	
	function togglethirdperson()
	
		on = thirdpersonview_enable:GetBool()
		
		thirdviewenabled = thirdpersonview_enable:GetBool()	
		
	end
	
	function togglethirdpersonConsole()
	
		local thirdpersonview_enable2 = GetConVar( "rised_thirdpersonview_enable" )
		thirdpersonview_enable2:SetBool( not thirdpersonview_enable2:GetBool() )
	
		on = not thirdpersonview_enable2:GetBool()
		
		thirdviewenabled = not thirdpersonview_enable2:GetBool()
		
	end
	
	net.Receive("sv_togglethirdperson")
	 
	function CalcThirdperson(ply, pos, ang, fov)
		local thirdpersonview_enable = GetConVar( "rised_thirdpersonview_enable" )
		if thirdpersonview_enable:GetBool() then
					local view = {};
					local dist = 65;
					local left = 10;
					local trace = {};
					
					trace.start = pos;
					trace.endpos = pos - ( ang:Forward() * dist );
					trace.filter = LocalPlayer();
					local trace = util.TraceLine( trace );
					if( trace.HitPos:Distance( pos ) < dist - 10 ) then
						dist = trace.HitPos:Distance( pos ) - 10;
					end;
					view.origin = pos - ( ang:Forward() * dist ) - ( ang:Right() * -left );
					view.angles = ang;
					view.fov = fov;
					
					return view;
		end
	end
 
	hook.Add("CalcView", "CalcThirdperson", CalcThirdperson)
 
	hook.Add("ShouldDrawLocalPlayer", "MyHax ShouldDrawLocalPlayer", function(ply)
		if thirdpersonview_enable:GetBool() then
			return true
		end
	end)
 
	concommand.Add("togglethirdperson", togglethirdpersonConsole)
end