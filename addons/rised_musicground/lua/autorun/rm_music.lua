-- "addons\\rised_musicground\\lua\\autorun\\rm_music.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal


RM = RM or {}

RM.InCombat = false

-----------------------------------------------
-- SERVER COMBAT CHECKS --
if SERVER then 

	hook.Add( "Think", "risedMusic.find.hostiles.Think", function()
		if timer.Exists( "risedMusic.find.hostiles.Timer" ) then return end
		timer.Create( "risedMusic.find.hostiles.Timer", 2, 1, function() end ) 

		Nombat_Sv_FindHostile()
	end	)

	-- Near enemy NPC --
	function Nombat_Sv_FindHostile()
		local players = {}

		for _, npc in pairs (ents.FindByClass("*npc*")) do
			local e = ( npc.GetEnemy and npc:GetEnemy() )
			if TypeID(e) == TYPE_ENTITY and IsValid(e) then
				if e.IsPlayer and e:IsPlayer() then
					if npc:IsLineOfSightClear(e) and ((e.Health and e:Health() > 0) or (e.Alive and e:Alive())) then
						players[ e ] = true
					end
				end
			end
		end

		for p, _ in pairs( players ) do
			if p.ConCommand then
				p:ConCommand("risedMusic.client.has.hostiles")
			end
		end
	end

	-- Enemies hit player --
	hook.Add("PlayerHurt", "risedMusic.enemy.hit.player", function(victim, attacker)
		
		if !victim:IsPlayer() or !attacker:IsPlayer() then return end

		if victim != attacker and attacker:GetActiveWeapon():GetClass() != 'weapon_cp_stick' then
			victim:ConCommand("risedMusic.client.has.hostiles")
			attacker:ConCommand("risedMusic.client.has.hostiles")
		end
	end)
end



-----------------------------------------------
-- RM CORE CLIENTSIDE --
if CLIENT then
	
	CreateConVar( "risedMusic.volume", "zejton20", {FCVAR_ARCHIVE}, "The volume of the music played via risedMusic" )
	
	local risedMusicTimer = 0
	hook.Add( "Think", "cl.risedMusic.Think", function()

		if CurTime() > risedMusicTimer then
			risedMusicTimer = CurTime() + 3

			RM:SwitchSong()
			RM:UpdateVolume()
		end
	end )
	
	function RM:SwitchSong()

		local v = (GetConVar( "risedMusic.volume" ) and GetConVar( "risedMusic.volume" ):GetInt() or 0) / 100
		if v <= 0 then return end
		
		local ambientSong = table.Random(RISED.Config.Music.Ambient)
		local combatSong = table.Random(RISED.Config.Music.Combat)

		-- AMBIENT
		if CurTime() >= (RM.GetAmbientTimeout or 0) and !RM.InCombat then
			RM.GetCombatTimeout = 0
			RM:SetAmbientSong( ambientSong.SoundPath, ambientSong.SoundDuration )
		end
		
		-- COMBAT
		if CurTime() >= (RM.GetCombatTimeout or 0) and RM.InCombat then
			RM.GetAmbientTimeout = 0
			RM:SetCombatSong( combatSong.SoundPath, combatSong.SoundDuration )
		end
	end
	
	function RM:UpdateVolume() 
		local ambientEmitter = RM:GetAmbientEmitter()
		local combatEmitter = RM:GetCombatEmitter()
		
		local volume = (GetConVar( "risedMusic.volume" ) and GetConVar( "risedMusic.volume" ):GetInt() or 0) / 100
		local musicDisabled = !GetConVar("risedMusic.enabled"):GetBool()
		local disableOnDeath = !LocalPlayer():Alive()
		local musicStopped = LocalPlayer():GetNWInt("Rised_Music_StopTime") > CurTime()
		
		-- Music disabled
		if musicDisabled or disableOnDeath or musicStopped then
			if ambientEmitter then
				ambientEmitter:ChangeVolume( 0, 0 )
			end
			
			if combatEmitter then
				combatEmitter:ChangeVolume( 0, 0 )
			end
		
			return
		end

		if ambientEmitter then ambientEmitter:ChangeVolume(0,1) end
		if combatEmitter then combatEmitter:ChangeVolume(0,1) end
		
		local ambientVolume = volume
		local combatVolume = volume

		if !RM.InCombat then
			ambientVolume = volume
			combatVolume = 0
		else
			ambientVolume = 0
			combatVolume = volume
		end
		
		-- change volume
		if ambientEmitter then ambientEmitter:ChangeVolume(ambientVolume, 2) end
		if combatEmitter then combatEmitter:ChangeVolume(combatVolume, 2) end
	end
	
	function RM:SetAmbientSong( path, duration )

		if !path then return end
		
		local e = RM:GetAmbientEmitter()
		if e and e.IsPlaying and e:IsPlaying() then e:Stop() end

		e = CreateSound( LocalPlayer(), path )
		e:SetSoundLevel( 50 )
		e:PlayEx( 0, 100 )

		RM.AmbientEmitter = e
		RM.GetAmbientTimeout = CurTime() + duration
	end

	function RM:SetCombatSong( path, duration ) 
		
		if !path then return end
		
		local e = RM:GetCombatEmitter()
		if e and e.IsPlaying and e:IsPlaying() then e:Stop() end

		e = CreateSound( LocalPlayer(), path )
		e:SetSoundLevel( 50 )
		e:PlayEx( 0, 100 )

		RM.CombatEmitter = e
		RM.GetCombatTimeout = CurTime() + duration
	end
	
	function RM:GetAmbientEmitter()	
		return RM.AmbientEmitter 
	end
	function RM:GetCombatEmitter()	
		return RM.CombatEmitter
	end
	
	concommand.Add( "risedMusic.test", function(p)
		local ambientEmitter = RM:GetAmbientEmitter()
		local combatEmitter = RM:GetCombatEmitter()

		ambientEmitter:ChangeVolume(0,1)
		combatEmitter:ChangeVolume(0.2,1)
	end )
	concommand.Add( "risedMusic.test2", function(p)
		local ambientEmitter = RM:GetAmbientEmitter()
		local combatEmitter = RM:GetCombatEmitter()

		ambientEmitter:ChangeVolume(0,1)
		combatEmitter:ChangeVolume(0,1)
	end )
	------------------------------------------------------------------
	-- RM HAS HOSTILE CLIENT TRIGGER --
	concommand.Add( "risedMusic.client.has.hostiles", function(p)
		timer.Create( "cl.NombatInCombatReset.Timer", RISED.Config.CombatResetDelay, 1, function()
			RM.InCombat = false
		end )
		RM.InCombat = true
	end )
	
	concommand.Add( "risedMusic.next.ambient", function() 
		RM.GetAmbientTimeout = 0
	end )
	concommand.Add( "risedMusic.next.combat", function()
		RM.GetCombatTimeout = 0
	end )
	concommand.Add( "risedMusic.next.ambient.and.combat", function() 
		RunConsoleCommand( "risedMusic.next.ambient" )
		RunConsoleCommand( "risedMusic.next.combat" )
	end )

end