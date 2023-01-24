-- "addons\\bricks-crafting\\lua\\brickscrafting\\brickscrafting_player_skills.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local ply_meta = FindMetaTable( "Player" )

function ply_meta:GetBCS_SkillLevel( BenchType )
	local SkillLevel = 0
	
	if( SERVER ) then
		if( self:GetBCS_Skills()[BenchType] ) then
			SkillLevel = self:GetBCS_Skills()[BenchType]
		end
	elseif( CLIENT ) then
		if( BCS_Skills ) then
			if( BCS_Skills[BenchType] ) then
				SkillLevel = BCS_Skills[BenchType]
			end
		end
	end

	return SkillLevel
end

if( SERVER ) then
	util.AddNetworkString( "BCS_Net_SendClientNotfication" )
	function ply_meta:NotifyBCS_Chat( text, icon )
		net.Start( "BCS_Net_SendClientNotfication" )
			net.WriteString( text )
			net.WriteString( icon )
		net.Send( self )
	end
	
	function ply_meta:IncreaseBCS_SkillLevel( BenchType, Increase )
		if( BRICKSCRAFTING.CONFIG.Crafting[BenchType] and BRICKSCRAFTING.CONFIG.Crafting[BenchType].Skill ) then
			local SkillTable = BRICKSCRAFTING.CONFIG.Crafting[BenchType].Skill
			local SkillLevel = self:GetBCS_SkillLevel( BenchType )
			
			if( SkillLevel >= SkillTable[2] ) then return end
			
			local PlySkills = self:GetBCS_Skills()
			PlySkills[BenchType] = math.Clamp( (PlySkills[BenchType] or 0)+Increase, 0, SkillTable[2] )
			
			self:SetBCS_Skills( PlySkills )
			
			self:NotifyBCS_Chat( "+" .. Increase .. " " .. SkillTable[1], "materials/brickscrafting/general_icons/skillincrease.png" )
		elseif( BenchType == "Mining" ) then
			local SkillLevel = self:GetBCS_SkillLevel( BenchType )
			
			if( SkillLevel >= BRICKSCRAFTING.CONFIG.Tools.MaxPickaxeSkill ) then return end
			
			local PlySkills = self:GetBCS_Skills()
			PlySkills[BenchType] = math.Clamp( (PlySkills[BenchType] or 0)+Increase, 0, BRICKSCRAFTING.CONFIG.Tools.MaxPickaxeSkill )
			
			self:SetBCS_Skills( PlySkills )
			
			self:NotifyBCS_Chat( "+" .. Increase .. " " .. BRICKSCRAFTING.L("mining"), "materials/brickscrafting/general_icons/skillincrease.png" )
		elseif( BenchType == "Wood Cutting" ) then
			local SkillLevel = self:GetBCS_SkillLevel( BenchType )
			
			if( SkillLevel >= BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill ) then return end
			
			local PlySkills = self:GetBCS_Skills()
			PlySkills[BenchType] = math.Clamp( (PlySkills[BenchType] or 0)+Increase, 0, BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill )
			
			self:SetBCS_Skills( PlySkills )
			
			self:NotifyBCS_Chat( "+" .. Increase .. " " .. BRICKSCRAFTING.L("woodCutting"), "materials/brickscrafting/general_icons/skillincrease.png" )
		end
	end

	function ply_meta:SetBCS_SkillLevel( BenchType, newSkillLevel )
		if( BRICKSCRAFTING.CONFIG.Crafting[BenchType] and BRICKSCRAFTING.CONFIG.Crafting[BenchType].Skill ) then
			local SkillTable = BRICKSCRAFTING.CONFIG.Crafting[BenchType].Skill
			local SkillLevel = self:GetBCS_SkillLevel( BenchType )

			local PlySkills = self:GetBCS_Skills()
			PlySkills[BenchType] = math.Clamp( newSkillLevel, 0, SkillTable[2] )
			
			self:SetBCS_Skills( PlySkills )
			
			self:NotifyBCS_Chat( "+" .. newSkillLevel .. " " .. SkillTable[1], "materials/brickscrafting/general_icons/skillincrease.png" )
		elseif( BenchType == "Mining" ) then
			local SkillLevel = self:GetBCS_SkillLevel( BenchType )
			
			local PlySkills = self:GetBCS_Skills()
			PlySkills[BenchType] = math.Clamp( newSkillLevel, 0, BRICKSCRAFTING.CONFIG.Tools.MaxPickaxeSkill )
			
			self:SetBCS_Skills( PlySkills )

			self:NotifyBCS_Chat( "+" .. newSkillLevel .. " " .. BRICKSCRAFTING.L("mining"), "materials/brickscrafting/general_icons/skillincrease.png" )
		elseif( BenchType == "Wood Cutting" ) then
			local SkillLevel = self:GetBCS_SkillLevel( BenchType )
			
			local PlySkills = self:GetBCS_Skills()
			PlySkills[BenchType] = math.Clamp( newSkillLevel, 0, BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill )
			
			self:SetBCS_Skills( PlySkills )
			
			self:NotifyBCS_Chat( "+" .. newSkillLevel .. " " .. BRICKSCRAFTING.L("woodCutting"), "materials/brickscrafting/general_icons/skillincrease.png" )
		end
	end

	util.AddNetworkString( "BCS_Net_UpdateClientSkills" )
	function ply_meta:BCS_UpdateClientSkills()
		local SkillsTable = self:GetBCS_Skills() or {}
		
		net.Start( "BCS_Net_UpdateClientSkills" )
			net.WriteTable( SkillsTable )
		net.Send( self )
	end	
	
	function ply_meta:SetBCS_Skills( SkillsTable, nosave )
		if( not SkillsTable ) then return end
		self.BCS_Skills = SkillsTable
		
		self:BCS_UpdateClientSkills()
		
		if( not nosave ) then
			self:SaveBCS_Skills()
		end
	end
	
	function ply_meta:GetBCS_Skills()
		local Skills = self.BCS_Skills or {}
		return Skills
	end
	
	function ply_meta:SaveBCS_Skills()
		local Skills = self:GetBCS_Skills()
		if( Skills != nil ) then
			if( not istable( Skills ) ) then
				Skills = {}
			end
		else
			Skills = {}
		end
		
		local SkillsJSON = util.TableToJSON( Skills )
		
		if( BRICKSCRAFTING.LUACONFIG.UseMySQL != true ) then
			if( not file.Exists( "brickscrafting/skills", "DATA" ) ) then
				file.CreateDir( "brickscrafting/skills" )
			end
			
			file.Write( "brickscrafting/skills/" .. self:SteamID64() .. ".txt", SkillsJSON )
		else
			self:BCS_UpdateDBValue( "skills", SkillsJSON )
		end
	end
	
	hook.Add( "PlayerInitialSpawn", "BCSHooks_PlayerInitialSpawn_SkillsLoad", function( ply )
		local SkillsTable = {}
	
		if( BRICKSCRAFTING.LUACONFIG.UseMySQL != true ) then
			if( file.Exists( "brickscrafting/skills/" .. ply:SteamID64() .. ".txt", "DATA" ) ) then
				local FileTable = file.Read( "brickscrafting/skills/" .. ply:SteamID64() .. ".txt", "DATA" )
				FileTable = util.JSONToTable( FileTable )
				
				if( FileTable != nil ) then
					if( istable( FileTable ) ) then
						SkillsTable = FileTable
					end
				end
			end
			
			ply:SetBCS_Skills( SkillsTable, true )
		else
			ply:BCS_FetchDBValue( "skills", function( value )
				if( value ) then
					local FileTable = util.JSONToTable( value )

					if( FileTable != nil ) then
						if( istable( FileTable ) ) then
							SkillsTable = FileTable
						end
					end

					ply:SetBCS_Skills( SkillsTable, true )
				end
			end )
		end
	end )
elseif( CLIENT ) then
	net.Receive( "BCS_Net_SendClientNotfication", function( len, ply )
		local Text = net.ReadString() or ""
		local Icon = net.ReadString() or ""
		
		BCS_DRAWING.AddNotification( Text, Icon )
	end )	
	
	net.Receive( "BCS_Net_UpdateClientSkills", function( len, ply )
		local SkillsTable = net.ReadTable() or {}
		
		BCS_Skills = SkillsTable
	end )
end