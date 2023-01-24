-- "addons\\rised_death_system\\lua\\entities\\gas_canister\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile( "eds_config.lua" )
include( "eds_config.lua" )
include('shared.lua')   
function ENT:Draw()  
	self:DrawModel()
end  

local function CanisterOutline(ent)
	if(!IsValid(ent)) then return end
	local entities = {}
	table.insert( entities, ent )
	halo.Add( entities, EDS.BodyOutlineColor, 2, 2, 2, true, false )
end

hook.Add("HUDPaint", "DrawCanisterInfo", function()
	local tr = LocalPlayer():GetEyeTrace()
	local ent = tr.Entity
	if(!IsValid(ent)) then return end
	
	if ent:GetClass() == "gas_canister" then
		local Distance = ent:GetPos():Distance(LocalPlayer():GetPos())
		if(Distance<100) then
			CanisterOutline(ent)
			draw.DrawText( EDS.text32, "CorpseInspectFont", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
			draw.DrawText( EDS.text33, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
		end
	end

end)