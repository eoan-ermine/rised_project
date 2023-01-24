-- "lua\\entities\\obj_npcspawner\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Initialize()
	//net.Start("slv_npctools_spawner_reqtrack")
	//	net.WriteEntity(self)
	//net.SendToServer()
end

function ENT:Draw()
end
/*
net.Receive("slv_npctools_spawner_rectrack",function(len)
	local ent = net.ReadEntity()
	if(!ent:IsValid()) then return end
	local track = net.ReadString()
	ent.m_soundtrack = track
end)

net.Receive("slv_npctools_spawner_play",function(len)
	local ent = net.ReadEntity()
	if(!ent:IsValid() || !ent.m_soundtrack) then return end
	if(cspSoundtrack) then cspSoundtrack:Stop() end
	local track = ent.m_soundtrack
	cspSoundtrack = CreateSound(LocalPlayer(),track)
	cspSoundtrack:SetSoundLevel(0.2)
	cspSoundtrack:Play()
	local dur = SoundDuration(track) // Doesn't work with .mp3 files
	local tm = RealTime() +dur
	hook.Add("Think","slv_npc_soundtrack",function()
		if(!ent:IsValid()) then
			cspSoundtrack:FadeOut(4)
			hook.Remove("Think","slv_npc_soundtrack")
			return
		end
		if(RealTime() >= tm) then
			cspSoundtrack:Stop()
			cspSoundtrack = CreateSound(LocalPlayer(),track)
			cspSoundtrack:SetSoundLevel(0.2)
			cspSoundtrack:Play()
			tm = RealTime() +dur
		end
	end)
end)

local cspSoundtrack
net.Receive("slv_npc_soundtrack",function(len)
	local ent = net.ReadEntity()
	if(!ent:IsValid()) then return end

end)
*/