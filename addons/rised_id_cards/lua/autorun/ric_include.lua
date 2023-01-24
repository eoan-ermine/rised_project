-- "addons\\rised_id_cards\\lua\\autorun\\ric_include.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if CLIENT then
	include("idcards/cl_idcards.lua")

	FaceMemory_Local = {}

	net.Receive("FaceMemory:Client", function(ply)
		local length = net.ReadInt(32)
		local data = net.ReadData(length)
		local memory = util.JSONToTable(util.Decompress(data))
		FaceMemory_Local = memory
	end)

	function FaceMemory_Check(ply)
		local target_steamid = ply:SteamID()
		local target_charid = ply:GetNWInt("CharID")
		local exist = false

		if LocalPlayer() == ply then
			exist = true
		end
		
		for k,v in pairs(FaceMemory_Local) do
			-- if (v["SteamID"] == target_steamid && v["CharID"] == target_charid) then
			if (v["SteamID"] == target_steamid) then
				exist = true
			end
		end

		return exist
	end
end