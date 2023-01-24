-- "lua\\weapons\\gmod_tool\\stools\\nocollide_world.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TOOL.Category		= "Construction"
TOOL.Name			= "#No Collide World"
TOOL.Command		= nil
TOOL.ConfigName		= nil

TOOL.ClientConVar["options"] = "1"
TOOL.ClientConVar["distance"] = "10"
TOOL.ClientConVar["ignore"] = "1"
TOOL.ClientConVar["effect"] = "0"
TOOL.ClientConVar["remove"] = "0"

if SERVER then
	resource.AddFile("materials/effects/render_vector.vtf")
	resource.AddFile("materials/effects/render_vector.vmt")
	util.AddNetworkString("DrawNoCollide")
end

if CLIENT then
	language.Add("Tool.nocollide_world.name", "No collide world")
	language.Add("Tool.nocollide_world.desc", "To let an objects ignore collisions")
	language.Add("Tool.nocollide_world.0", "Click on 2 objects or world to make them not collide or right click to make an object not collide with anything.")
	language.Add("Tool.nocollide_world.1", "Now click on something else.")
	language.Add("Tool.nocollide_world.2", "Click on an object to prevent it from colliding with the world or right click to make an object not collide with anything.")
	language.Add("Tool.nocollide_world.3", "Click on 2 objects with or without connected objects to make them not collide including connected objects or right click to make an object not collide with anything.")
	language.Add("Tool.nocollide_world.4", "Now click on something else.")
	language.Add("Tool.nocollide_world.5", "Click on an object with connected objects to prevent it from colliding with each other or right click to make an object not collide with anything.")
	language.Add("Tool.nocollide_world.6", "Prevent an object from colliding with players or right click to make an object not collide with anything.")
	language.Add("Tool.nocollide_world.7", "Prevent an object from colliding with objects within box or right click to make an object not collide with anything.")
	language.Add("Tool.nocollide_world.8", "Prevent an object from colliding with objects within sphere or right click to make an object not collide with anything.")
	language.Add("Tool.nocollide_world.9", "Click on an object to select. Right click to apply no collide between all selected objects.")
	
	local EFFECT = {}
	EFFECT.Draw = {}
	EFFECT.Register = {}
	EFFECT.Ents = {}
	--[[
		EFFECT.Ents[Index][1] = Entity
		EFFECT.Ents[Index][2] = Color
		EFFECT.Ents[Index][3] = Rendermode
		EFFECT.Ents[Index][4][Type] = Eff_Count
		or
		EFFECT.Ents[Index][4][Type][Count] = Eff_Count
		
		EFFECT.Register[Type][Eff_Count][Ent_Count] = Index
		EFFECT.Register[Type][Eff_Count][3] = DrawCount
	]]
	
	local function RegisterEffect(Type,Index,Ent,Count)
		if !EFFECT.Ents[Index] then EFFECT.Ents[Index] = {} end
		if !EFFECT.Ents[Index][1] then EFFECT.Ents[Index][1] = Ent end
		if !EFFECT.Ents[Index][2] then EFFECT.Ents[Index][2] = Ent:GetColor() end
		if !EFFECT.Ents[Index][3] then EFFECT.Ents[Index][3] = Ent:GetRenderMode() end
		
		if !EFFECT.Register[Type] then EFFECT.Register[Type] = {} end
		Count = Count or #EFFECT.Register[Type]+1
		if !EFFECT.Register[Type][Count] then EFFECT.Register[Type][Count] = {} end
		if EFFECT.Register[Type][Count][1] then EFFECT.Register[Type][Count][2] = Index else EFFECT.Register[Type][Count][1] = Index end
		
		if !EFFECT.Ents[Index][4] then EFFECT.Ents[Index][4] = {} end
		if Type == 1 or Type == 2 or Type == 3 or Type == 4 or Type == 15 or Type == 16 or Type == 17 then
			if !EFFECT.Ents[Index][4][Type] then EFFECT.Ents[Index][4][Type] = {} end
			EFFECT.Ents[Index][4][Type][#EFFECT.Ents[Index][4][Type]+1] = Count
		else
			EFFECT.Ents[Index][4][Type] = Count
		end
		return Count
	end
	
	local function CleanupTables()
		local DrawPositions = {}
		local NewDraw = {}
		local Count = 0
		for i=1,#EFFECT.Draw do
			if EFFECT.Draw[i] then
				Count = Count+1
				DrawPositions[i] = Count
				NewDraw[Count] = EFFECT.Draw[i]
			end
		end
		EFFECT.Draw = NewDraw
		
		local RegisterPositions = {}
		local NewRegister = {}
		Count = {}
		
		for Type,v in pairs(EFFECT.Register) do
			RegisterPositions[Type] = {}
			NewRegister[Type] = {}
			Count[Type] = 0
			for EffectCount=1,#EFFECT.Register[Type] do
				if EFFECT.Register[Type][EffectCount] then
					Count[Type] = Count[Type]+1
					RegisterPositions[Type][EffectCount] = Count[Type]
					NewRegister[Type][Count[Type]] = EFFECT.Register[Type][EffectCount]
					if EFFECT.Register[Type][EffectCount][3] then NewRegister[Type][Count[Type]][3] = DrawPositions[EFFECT.Register[Type][EffectCount][3]] end
				end
			end
		end
		
		local Continue
		for k,v in pairs(Count) do
			if v > 0 then
				Continue = true
				break
			end
		end
		
		if Continue then
			EFFECT.Register = NewRegister
			
			for Index,v1 in pairs(EFFECT.Ents) do if EFFECT.Ents[Index] and EFFECT.Ents[Index][4] then for Type,v2 in pairs(EFFECT.Ents[Index][4]) do if RegisterPositions[Type] then if Type == 1 or Type == 2 or Type == 3 or Type == 4 or Type == 15 or Type == 16 or Type == 17 then for k3,v3 in pairs(v2) do EFFECT.Ents[Index][4][Type][k3] = RegisterPositions[Type][v3] end else EFFECT.Ents[Index][4][Type] = RegisterPositions[Type][v2] end else EFFECT.Ents[Index][4][Type] = nil end end end end
			
			local EntFound
			for k,v in pairs(EFFECT.Ents) do
				if v then
					EntFound = true
					break
				end
			end
			if !EntFound then
				EFFECT.Draw = {}
				EFFECT.Register = {}
				EFFECT.Ents = {}
				if EFFECT.Remove == false then EFFECT.Remove = true end
			end
		else
			for k,v in pairs(EFFECT.Ents) do
				if v then
					local Ent = v[1]
					if IsValid(Ent) then
						Ent:SetColor(v[2])
						Ent:SetRenderMode(v[3])
					end
				end
			end
			EFFECT.Draw = {}
			EFFECT.Register = {}
			EFFECT.Ents = {}
			if EFFECT.Remove == false then EFFECT.Remove = true end
		end
	end
	
	local function RemoveEntFromEffect(Ent,Index,Type,EffectCount)
		if IsValid(Ent) and type(Index) == "number" and EFFECT.Ents[Index] then
			local Found
			local Removed
			for k1,v1 in pairs(EFFECT.Ents[Index][4]) do
				if k1 == Type then
					if type(v1) == "table" then
						for k2,v2 in pairs(v1) do
							if v2 == EffectCount then
								EFFECT.Ents[Index][4][k1][k2] = nil
								if Found then return end
								Removed = true
							else
								if Removed then return end
								Found = true
							end
						end
					else
						EFFECT.Ents[Index][4][k1] = nil
						if Found then return end
						Removed = true
					end
				else
					if type(v1) == "table" then
						for k2,v2 in pairs(v1) do
							if Removed then return end
							Found = true
							break
						end
					else
						if Removed then return end
						Found = true
					end
				end
			end
			if !Found then
				Ent:SetColor(EFFECT.Ents[Index][2])
				Ent:SetRenderMode(EFFECT.Ents[Index][3])
				EFFECT.Ents[Index] = false
			end
		elseif Index then
			EFFECT.Ents[Index] = false
		end
	end
	
	net.Receive("DrawNoCollide",function()
		local String = net.ReadString()
		if String == "0" then
			EFFECT.Draw = {}
			EFFECT.Register = {}
			for k,v in pairs(EFFECT.Ents) do
				if v then
					local Ent = v[1]
					if IsValid(Ent) then
						Ent:SetColor(v[2])
						Ent:SetRenderMode(v[3])
					end
				end
			end
			EFFECT.Ents = {}
			if EFFECT.Remove == false then EFFECT.Remove = true end
		elseif String == "0a" then
			for Type,v1 in pairs(EFFECT.Register) do
				if Type == 1 or Type == 2 or Type == 3 or Type == 4 then
					for EffectCount=1,#EFFECT.Register[Type] do
						if EFFECT.Register[Type][EffectCount] then
							local Ent1Index,Ent2Index = EFFECT.Register[Type][EffectCount][1],EFFECT.Register[Type][EffectCount][2]
							local Ent1
							local Ent2
							if Ent1Index and EFFECT.Ents[Ent1Index] then Ent1 = EFFECT.Ents[Ent1Index][1] end
							if Ent2Index and EFFECT.Ents[Ent2Index] then Ent2 = EFFECT.Ents[Ent2Index][1] end
							if EFFECT.Register[Type][EffectCount][3] and EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] then EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] = false end
							RemoveEntFromEffect(Ent1,Ent1Index,Type,EffectCount)
							RemoveEntFromEffect(Ent2,Ent2Index,Type,EffectCount)
							EFFECT.Register[Type][EffectCount] = false
						end
					end
				elseif Type == 5 or Type == 6 or Type == 7 or Type == 8 or Type == 9 or Type == 10 or Type == 11 then
					for EffectCount=1,#EFFECT.Register[Type] do
						if EFFECT.Register[Type][EffectCount] then
							local Ent1Index = EFFECT.Register[Type][EffectCount][1]
							local Ent1
							if Ent1Index and EFFECT.Ents[Ent1Index] then Ent1 = EFFECT.Ents[Ent1Index][1] end
							if EFFECT.Register[Type][EffectCount][3] and EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] then EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] = false end
							RemoveEntFromEffect(Ent1,Ent1Index,Type,EffectCount)
							EFFECT.Register[Type][EffectCount] = false
						end
					end
				end
			end
			CleanupTables()
		elseif String == "0b" then
			for Type,v1 in pairs(EFFECT.Register) do
				if Type == 15 or Type == 16 or Type == 17 then
					for EffectCount=1,#EFFECT.Register[Type] do
						if EFFECT.Register[Type][EffectCount] then
							local Ent1Index,Ent2Index = EFFECT.Register[Type][EffectCount][1],EFFECT.Register[Type][EffectCount][2]
							local Ent1
							local Ent2
							if Ent1Index and EFFECT.Ents[Ent1Index] then Ent1 = EFFECT.Ents[Ent1Index][1] end
							if Ent2Index and EFFECT.Ents[Ent2Index] then Ent2 = EFFECT.Ents[Ent2Index][1] end
							if EFFECT.Register[Type][EffectCount][3] and EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] then EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] = false end
							RemoveEntFromEffect(Ent1,Ent1Index,Type,EffectCount)
							RemoveEntFromEffect(Ent2,Ent2Index,Type,EffectCount)
							EFFECT.Register[Type][EffectCount] = false
						end
					end
				elseif Type == 12 or Type == 13 or Type == 14 then
					for EffectCount=1,#EFFECT.Register[Type] do
						if EFFECT.Register[Type][EffectCount] then
							local Ent1Index = EFFECT.Register[Type][EffectCount][1]
							local Ent1
							if Ent1Index and EFFECT.Ents[Ent1Index] then Ent1 = EFFECT.Ents[Ent1Index][1] end
							if EFFECT.Register[Type][EffectCount][3] and EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] then EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] = false end
							RemoveEntFromEffect(Ent1,Ent1Index,Type,EffectCount)
							EFFECT.Register[Type][EffectCount] = false
						end
					end
				end
			end
			CleanupTables()
		else
			if EFFECT.Remove == nil then util.Effect("render_no_collide", EffectData()) end
			EFFECT.Remove = false
			local Table = string.Explode("_",String)
			if #Table == 2 then
				local Index = tonumber(Table[1])
				if Table[2][1] == "-" then
					local Type = tonumber(string.sub(Table[2],2,string.len(Table[2])))
					if EFFECT.Ents[Index] and EFFECT.Ents[Index][4] and EFFECT.Ents[Index][4][Type] then
						local EffectCount = EFFECT.Ents[Index][4][Type]
						local Ent1
						if Index and EFFECT.Ents[Index] then Ent1 = EFFECT.Ents[Index][1] end
						if EFFECT.Register[Type][EffectCount][3] and EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] then EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] = false end
						RemoveEntFromEffect(Ent1,Index,Type,EffectCount)
						EFFECT.Register[Type][EffectCount] = false
						CleanupTables()
					end
				else
					local Type = tonumber(Table[2])
					if !(EFFECT.Ents[Index] and EFFECT.Ents[Index][4] and EFFECT.Ents[Index][4][Type]) then
						local Ent = ents.GetByIndex(Index)
						if IsValid(Ent) then RegisterEffect(Type,Index,Ent) end
					end
				end
			else
				local Ent1Index = math.min(tonumber(Table[1]),tonumber(Table[2]))
				local Ent2Index = math.max(tonumber(Table[1]),tonumber(Table[2]))
				if Table[3][1] == "-" then
					local Type = tonumber(string.sub(Table[3],2,string.len(Table[3])))
					if EFFECT.Ents[Ent1Index] and EFFECT.Ents[Ent2Index] and EFFECT.Ents[Ent1Index][4] and EFFECT.Ents[Ent2Index][4] and EFFECT.Ents[Ent1Index][4][Type] and EFFECT.Ents[Ent2Index][4][Type] then
						local EffectCount
						for k,v in pairs(EFFECT.Ents[Ent1Index][4][Type]) do
							if EFFECT.Register[Type] and EFFECT.Register[Type][v] and EFFECT.Register[Type][v][1] == Ent1Index and EFFECT.Register[Type][v][2] == Ent2Index then
								EffectCount = v
								break
							end
						end
						if !EffectCount then
							for k,v in pairs(EFFECT.Ents[Ent2Index][4][Type]) do
								if EFFECT.Register[Type] and EFFECT.Register[Type][v] and EFFECT.Register[Type][v][1] == Ent1Index and EFFECT.Register[Type][v][2] == Ent2Index then
									EffectCount = v
									break
								end
							end
						end
						if EffectCount then
							local Ent1
							local Ent2
							if Ent1Index and EFFECT.Ents[Ent1Index] then Ent1 = EFFECT.Ents[Ent1Index][1] end
							if Ent2Index and EFFECT.Ents[Ent2Index] then Ent2 = EFFECT.Ents[Ent2Index][1] end
							if EFFECT.Register[Type][EffectCount][3] and EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] then EFFECT.Draw[EFFECT.Register[Type][EffectCount][3]] = false end
							RemoveEntFromEffect(Ent1,Ent1Index,Type,EffectCount)
							RemoveEntFromEffect(Ent2,Ent2Index,Type,EffectCount)
							EFFECT.Register[Type][EffectCount] = false
							CleanupTables()
						end
					end
				else
					local Type = tonumber(Table[3])
					local NotRegister
					if EFFECT.Ents[Ent1Index] and EFFECT.Ents[Ent2Index] and EFFECT.Ents[Ent1Index][4] and EFFECT.Ents[Ent2Index][4] and EFFECT.Ents[Ent1Index][4][Type] and EFFECT.Ents[Ent2Index][4][Type] then
						for k,v in pairs(EFFECT.Ents[Ent1Index][4][Type]) do
							if EFFECT.Register[Type] and EFFECT.Register[Type][v] and EFFECT.Register[Type][v][1] == Ent1Index and EFFECT.Register[Type][v][2] == Ent2Index then
								NotRegister = true
								break
							end
						end
						if !NotRegister then
							for k,v in pairs(EFFECT.Ents[Ent2Index][4][Type]) do
								if EFFECT.Register[Type] and EFFECT.Register[Type][v] and EFFECT.Register[Type][v][1] == Ent1Index and EFFECT.Register[Type][v][2] == Ent2Index then
									NotRegister = true
									break
								end
							end
						end
					end
					if !NotRegister then
						local Ent1 = ents.GetByIndex(Ent1Index)
						local Ent2 = ents.GetByIndex(Ent2Index)
						if IsValid(Ent1) and IsValid(Ent2) then RegisterEffect(Type,Ent2Index,Ent2,RegisterEffect(Type,Ent1Index,Ent1)) end
					end
				end
			end
		end
	end)
	
	function EFFECT:Init(data) end

	function EFFECT:Think()
		-- This makes the effect always visible.
		local pl = LocalPlayer()
		if IsValid(pl) then
			local Pos = pl:EyePos()
			local Trace = {}
			Trace.start = Pos
			Trace.endpos = Pos+(pl:GetAimVector()*10)
			Trace.filter = {pl}
			local TR = util.TraceLine(Trace)
			self:SetPos(TR.HitPos)
		end
		
		-- Update positions.
		for Type,v in pairs(EFFECT.Register) do
			if EFFECT.Register[Type] then
				if Type == 1 or Type == 2 or Type == 3 or Type == 4 or Type == 15 or Type == 16 or Type == 17 then
					for EffectCount=1,#v do
						if EFFECT.Register[Type] and EFFECT.Register[Type][EffectCount] then
							local Ent1,Ent2
							if v[EffectCount][1] and EFFECT.Ents[v[EffectCount][1]] then Ent1 = EFFECT.Ents[v[EffectCount][1]][1] end
							if v[EffectCount][2] and EFFECT.Ents[v[EffectCount][2]] then Ent2 = EFFECT.Ents[v[EffectCount][2]][1] end
							if IsValid(Ent1) and IsValid(Ent2) then
								if !v[EffectCount][3] then EFFECT.Register[Type][EffectCount][3] = #EFFECT.Draw+1 end
								local DrawID = v[EffectCount][3]
								if !EFFECT.Draw[DrawID] then EFFECT.Draw[DrawID] = {} end
								EFFECT.Draw[DrawID][1] = Ent1:LocalToWorld(Ent1:OBBCenter())
								EFFECT.Draw[DrawID][2] = Ent2:LocalToWorld(Ent2:OBBCenter())
								if !EFFECT.Draw[DrawID][3] then
									if Type == 15 then Type = 1 end
									if Type == 16 then Type = 3 end
									if Type == 17 then Type = 4 end
									EFFECT.Draw[DrawID][3] = Type
								end
							else
								if v[EffectCount][3] and EFFECT.Draw[v[EffectCount][3]] then EFFECT.Draw[v[EffectCount][3]] = false end
								local Ent1Index,Ent2Index = v[EffectCount][1],v[EffectCount][2]
								RemoveEntFromEffect(Ent1,Ent1Index,Type,EffectCount)
								RemoveEntFromEffect(Ent2,Ent2Index,Type,EffectCount)
								EFFECT.Register[Type][EffectCount] = false
								CleanupTables()
							end
						end
					end
				elseif Type == 5 or Type == 6 or Type == 7 or Type == 8 or Type == 12 or Type == 13 or Type == 14 then
					for EffectCount=1,#v do
						if EFFECT.Register[Type] and EFFECT.Register[Type][EffectCount] then
							local Ent1
							if v[EffectCount][1] and EFFECT.Ents[v[EffectCount][1]] then Ent1 = EFFECT.Ents[v[EffectCount][1]][1] end
							if IsValid(Ent1) then
								if !v[EffectCount][3] then EFFECT.Register[Type][EffectCount][3] = #EFFECT.Draw+1 end
								local DrawID = v[EffectCount][3]
								if !EFFECT.Draw[DrawID] then EFFECT.Draw[DrawID] = {} end
								EFFECT.Draw[DrawID][1] = Ent1:LocalToWorld(Ent1:OBBCenter())
								if !EFFECT.Draw[DrawID][3] then
									if Type == 12 then Type = 5 end
									if Type == 13 then Type = 7 end
									if Type == 14 then Type = 8 end
									EFFECT.Draw[DrawID][3] = Type
								end
							else
								if v[EffectCount][3] and EFFECT.Draw[v[EffectCount][3]] then EFFECT.Draw[v[EffectCount][3]] = false end
								if v[EffectCount][1] then EFFECT.Ents[v[EffectCount][1]] = false end
								EFFECT.Register[Type][EffectCount] = false
								CleanupTables()
							end
						end
					end
				else
					for EffectCount=1,#v do
						if EFFECT.Register[Type] and EFFECT.Register[Type][EffectCount] then
							local Ent1
							if v[EffectCount][1] and EFFECT.Ents[v[EffectCount][1]] then Ent1 = EFFECT.Ents[v[EffectCount][1]][1] end
							if IsValid(Ent1) then
								if !v[EffectCount][3] then EFFECT.Register[Type][EffectCount][3] = #EFFECT.Draw+1 end
								local DrawID = v[EffectCount][3]
								if !EFFECT.Draw[DrawID] then EFFECT.Draw[DrawID] = {} end
								EFFECT.Draw[DrawID][3] = Type
								EFFECT.Draw[DrawID][4] = Ent1
							else
								if v[EffectCount][3] and EFFECT.Draw[v[EffectCount][3]] then EFFECT.Draw[v[EffectCount][3]] = false end
								if v[EffectCount][1] then EFFECT.Ents[v[EffectCount][1]] = false end
								EFFECT.Register[Type][EffectCount] = false
								CleanupTables()
							end
						end
					end
				end
			end
		end
		
		-- Set alpha to 100.
		for k,v in pairs(EFFECT.Ents) do
			if v then
				local Ent = v[1]
				if IsValid(Ent) then
					local Col = Ent:GetColor()
					Col["a"] = 100
					Ent:SetRenderMode(1)
					Ent:SetColor(Col)
				end
			end
		end
		
		return true
	end

	local DrawLine = Material("effects/render_vector")
	
	function EFFECT:Render()
		render.SetMaterial(DrawLine)
		for i=1,#EFFECT.Draw do
			if EFFECT.Draw[i] then
				if EFFECT.Draw[i][3] == 1 then
					render.DrawBeam(EFFECT.Draw[i][1], EFFECT.Draw[i][2], 16, 0.2, 0.8, Color(255, 255, 255, 255))
				elseif EFFECT.Draw[i][3] == 2 then
					render.DrawBeam(EFFECT.Draw[i][1], EFFECT.Draw[i][2], 16, 0.2, 0.8, Color(100, 255, 100, 255))
				elseif EFFECT.Draw[i][3] == 3 then
					render.DrawBeam(EFFECT.Draw[i][1], EFFECT.Draw[i][2], 16, 0.2, 0.8, Color(255, 50, 50, 255))
				elseif EFFECT.Draw[i][3] == 4 then
					render.DrawBeam(EFFECT.Draw[i][1], EFFECT.Draw[i][2], 16, 0.2, 0.8, Color(50, 50, 255, 255))
				elseif EFFECT.Draw[i][3] == 5 then
					render.DrawBeam(EFFECT.Draw[i][1], EFFECT.Draw[i][1]+Vector(0,0,-100), 32, 0.2, 0.8, Color(255, 255, 255, 255))
				elseif EFFECT.Draw[i][3] == 6 then
					render.DrawBeam(EFFECT.Draw[i][1], EFFECT.Draw[i][1]+Vector(0,0,-100), 32, 0.2, 0.8, Color(255, 150, 50, 255))
				elseif EFFECT.Draw[i][3] == 7 then
					render.DrawBeam(EFFECT.Draw[i][1], EFFECT.Draw[i][1]+Vector(0,0,-100), 32, 0.2, 0.8, Color(255, 50, 50, 255))
				elseif EFFECT.Draw[i][3] == 8 then
					render.DrawBeam(EFFECT.Draw[i][1], EFFECT.Draw[i][1]+Vector(0,0,-100), 32, 0.2, 0.8, Color(50, 50, 255, 255))
				elseif EFFECT.Draw[i][3] == 9 then
					halo.Add({EFFECT.Draw[i][4]}, Color(255, 255, 255, 255), 10, 10, 1, true, false)
				elseif EFFECT.Draw[i][3] == 10 then
					halo.Add({EFFECT.Draw[i][4]}, Color(255, 150, 50, 255), 10, 10, 1, true, false)
				elseif EFFECT.Draw[i][3] == 11 then
					halo.Add({EFFECT.Draw[i][4]}, Color(100, 255, 100, 255), 10, 10, 1, true, false)
				end
			end
		end
	end

	effects.Register(EFFECT,"render_no_collide",true)
end

local function ExtractEntities(Entity, Entities, Constraints, Ignore)
	Constraints = Constraints or {}
	Entities = Entities or {}
	if !Entity:IsValid() and Entity != game.GetWorld() then return Entities, Constraints end
	local Index = Entity:EntIndex()
	Entities[Index] = Entity
	if !constraint.HasConstraints(Entity) then return Entities, Constraints end
	
	for k1, v1 in pairs(constraint.GetTable(Entity)) do
		if !(Ignore and v1["Type"] and (v1["Type"] == "NoCollideWorld" or v1["Type"] == "NoCollide")) then
			local Index = v1.Constraint
			if !Constraints[Index] then
				Constraints[Index] = v1.Constraint
				for k2, v2 in pairs(v1.Entity) do
					local Ents, Cons = ExtractEntities(v2.Entity, Entities, Constraints, Ignore)
					table.Merge(Entities, Ents)
					table.Merge(Constraints, Cons)
				end
			end
		end
	end
	
	return Entities, Constraints
end

local SendToClient2 = {}
local SendDone2 = {}

function TOOL:LeftClick(trace)
	local pl = self:GetOwner()
	if !IsValid(pl) then return end
	if !trace.Entity then return end
	if trace.Entity:IsPlayer() then return end
	
	if SERVER then
		if self.Hold then self.Hold[pl] = false end
		if self.AimEnt then self.AimEnt[pl] = nil end
	end
	
	local Option = self:GetClientNumber("options")
	
	if Option == 1 then	--	Like default no collide
		if SERVER and !trace.Entity:IsValid() and trace.Entity != game.GetWorld() then return end
		local iNum = self:NumObjects()
		local Phys = trace.Entity:GetPhysicsObjectNum(trace.PhysicsBone)
		self:SetObject(iNum+1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal)
		if CLIENT then
			if iNum > 0 then self:ClearObjects() end
			return true
		end
		if iNum > 0 then
			local Ent1,  Ent2  = self:GetEnt(1), self:GetEnt(2)
			local Bone1, Bone2 = self:GetBone(1), self:GetBone(2)
			
			if Ent1 == game.GetWorld() then
				Ent1 = Ent2
				Ent2 = game.GetWorld()
			end
			if Ent1:GetTable().Constraints then
				for k, v in pairs(Ent1:GetTable().Constraints) do
					if v:IsValid() then
						local CTab = v:GetTable()
						if CTab.Type == "NoCollideWorld" and ((CTab.Ent1 == Ent1 and CTab.Ent2 == Ent2) or (CTab.Ent2 == Ent1 and CTab.Ent1 == Ent2)) then
							self:ClearObjects()
							v:Remove()
							return true
						end
					end	
				end
			end
			
			local Const = constraint.NoCollideWorld(Ent1, Ent2, Bone1, Bone2)
			
			if IsValid(Const) then
				undo.Create("No Collide World, Default")
				undo.AddEntity(Const)
				undo.AddFunction(function(Undo, Tool, pl)
					if Tool and pl and pl:IsValid() then
						if Tool.Hold then Tool.Hold[pl] = false end
						if Tool.AimEnt then Tool.AimEnt[pl] = nil end
					end
				end, self,pl)
				undo.SetPlayer(pl)
				undo.SetCustomUndoText("Undone No Collide World, Default")
				undo.Finish()
				self:ClearObjects()
				return true
			end
			self:ClearObjects()
		else
			self:SetStage(iNum+1)
			return true
		end
	elseif Option == 2 then	--	No collide world only
		if !trace.Entity:IsValid() then return end
		if CLIENT then return true end
		
		if trace.Entity:GetTable().Constraints then
			for k, v in pairs(trace.Entity:GetTable().Constraints) do
				if v:IsValid() then
					local CTab = v:GetTable()
					if CTab.Type == "NoCollideWorld" and CTab.Ent1 == trace.Entity and CTab.Ent2 == game.GetWorld() then
						v:Remove()
						return true
					end
				end	
			end
		end
		
		local Const = constraint.NoCollideWorld(trace.Entity, game.GetWorld(), trace.PhysicsBone, 0)
		if IsValid(Const) then
			undo.Create("No Collide World, World Only")
			undo.AddEntity(Const)
			undo.AddFunction(function(Undo, Tool, pl)
				if Tool and pl and pl:IsValid() then
					if Tool.Hold then Tool.Hold[pl] = false end
					if Tool.AimEnt then Tool.AimEnt[pl] = nil end
				end
			end, self,pl)
			undo.SetPlayer(pl)
			undo.SetCustomUndoText("Undone No Collide World, World Only")
			undo.Finish()
			return true
		end
	elseif Option == 3 then	--	Select all constrained
		if SERVER and !trace.Entity:IsValid() and trace.Entity != game.GetWorld() then return end
		if CLIENT then return true end
		local iNum = self:GetStage()
		local Entities = ExtractEntities(trace.Entity,nil,nil,tobool(self:GetClientNumber("ignore")))
		if self.Ents1 and Entities and iNum == 4 then
			local UndoTable = {}
			for k1, Ent1 in pairs(self.Ents1) do
				if Ent1:IsValid() or Ent1 == game.GetWorld() then
					for k2, Ent2 in pairs(Entities) do
						if (Ent2:IsValid() or Ent2 == game.GetWorld()) and Ent1 != Ent2 then
							local Const = constraint.NoCollideWorld(Ent1, Ent2, 0, 0)
							if IsValid(Const) then UndoTable[#UndoTable+1] = Const end
						end
					end
				end
			end
			if #UndoTable == 0 then
				self.Ents1 = nil
				self:SetStage(3)
				return
			end
			undo.Create("No Collide World, Select all constrained")
			for i=1,#UndoTable do undo.AddEntity(UndoTable[i]) end
			undo.AddFunction(function(Undo, Tool, pl)
				if Tool and pl and pl:IsValid() then
					if Tool.Hold then Tool.Hold[pl] = false end
					if Tool.AimEnt then Tool.AimEnt[pl] = nil end
				end
			end, self,pl)
			undo.SetPlayer(pl)
			undo.SetCustomUndoText("Undone No Collide World, Select all constrained")
			undo.Finish()
			self.Ents1 = nil
			self:SetStage(3)
			return true 
		else
			self.Ents1 = Entities
			self:SetStage(4)
			return true 
		end
	elseif Option == 4 then	--	To all constrained
		if !trace.Entity:IsValid() then return end
		if CLIENT then return true end
		local Entities = ExtractEntities(trace.Entity,nil,nil,tobool(self:GetClientNumber("ignore")))
		if Entities then
			local UndoTable = {}
			for k1, Ent1 in pairs(Entities) do
				for k2, Ent2 in pairs(Entities) do
					if Ent1:IsValid() and Ent2:IsValid() and Ent1 != Ent2 then
						local Const = constraint.NoCollideWorld(Ent1, Ent2, 0, 0)
						if IsValid(Const) then UndoTable[#UndoTable+1] = Const end
					end
				end
			end
			if #UndoTable == 0 then return end
			undo.Create("No Collide World, To All Constrained")
			for i=1,#UndoTable do undo.AddEntity(UndoTable[i]) end
			undo.AddFunction(function(Undo, Tool, pl)
				if Tool and pl and pl:IsValid() then
					if Tool.Hold then Tool.Hold[pl] = false end
					if Tool.AimEnt then Tool.AimEnt[pl] = nil end
				end
			end, self,pl)
			undo.SetPlayer(pl)
			undo.SetCustomUndoText("Undone No Collide World, To All Constrained")
			undo.Finish()
			return true 
		end
	elseif Option == 5 then	--	No collide player only
		if !trace.Entity:IsValid() then return end
		if CLIENT then return true end
		
		if trace.Entity:GetCollisionGroup() == COLLISION_GROUP_WEAPON then
			trace.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
			if IsValid(trace.Entity.NocollideDummy) then trace.Entity.NocollideDummy:Remove() end
			return true
		else
			trace.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			
			undo.Create("Undone No Collide World, Player Only")
			local Dummy = ents.Create("info_null")
			if !trace.Entity.UndoNoCollidePlayer then trace.Entity:CallOnRemove("UndoNoCollidePlayer"..trace.Entity:EntIndex(),function(Ent) if Ent.NocollideDummy and Ent.NocollideDummy:IsValid() then Ent.NocollideDummy:Remove() end end,trace.Entity) end
			trace.Entity.UndoNoCollidePlayer = true
			trace.Entity.NocollideDummy = Dummy
			undo.AddEntity(Dummy)
			
			undo.AddFunction(function(Undo, Ent, Tool, pl)
				if Tool and pl and pl:IsValid() then
					if Tool.Hold then Tool.Hold[pl] = false end
					if Tool.AimEnt then Tool.AimEnt[pl] = nil end
				end
				if Ent and Ent:IsValid() then Ent:SetCollisionGroup(COLLISION_GROUP_NONE) end
			end, trace.Entity,self,pl)
			undo.SetPlayer(pl)
			undo.SetCustomUndoText("Undone No Collide World, Player Only")
			undo.Finish()
			return true
		end
	elseif Option == 6 then	--	No collide within box
		if !trace.Entity:IsValid() then return end
		if CLIENT then return true end
		local Distance = self:GetClientNumber("distance")
		local AddVector = Vector(Distance,Distance,Distance)
		local UndoTable = {}
		for k,v in pairs(ents.FindInBox(trace.Entity:LocalToWorld(trace.Entity:OBBMins()-AddVector), trace.Entity:LocalToWorld(trace.Entity:OBBMaxs()+AddVector))) do
			if v:IsValid() and v != trace.Entity and !v:IsPlayer() then
				local Const = constraint.NoCollideWorld(trace.Entity, v, 0, 0)
				if IsValid(Const) then UndoTable[#UndoTable+1] = Const end
			end
		end
		if #UndoTable == 0 then return end
		undo.Create("No Collide World, Within Box")
		for i=1,#UndoTable do undo.AddEntity(UndoTable[i]) end
		undo.AddFunction(function(Undo, Tool, pl)
			if Tool and pl and pl:IsValid() then
				if Tool.Hold then Tool.Hold[pl] = false end
				if Tool.AimEnt then Tool.AimEnt[pl] = nil end
			end
		end, self,pl)
		undo.SetPlayer(pl)
		undo.SetCustomUndoText("Undone No Collide World, Within Box")
		undo.Finish()
		return true
	elseif Option == 7 then	--	No collide within sphere
		if !trace.Entity:IsValid() then return end
		if CLIENT then return true end
		local Distance = self:GetClientNumber("distance")
		local UndoTable = {}
		for k,v in pairs(ents.FindInSphere(trace.Entity:LocalToWorld(trace.Entity:OBBCenter()), (trace.Entity:OBBMaxs()/2):Length()+Distance)) do
			if v:IsValid() and v != trace.Entity and !v:IsPlayer() then
				local Const = constraint.NoCollideWorld(trace.Entity, v, 0, 0)
				if IsValid(Const) then UndoTable[#UndoTable+1] = Const end
			end
		end
		if #UndoTable == 0 then return end
		undo.Create("No Collide World, Within Sphere")
		for i=1,#UndoTable do undo.AddEntity(UndoTable[i]) end
		undo.AddFunction(function(Undo, Tool, pl)
			if Tool and pl and pl:IsValid() then
				if Tool.Hold then Tool.Hold[pl] = false end
				if Tool.AimEnt then Tool.AimEnt[pl] = nil end
			end
		end, self,pl)
		undo.SetPlayer(pl)
		undo.SetCustomUndoText("Undone No Collide World, Within Sphere")
		undo.Finish()
		return true
	elseif Option == 8 then	--	No collide within box all constrained
		if !trace.Entity:IsValid() then return end
		if CLIENT then return true end
		local Distance = self:GetClientNumber("distance")
		local AddVector = Vector(Distance,Distance,Distance)
		local Entities = ExtractEntities(trace.Entity,nil,nil,tobool(self:GetClientNumber("ignore")))
		if Entities then
			local UndoTable = {}
			for k1, Ent1 in pairs(Entities) do
				if Ent1:IsValid() and !Ent1:IsPlayer() then
					for k,v in pairs(ents.FindInBox(Ent1:LocalToWorld(Ent1:OBBMins()-AddVector), Ent1:LocalToWorld(Ent1:OBBMaxs()+AddVector))) do
						if v:IsValid() and v != Ent1 and !v:IsPlayer() then
							local Const = constraint.NoCollideWorld(Ent1, v, 0, 0)
							if IsValid(Const) then UndoTable[#UndoTable+1] = Const end
						end
					end
				end
			end
			if #UndoTable == 0 then return end
			undo.Create("No Collide World, Within Box All Constrained")
			for i=1,#UndoTable do undo.AddEntity(UndoTable[i]) end
			undo.AddFunction(function(Undo, Tool, pl)
				if Tool and pl and pl:IsValid() then
					if Tool.Hold then Tool.Hold[pl] = false end
					if Tool.AimEnt then Tool.AimEnt[pl] = nil end
				end
			end, self,pl)
			undo.SetPlayer(pl)
			undo.SetCustomUndoText("Undone No Collide World, Within Box All Constrained")
			undo.Finish()
			return true
		end
	elseif Option == 9 then	--	No collide within sphere all constrained
		if !trace.Entity:IsValid() then return end
		if CLIENT then return true end
		local Distance = self:GetClientNumber("distance")
		local Entities = ExtractEntities(trace.Entity,nil,nil,tobool(self:GetClientNumber("ignore")))
		if Entities then
			local UndoTable = {}
			for k1, Ent1 in pairs(Entities) do
				if Ent1:IsValid() and !Ent1:IsPlayer() then
					for k,v in pairs(ents.FindInSphere(Ent1:LocalToWorld(Ent1:OBBCenter()), (Ent1:OBBMaxs()/2):Length()+Distance)) do
						if v:IsValid() and v != Ent1 and !v:IsPlayer() then
							local Const = constraint.NoCollideWorld(Ent1, v, 0, 0)
							if IsValid(Const) then UndoTable[#UndoTable+1] = Const end
						end
					end
				end
			end
			if #UndoTable == 0 then return end
			undo.Create("No Collide World, Within Sphere All Constrained")
			for i=1,#UndoTable do undo.AddEntity(UndoTable[i]) end
			undo.SetPlayer(pl)
			undo.SetCustomUndoText("Undone No Collide World, Within Sphere All Constrained")
			undo.Finish()
			return true
		end
	elseif Option == 10 then	--	To all selected entities
		if CLIENT then return true end
		if SERVER and !trace.Entity:IsValid() and trace.Entity != game.GetWorld() then return end
		local EntityIndex = trace.Entity:EntIndex()
		if !SendDone2[pl] then SendDone2[pl] = 0 end
		if !SendToClient2[pl] then SendToClient2[pl] = {} end
		
		if !self.TASE then
			self.TASE = {}
			self.TASE[1] = {}
			self.TASE[2] = {}
			self.TASE[3] = {}
			--[[
			self.TASE[1][Index][Count] = Do count
			
			self.TASE[2][Low index][High index] = 1 = create, 2 = remove, 3 = ignore
			
			self.TASE[3][Do count][1] = Low index
			self.TASE[3][Do count][2] = High index
			]]
		end
		
		local function NocollideFind(Ent1, Ent2)
			if Ent1 == game.GetWorld() then
				Ent1 = Ent2
				Ent2 = game.GetWorld()
			end
			if !IsValid(Ent1) then return end
			if !Ent1:GetTable().Constraints then return end
			for k, v in pairs(Ent1:GetTable().Constraints) do
				if v:IsValid() then
					local CTab = v:GetTable()
					if (CTab.Type == "NoCollideWorld" or CTab.Type == "NoCollide") and ((CTab.Ent1 == Ent1 and CTab.Ent2 == Ent2) or (CTab.Ent2 == Ent1 and CTab.Ent1 == Ent2)) then return v,CTab.Type end
				end	
			end
			return
		end
		
		local function RemoveObject(Index)
			for i1=1,#self.TASE[1][Index] do
				local DoC = self.TASE[1][Index][i1]
				if DoC and self.TASE[3][DoC] then
					local LIndex = self.TASE[3][DoC][1]
					local HIndex = self.TASE[3][DoC][2]
					if self.TASE[2][LIndex] and self.TASE[2][LIndex][HIndex] then
						local SendC = #SendToClient2[pl]+1
						SendToClient2[pl][SendC] = {}
						if LIndex == 0 then
							if self.TASE[2][LIndex][HIndex] == 1 then
								SendToClient2[pl][SendC][1] = HIndex
								SendToClient2[pl][SendC][3] = -12
							elseif self.TASE[2][LIndex][HIndex] == 2 then
								SendToClient2[pl][SendC][1] = HIndex
								SendToClient2[pl][SendC][3] = -13
							else
								SendToClient2[pl][SendC][1] = HIndex
								SendToClient2[pl][SendC][3] = -14
							end
						elseif HIndex == 0 then
							if self.TASE[2][LIndex][HIndex] == 1 then
								SendToClient2[pl][SendC][1] = LIndex
								SendToClient2[pl][SendC][3] = -12
							elseif self.TASE[2][LIndex][HIndex] == 2 then
								SendToClient2[pl][SendC][1] = LIndex
								SendToClient2[pl][SendC][3] = -13
							else
								SendToClient2[pl][SendC][1] = LIndex
								SendToClient2[pl][SendC][3] = -14
							end
						else
							if self.TASE[2][LIndex][HIndex] == 1 then
								SendToClient2[pl][SendC][1] = LIndex
								SendToClient2[pl][SendC][2] = HIndex
								SendToClient2[pl][SendC][3] = -15
							elseif self.TASE[2][LIndex][HIndex] == 2 then
								SendToClient2[pl][SendC][1] = LIndex
								SendToClient2[pl][SendC][2] = HIndex
								SendToClient2[pl][SendC][3] = -16
							else
								SendToClient2[pl][SendC][1] = LIndex
								SendToClient2[pl][SendC][2] = HIndex
								SendToClient2[pl][SendC][3] = -17
							end
						end
						self.TASE[2][LIndex][HIndex] = nil
					end
					self.TASE[3][DoC] = false
					for i2=1,#self.TASE[1][HIndex] do if !self.TASE[3][self.TASE[1][HIndex][i2]] then self.TASE[1][HIndex][i2] = false end end
					for i2=1,#self.TASE[1][LIndex] do if !self.TASE[3][self.TASE[1][LIndex][i2]] then self.TASE[1][LIndex][i2] = false end end
				end
			end
			self.TASE[1][Index] = false
			local Translate = {}
			local New = {}
			local Count = 0
			for i1=1,#self.TASE[3] do
				if self.TASE[3][i1] then
					Count = Count+1
					Translate[i1] = Count
					local LIndex = self.TASE[3][i1][1]
					local HIndex = self.TASE[3][i1][2]
					New[Count] = self.TASE[3][i1]
				end
			end
			self.TASE[3] = New
			for k,v in pairs(self.TASE[1]) do
				if v then
					self.TASE[1][k] = {}
					local Count = 0
					for i=1,#v do
						if v[i] and self.TASE[3][Translate[v[i]]] then
							Count = Count+1
							self.TASE[1][k][Count] = Translate[v[i]]
						end
					end
				end
			end
		end
		
		if self.TASE[1][EntityIndex] then
			RemoveObject(EntityIndex)
			return true
		else
			self.TASE[1][EntityIndex] = {}
		end
		
		if tobool(self:GetClientNumber("remove")) then
			for k,v in pairs(self.TASE[1]) do
				if k != EntityIndex and self.TASE[1][EntityIndex] and self.TASE[1][k] then
					local Ent2
					if k == 0 then Ent2 = game.GetWorld() else Ent2 = ents.GetByIndex(k) end
					local Nocollide, Type = NocollideFind(trace.Entity, Ent2)
					if Type == "NoCollideWorld" then
						local SendC = #SendToClient2[pl]+1
						SendToClient2[pl][SendC] = {}
						if EntityIndex == 0 then
							SendToClient2[pl][SendC][1] = k
							SendToClient2[pl][SendC][3] = 13
						elseif k == 0 then
							SendToClient2[pl][SendC][1] = EntityIndex
							SendToClient2[pl][SendC][3] = 13
						else
							SendToClient2[pl][SendC][1] = k
							SendToClient2[pl][SendC][2] = EntityIndex
							SendToClient2[pl][SendC][3] = 16
						end
						local LIndex = math.min(k,EntityIndex)
						local HIndex = math.max(k,EntityIndex)
						local DoC = #self.TASE[3]+1
						self.TASE[1][LIndex][#self.TASE[1][LIndex]+1] = DoC
						self.TASE[1][HIndex][#self.TASE[1][HIndex]+1] = DoC
						
						if !self.TASE[2][LIndex] then self.TASE[2][LIndex] = {} end
						self.TASE[2][LIndex][HIndex] = 2
						
						self.TASE[3][DoC] = {}
						self.TASE[3][DoC][1] = LIndex
						self.TASE[3][DoC][2] = HIndex
					elseif !Nocollide then
						local SendC = #SendToClient2[pl]+1
						SendToClient2[pl][SendC] = {}
						if EntityIndex == 0 then
							SendToClient2[pl][SendC][1] = k
							SendToClient2[pl][SendC][3] = 14
						elseif k == 0 then
							SendToClient2[pl][SendC][1] = EntityIndex
							SendToClient2[pl][SendC][3] = 14
						else
							SendToClient2[pl][SendC][1] = k
							SendToClient2[pl][SendC][2] = EntityIndex
							SendToClient2[pl][SendC][3] = 17
						end
						local LIndex = math.min(k,EntityIndex)
						local HIndex = math.max(k,EntityIndex)
						local DoC = #self.TASE[3]+1
						self.TASE[1][LIndex][#self.TASE[1][LIndex]+1] = DoC
						self.TASE[1][HIndex][#self.TASE[1][HIndex]+1] = DoC
						
						if !self.TASE[2][LIndex] then self.TASE[2][LIndex] = {} end
						self.TASE[2][LIndex][HIndex] = 3
						
						self.TASE[3][DoC] = {}
						self.TASE[3][DoC][1] = LIndex
						self.TASE[3][DoC][2] = HIndex
					end
				end
			end
		else
			for k,v in pairs(self.TASE[1]) do
				if k != EntityIndex and self.TASE[1][EntityIndex] and self.TASE[1][k] then
					local Ent2
					if k == 0 then Ent2 = game.GetWorld() else Ent2 = ents.GetByIndex(k) end
					if !NocollideFind(trace.Entity, Ent2) then
						local SendC = #SendToClient2[pl]+1
						SendToClient2[pl][SendC] = {}
						if EntityIndex == 0 then
							SendToClient2[pl][SendC][1] = k
							SendToClient2[pl][SendC][3] = 12
						elseif k == 0 then
							SendToClient2[pl][SendC][1] = EntityIndex
							SendToClient2[pl][SendC][3] = 12
						else
							SendToClient2[pl][SendC][1] = k
							SendToClient2[pl][SendC][2] = EntityIndex
							SendToClient2[pl][SendC][3] = 15
						end
						local LIndex = math.min(k,EntityIndex)
						local HIndex = math.max(k,EntityIndex)
						local DoC = #self.TASE[3]+1
						self.TASE[1][LIndex][#self.TASE[1][LIndex]+1] = DoC
						self.TASE[1][HIndex][#self.TASE[1][HIndex]+1] = DoC
						
						if !self.TASE[2][LIndex] then self.TASE[2][LIndex] = {} end
						self.TASE[2][LIndex][HIndex] = 1
						
						self.TASE[3][DoC] = {}
						self.TASE[3][DoC][1] = LIndex
						self.TASE[3][DoC][2] = HIndex
					end
				end
			end
		end
		return true
	end
end

function TOOL:RightClick(trace)
	if self:GetClientNumber("options") == 10 then
		if CLIENT then return true end
		if !self.TASE or !self.TASE[3] then return end
		local pl = self:GetOwner()
		if !IsValid(pl) then return end
		if self.Hold then self.Hold[pl] = false end
		if self.AimEnt then self.AimEnt[pl] = nil end
		SendDone2[pl] = 0
		SendToClient2[pl] = {}
		net.Start("DrawNoCollide")
		net.WriteString("0b")
		net.Send(pl)
		
		local UndoTable = {}
		local Ents = {}
		local DidRemove
		
		for i=1,#self.TASE[3] do
			if self.TASE[3][i] then
				local LIndex = self.TASE[3][i][1]
				local HIndex = self.TASE[3][i][2]
				if Ents[LIndex] == nil then
					if LIndex == 0 then
						Ents[LIndex] = game.GetWorld()
					else
						local Ent = ents.GetByIndex(LIndex)
						if IsValid(Ent) or Ent == game.GetWorld() then Ents[LIndex] = Ent else Ents[LIndex] = false end
					end
				end
				if Ents[HIndex] == nil then
					if HIndex == 0 then
						Ents[HIndex] = game.GetWorld()
					else
						local Ent = ents.GetByIndex(HIndex)
						if IsValid(Ent) or Ent == game.GetWorld() then Ents[HIndex] = Ent else Ents[HIndex] = false end
					end
				end
				if Ents[LIndex] and Ents[HIndex] then
					if self.TASE[2][LIndex][HIndex] == 1 then
						local Const = constraint.NoCollideWorld(Ents[LIndex], Ents[HIndex], 0, 0)
						if IsValid(Const) then UndoTable[#UndoTable+1] = Const end
					elseif self.TASE[2][LIndex][HIndex] == 2 then
						local Ent1 = Ents[LIndex]
						local Ent2 = Ents[HIndex]
						if Ent1 == game.GetWorld() then
							Ent1 = Ent2
							Ent2 = game.GetWorld()
						end
						if Ent1:GetTable().Constraints then
							for k, v in pairs(Ent1:GetTable().Constraints) do
								if v:IsValid() then
									local CTab = v:GetTable()
									if CTab.Type == "NoCollideWorld" and ((CTab.Ent1 == Ent1 and CTab.Ent2 == Ent2) or (CTab.Ent2 == Ent1 and CTab.Ent1 == Ent2)) then
										DidRemove = true
										v:Remove()
										break
									end
								end	
							end
						end
					end
				end
			end
		end
		
		self.TASE = nil
		
		if #UndoTable == 0 then if DidRemove then return true else return end end
		undo.Create("No Collide World, To All Selected Entities")
		for i=1,#UndoTable do undo.AddEntity(UndoTable[i]) end
		undo.SetPlayer(pl)
		undo.SetCustomUndoText("Undone No Collide World, To All Selected Entities")
		undo.Finish()
		return true
	else
		if !trace.Entity then return end
		if !trace.Entity:IsValid() then return end
		if trace.Entity:IsPlayer() then return end
		if CLIENT then return true end
		
		local pl = self:GetOwner()
		if !IsValid(pl) then return end
		if self.Hold then self.Hold[pl] = false end
		if self.AimEnt then self.AimEnt[pl] = nil end
		
		if trace.Entity:GetCollisionGroup() == COLLISION_GROUP_WORLD then
			trace.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
			if trace.Entity.Nocollide and trace.Entity.Nocollide:IsValid() then trace.Entity.Nocollide:Remove() end
			return true
		else
			local function NocollideFind(Ent1, Ent2)
				if !Ent1:GetTable().Constraints then return end
				for k, v in pairs(Ent1:GetTable().Constraints) do
					if v:IsValid() then
						local CTab = v:GetTable()
						if (CTab.Type == "NoCollideWorld" or CTab.Type == "NoCollide") and ((CTab.Ent1 == Ent1 and CTab.Ent2 == Ent2) or (CTab.Ent2 == Ent1 and CTab.Ent1 == Ent2)) then return v end
					end	
				end
				return
			end
			local Const = NocollideFind(trace.Entity, game.GetWorld())
			if IsValid(Const) then
				Const:Remove()
				Const = NULL
			end
			Const = constraint.NoCollideWorld(trace.Entity, game.GetWorld(), trace.PhysicsBone, 0)
			if IsValid(Const) then
				pl:AddCount("nocollide_world", Const)
				trace.Entity:SetCollisionGroup(COLLISION_GROUP_WORLD)
				trace.Entity.Nocollide = Const
				if IsValid(trace.Entity.NocollideDummy) then trace.Entity.NocollideDummy:Remove() end
				
				undo.Create("No Collide World, Disable Collisions")
				undo.AddEntity(Const)
				undo.AddFunction(function(Undo, Ent, Tool, pl)
					if Tool and pl and pl:IsValid() then
						if Tool.Hold then Tool.Hold[pl] = false end
						if Tool.AimEnt then Tool.AimEnt[pl] = nil end
					end
					if Ent and Ent:IsValid() and !IsValid(Ent.NocollideDummy) then Ent:SetCollisionGroup(COLLISION_GROUP_NONE) end
				end, trace.Entity,self,pl)
				undo.SetPlayer(pl)
				undo.SetCustomUndoText("Undone No Collide World, Disable Collisions")
				undo.Finish()
				return true
			end
		end
	end
end

function TOOL:Reload()
	if CLIENT then return true end
	local pl = self:GetOwner()
	if !self.Hold then self.Hold = {} end
	if !IsValid(pl) then return end
	self.Hold[pl] = !self.Hold[pl]
end

local SendToClient = {}
local SendDone = {}

function TOOL:Think()
	if CLIENT then return end
	local Option = self:GetClientNumber("options")
	local Stage = self:GetStage()
	if Option == 1 and Stage != 0 and Stage != 1 then self:SetStage(0) elseif Option == 2 and Stage != 2 then self:SetStage(2) elseif Option == 3 and Stage != 3 and Stage != 4 then self:SetStage(3) elseif Option == 4 and Stage != 5 then self:SetStage(5) elseif Option == 5 and Stage != 6 then self:SetStage(6) elseif Option == 6 and Stage != 7 then self:SetStage(7) elseif Option == 7 and Stage != 8 then self:SetStage(8) elseif Option == 8 and Stage != 5 then self:SetStage(5) elseif Option == 9 and Stage != 5 then self:SetStage(5) elseif Option == 10 and Stage != 9 then self:SetStage(9) end
	
	local pl = self:GetOwner()
	if !IsValid(pl) then return end
	if !SendDone[pl] then SendDone[pl] = 0 end
	if !SendToClient[pl] then SendToClient[pl] = {} end
	if !self.AimEnt then self.AimEnt = {} end
	if !self.Hold then self.Hold = {} end
	if Option != self.OldOption then
		self.OldOption = Option
		self:ClearObjects()
		SendDone[pl] = 0
		self.AimEnt[pl] = nil
		SendToClient[pl] = {}
		self.TASE = nil
		net.Start("DrawNoCollide")
		net.WriteString("0")
		net.Send(pl)
	end
	if !self.Hold[pl] then 
		local trace = pl:GetEyeTrace()
		if !tobool(self:GetClientNumber("effect")) and trace.Entity and trace.Entity:IsValid() and !trace.Entity:IsPlayer() then
			if trace.Entity != self.AimEnt[pl] or Option != self.OldOption then
				self.OldOption = Option
				Stage = self:GetStage()
				SendDone[pl] = 0
				SendToClient[pl] = {}
				net.Start("DrawNoCollide")
				net.WriteString("0a")
				net.Send(pl)
				local TraceEntityIndex = trace.Entity:EntIndex()
				local Ignore
				local ToolEnt1 = self:GetEnt(1)
				local function NocollideFind(Ent1, Ent2)
					if Ent1 == game.GetWorld() then
						Ent1 = Ent2
						Ent2 = game.GetWorld()
					end
					if !Ent1:GetTable().Constraints then return end
					for k, v in pairs(Ent1:GetTable().Constraints) do
						if v:IsValid() then
							local CTab = v:GetTable()
							if (CTab.Type == "NoCollideWorld" or CTab.Type == "NoCollide") and ((CTab.Ent1 == Ent1 and CTab.Ent2 == Ent2) or (CTab.Ent2 == Ent1 and CTab.Ent1 == Ent2)) then return v end
						end	
					end
					return
				end
				if Option == 1 or Option == 2 or Option == 3 or Option == 5 or Option == 10 then
					local AllEnts = {}
					AllEnts[TraceEntityIndex] = true
					if constraint.HasConstraints(trace.Entity) and Stage != 4 then
						local Cons = constraint.GetTable(trace.Entity)
						for i=1,#Cons do
							if Cons[i]["Type"] == "NoCollideWorld" or Cons[i]["Type"] == "NoCollide" then
								local Ent1Index
								local Ent2Index
								if Cons[i]["Entity"] then
									if Cons[i]["Entity"][1] then Ent1Index = Cons[i]["Entity"][1]["Index"] end
									if Cons[i]["Entity"][2] then Ent2Index = Cons[i]["Entity"][2]["Index"] end
								end
								if Ent1Index and Ent2Index then
									local Count = #SendToClient[pl]+1
									SendToClient[pl][Count] = {}
									if Ent1Index == 0 then
										AllEnts[Ent2Index] = true
										if Stage == 1 then
											if self:GetEnt(1) != trace.Entity and (game.GetWorld() == self:GetEnt(1) or ents.GetByIndex(Ent2Index) == self:GetEnt(1)) and Cons[i]["Type"] == "NoCollideWorld" then
												SendToClient[pl][Count][1] = Ent2Index
												SendToClient[pl][Count][3] = 7
											else
												SendToClient[pl][Count][1] = Ent2Index
												SendToClient[pl][Count][3] = 6
											end
										elseif Option == 10 and self.TASE then
											local LIndex = math.min(Ent1Index,Ent2Index)
											local HIndex = math.max(Ent1Index,Ent2Index)
											if self.TASE[2][LIndex] and self.TASE[2][LIndex][HIndex] and self.TASE[2][LIndex][HIndex] == 2 then
												SendToClient[pl][Count] = nil
											else
												SendToClient[pl][Count][1] = Ent2Index
												SendToClient[pl][Count][3] = 6
											end
										else
											SendToClient[pl][Count][1] = Ent2Index
											SendToClient[pl][Count][3] = 6
										end
										if ents.GetByIndex(Ent2Index) == trace.Entity and ((Stage == 1 and self:GetEnt(1) == game.GetWorld()) or Stage == 2) then Ignore = true end
									elseif Ent2Index == 0 then
										AllEnts[Ent1Index] = true
										if Stage == 1 then
											if self:GetEnt(1) != trace.Entity and (ents.GetByIndex(Ent1Index) == self:GetEnt(1) or game.GetWorld() == self:GetEnt(1)) and Cons[i]["Type"] == "NoCollideWorld" then
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][3] = 7
											else
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][3] = 6
											end
										elseif Option == 10 and self.TASE then
											local LIndex = math.min(Ent1Index,Ent2Index)
											local HIndex = math.max(Ent1Index,Ent2Index)
											if self.TASE[2][LIndex] and self.TASE[2][LIndex][HIndex] and self.TASE[2][LIndex][HIndex] == 2 then
												SendToClient[pl][Count] = nil
											else
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][3] = 6
											end
										else
											SendToClient[pl][Count][1] = Ent1Index
											SendToClient[pl][Count][3] = 6
										end
										if ents.GetByIndex(Ent1Index) == trace.Entity and ((Stage == 1 and self:GetEnt(1) == game.GetWorld()) or Stage == 2) then Ignore = true end
									else
										AllEnts[Ent1Index] = true
										AllEnts[Ent2Index] = true
										if Stage == 1 then
											if self:GetEnt(1) != trace.Entity and (ents.GetByIndex(Ent1Index) == self:GetEnt(1) or ents.GetByIndex(Ent2Index) == self:GetEnt(1)) and Cons[i]["Type"] == "NoCollideWorld" then
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][2] = Ent2Index
												SendToClient[pl][Count][3] = 3
											else
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][2] = Ent2Index
												SendToClient[pl][Count][3] = 2
											end
											local Ent1 = ents.GetByIndex(Ent1Index)
											local Ent2 = ents.GetByIndex(Ent2Index)
											if (Ent1 == trace.Entity and Ent2 == self:GetEnt(1)) or (Ent2 == trace.Entity and Ent1 == self:GetEnt(1)) then Ignore = true end
										elseif Option == 10 and self.TASE then
											local LIndex = math.min(Ent1Index,Ent2Index)
											local HIndex = math.max(Ent1Index,Ent2Index)
											if self.TASE[2][LIndex] and self.TASE[2][LIndex][HIndex] and self.TASE[2][LIndex][HIndex] == 2 then
												SendToClient[pl][Count] = nil
											else
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][2] = Ent2Index
												SendToClient[pl][Count][3] = 2
											end
										else
											SendToClient[pl][Count][1] = Ent1Index
											SendToClient[pl][Count][2] = Ent2Index
											SendToClient[pl][Count][3] = 2
										end
									end
								end
							end
						end
					end
					for k,v in pairs(AllEnts) do
						if k != 0 then
							local CollisionGroup = ents.GetByIndex(k):GetCollisionGroup()
							if CollisionGroup == COLLISION_GROUP_WORLD then
								if Option == 5 and ents.GetByIndex(k) == trace.Entity then Ignore = true end
								local Count = #SendToClient[pl]+1
								SendToClient[pl][Count] = {}
								SendToClient[pl][Count][1] = k
								SendToClient[pl][Count][3] = 10
							elseif CollisionGroup == COLLISION_GROUP_WEAPON then
								if Option == 5 and ents.GetByIndex(k) == trace.Entity then Ignore = true end
								local Count = #SendToClient[pl]+1
								SendToClient[pl][Count] = {}
								SendToClient[pl][Count][1] = k
								SendToClient[pl][Count][3] = 11
							end
						end
					end
					if ((Stage == 1 and self:GetEnt(1) != trace.Entity) or Stage == 2) and !Ignore then
						local Ent1Index = TraceEntityIndex
						local Ent2Index 
						if Stage == 1 then Ent2Index = self:GetEnt(1):EntIndex() else Ent2Index = 0 end
						local Count = #SendToClient[pl]+1
						SendToClient[pl][Count] = {}
						if Ent1Index == 0 then
							SendToClient[pl][Count][1] = Ent2Index
							SendToClient[pl][Count][3] = 5
						elseif Ent2Index == 0 then
							SendToClient[pl][Count][1] = Ent1Index
							SendToClient[pl][Count][3] = 5
						else
							SendToClient[pl][Count][1] = Ent1Index
							SendToClient[pl][Count][2] = Ent2Index
							SendToClient[pl][Count][3] = 1
						end
					elseif Stage == 4 then
						local AllEnts = {}
						AllEnts[TraceEntityIndex] = true
						local Entities = ExtractEntities(trace.Entity,nil,nil,tobool(self:GetClientNumber("ignore")))
						if self.Ents1 and Entities then
							local Done = {}
							for k1, Ent1 in pairs(self.Ents1) do
								if Ent1:IsValid() or Ent1 == game.GetWorld() then
									for k2, Ent2 in pairs(Entities) do
										if (Ent2:IsValid() or Ent2 == game.GetWorld()) and Ent1 != Ent2 then
											local Ent1Index = Ent1:EntIndex()
											local Ent2Index = Ent2:EntIndex()
											local Lowest = math.min(Ent1Index,Ent2Index)
											local Highest = math.max(Ent1Index,Ent2Index)
											if !Done[Lowest] then Done[Lowest] = {} end
											if !Done[Lowest][Highest] then
												Done[Lowest][Highest] = true
												AllEnts[Ent1Index] = true
												AllEnts[Ent2Index] = true
												local Count = #SendToClient[pl]+1
												SendToClient[pl][Count] = {}
												if NocollideFind(Ent1,Ent2) then
													if Ent1Index == 0 then
														SendToClient[pl][Count][1] = Ent2Index
														SendToClient[pl][Count][3] = 6
													elseif Ent2Index == 0 then
														SendToClient[pl][Count][1] = Ent1Index
														SendToClient[pl][Count][3] = 6
													else
														SendToClient[pl][Count][1] = Ent1Index
														SendToClient[pl][Count][2] = Ent2Index
														SendToClient[pl][Count][3] = 2
													end
												else
													if Ent1Index == 0 then
														SendToClient[pl][Count][1] = Ent2Index
														SendToClient[pl][Count][3] = 5
													elseif Ent2Index == 0 then
														SendToClient[pl][Count][1] = Ent1Index
														SendToClient[pl][Count][3] = 5
													else
														SendToClient[pl][Count][1] = Ent1Index
														SendToClient[pl][Count][2] = Ent2Index
														SendToClient[pl][Count][3] = 1
													end
												end
											end
										end
									end
								end
							end
						end
						for k,v in pairs(AllEnts) do
							if k != 0 then
								local CollisionGroup = ents.GetByIndex(k):GetCollisionGroup()
								if CollisionGroup == COLLISION_GROUP_WORLD then
									local Count = #SendToClient[pl]+1
									SendToClient[pl][Count] = {}
									SendToClient[pl][Count][1] = k
									SendToClient[pl][Count][3] = 10
								elseif CollisionGroup == COLLISION_GROUP_WEAPON then
									local Count = #SendToClient[pl]+1
									SendToClient[pl][Count] = {}
									SendToClient[pl][Count][1] = k
									SendToClient[pl][Count][3] = 11
								end
							end
						end
					elseif Option == 5 and !Ignore then
						local Count = #SendToClient[pl]+1
						SendToClient[pl][Count] = {}
						SendToClient[pl][Count][1] = TraceEntityIndex
						SendToClient[pl][Count][3] = 9
					end
				elseif Option == 4 then
					local AllEnts = {}
					AllEnts[TraceEntityIndex] = true
					local Entities = ExtractEntities(trace.Entity,nil,nil,tobool(self:GetClientNumber("ignore")))
					if Entities then
						local Done = {}
						for k1, Ent1 in pairs(Entities) do
							for k2, Ent2 in pairs(Entities) do
								if Ent1 != Ent2 then
									if Ent1:IsValid() and Ent2:IsValid() then
										local Ent1Index = Ent1:EntIndex()
										local Ent2Index = Ent2:EntIndex()
										local Lowest = math.min(Ent1Index,Ent2Index)
										local Highest = math.max(Ent1Index,Ent2Index)
										if !Done[Lowest] then Done[Lowest] = {} end
										if !Done[Lowest][Highest] then
											Done[Lowest][Highest] = true
											AllEnts[Ent1Index] = true
											AllEnts[Ent2Index] = true
											local Count = #SendToClient[pl]+1
											SendToClient[pl][Count] = {}
											if NocollideFind(Ent1,Ent2) then
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][2] = Ent2Index
												SendToClient[pl][Count][3] = 2
											else
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][2] = Ent2Index
												SendToClient[pl][Count][3] = 1
											end
										end
									elseif (Ent1:IsValid() or Ent1 == game.GetWorld()) and (Ent2:IsValid() or Ent2 == game.GetWorld()) and NocollideFind(Ent1,Ent2) then
										local Ent1Index = Ent1:EntIndex()
										local Ent2Index = Ent2:EntIndex()
										local Lowest = math.min(Ent1Index,Ent2Index)
										local Highest = math.max(Ent1Index,Ent2Index)
										if !Done[Lowest] then Done[Lowest] = {} end
										if !Done[Lowest][Highest] then
											Done[Lowest][Highest] = true
											AllEnts[Ent1Index] = true
											AllEnts[Ent2Index] = true
											local Count = #SendToClient[pl]+1
											SendToClient[pl][Count] = {}
											if Ent1Index == 0 then
												SendToClient[pl][Count][1] = Ent2Index
												SendToClient[pl][Count][3] = 6
											elseif Ent2Index == 0 then
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][3] = 6
											end
										end
									end
								end
							end
						end
					end
					for k,v in pairs(AllEnts) do
						if k != 0 then
							local CollisionGroup = ents.GetByIndex(k):GetCollisionGroup()
							if CollisionGroup == COLLISION_GROUP_WORLD then
								local Count = #SendToClient[pl]+1
								SendToClient[pl][Count] = {}
								SendToClient[pl][Count][1] = k
								SendToClient[pl][Count][3] = 10
							elseif CollisionGroup == COLLISION_GROUP_WEAPON then
								local Count = #SendToClient[pl]+1
								SendToClient[pl][Count] = {}
								SendToClient[pl][Count][1] = k
								SendToClient[pl][Count][3] = 11
							end
						end
					end
				else
					local AllEnts = {}
					AllEnts[TraceEntityIndex] = true
					local Distance = self:GetClientNumber("distance")
					if Option == 6 then
						local AddVector = Vector(Distance,Distance,Distance)
						for k,v in pairs(ents.FindInBox(trace.Entity:LocalToWorld(trace.Entity:OBBMins()-AddVector), trace.Entity:LocalToWorld(trace.Entity:OBBMaxs()+AddVector))) do
							if v:IsValid() and v:GetPhysicsObject():IsValid() and v != trace.Entity and !v:IsPlayer() then
								local Ent = v:EntIndex()
								AllEnts[Ent] = true
								local Count = #SendToClient[pl]+1
								SendToClient[pl][Count] = {}
								if NocollideFind(v,trace.Entity) then
									SendToClient[pl][Count][1] = Ent
									SendToClient[pl][Count][2] = TraceEntityIndex
									SendToClient[pl][Count][3] = 2
								else
									SendToClient[pl][Count][1] = Ent
									SendToClient[pl][Count][2] = TraceEntityIndex
									SendToClient[pl][Count][3] = 1
								end
							end
						end
					elseif Option == 7 then
						for k,v in pairs(ents.FindInSphere(trace.Entity:LocalToWorld(trace.Entity:OBBCenter()), (trace.Entity:OBBMaxs()/2):Length()+Distance)) do
							if v:IsValid() and v:GetPhysicsObject():IsValid() and v != trace.Entity and !v:IsPlayer() then
								local Ent = v:EntIndex()
								AllEnts[Ent] = true
								local Count = #SendToClient[pl]+1
								SendToClient[pl][Count] = {}
								if NocollideFind(v,trace.Entity) then
									SendToClient[pl][Count][1] = Ent
									SendToClient[pl][Count][2] = TraceEntityIndex
									SendToClient[pl][Count][3] = 2
								else
									SendToClient[pl][Count][1] = Ent
									SendToClient[pl][Count][2] = TraceEntityIndex
									SendToClient[pl][Count][3] = 1
								end
							end
						end
					elseif Option == 8 then
						local Entities = ExtractEntities(trace.Entity,nil,nil,tobool(self:GetClientNumber("ignore")))
						if Entities then
							local AddVector = Vector(Distance,Distance,Distance)
							for k1, Ent1 in pairs(Entities) do
								if Ent1:IsValid() and !Ent1:IsPlayer() then
									for k,v in pairs(ents.FindInBox(Ent1:LocalToWorld(Ent1:OBBMins()-AddVector), Ent1:LocalToWorld(Ent1:OBBMaxs()+AddVector))) do
										if v:IsValid() and v:GetPhysicsObject():IsValid() and v != Ent1 and !v:IsPlayer() then
											local Ent1Index = Ent1:EntIndex()
											local Ent2Index = v:EntIndex()
											AllEnts[Ent1Index] = true
											AllEnts[Ent2Index] = true
											local Count = #SendToClient[pl]+1
											SendToClient[pl][Count] = {}
											if NocollideFind(v,Ent1) then
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][2] = Ent2Index
												SendToClient[pl][Count][3] = 2
											else
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][2] = Ent2Index
												SendToClient[pl][Count][3] = 1
											end
										end
									end
								end
							end
						end
					elseif Option == 9 then
						local Entities = ExtractEntities(trace.Entity,nil,nil,tobool(self:GetClientNumber("ignore")))
						if Entities then
							for k1, Ent1 in pairs(Entities) do
								if Ent1:IsValid() and !Ent1:IsPlayer() then
									for k,v in pairs(ents.FindInSphere(Ent1:LocalToWorld(Ent1:OBBCenter()), (Ent1:OBBMaxs()/2):Length()+Distance)) do
										if v:IsValid() and v:GetPhysicsObject():IsValid() and v != Ent1 and !v:IsPlayer() then
											local Ent1Index = Ent1:EntIndex()
											local Ent2Index = v:EntIndex()
											AllEnts[Ent1Index] = true
											AllEnts[Ent2Index] = true
											local Count = #SendToClient[pl]+1
											SendToClient[pl][Count] = {}
											if NocollideFind(v,Ent1) then
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][2] = Ent2Index
												SendToClient[pl][Count][3] = 2
											else
												SendToClient[pl][Count][1] = Ent1Index
												SendToClient[pl][Count][2] = Ent2Index
												SendToClient[pl][Count][3] = 1
											end
										end
									end
								end
							end
						end
					end
					for k,v in pairs(AllEnts) do
						if k != 0 then
							local CollisionGroup = ents.GetByIndex(k):GetCollisionGroup()
							if CollisionGroup == COLLISION_GROUP_WORLD then
								local Count = #SendToClient[pl]+1
								SendToClient[pl][Count] = {}
								SendToClient[pl][Count][1] = k
								SendToClient[pl][Count][3] = 10
							elseif CollisionGroup == COLLISION_GROUP_WEAPON then
								local Count = #SendToClient[pl]+1
								SendToClient[pl][Count] = {}
								SendToClient[pl][Count][1] = k
								SendToClient[pl][Count][3] = 11
							end
							if NocollideFind(ents.GetByIndex(k),game.GetWorld()) then
								local Count = #SendToClient[pl]+1
								SendToClient[pl][Count] = {}
								SendToClient[pl][Count][1] = k
								SendToClient[pl][Count][3] = 6
							end
						end
					end
				end
				self.AimEnt[pl] = trace.Entity
			end
		else
			if self.AimEnt[pl] != nil then
				SendDone[pl] = 0
				self.AimEnt[pl] = nil
				SendToClient[pl] = {}
				net.Start("DrawNoCollide")
				net.WriteString("0a")
				net.Send(pl)
			end
		end
	end
end

function TOOL:Holster()
	if SERVER then
		local pl = self:GetOwner()
		if self.Hold then self.Hold[pl] = false end
		SendDone[pl] = 0
		if self.AimEnt then self.AimEnt[pl] = nil end
		SendToClient[pl] = {}
		self.TASE = nil
		net.Start("DrawNoCollide")
		net.WriteString("0")
		net.Send(pl)
		self:ClearObjects()
	end
end

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {Text = "#Tool.nocollide_world.name", Description = "#Tool.nocollide_world.desc"})
	
	local ctrl = vgui.Create("CtrlListBox", CPanel)
	ctrl:AddOption("Like default no collide", {nocollide_world_options = "1"})
	ctrl:AddOption("No collide world only", {nocollide_world_options = "2"})
	ctrl:AddOption("Select all constrained", {nocollide_world_options = "3"})
	ctrl:AddOption("To all constrained", {nocollide_world_options = "4"})
	ctrl:AddOption("No collide player only", {nocollide_world_options = "5"})
	ctrl:AddOption("No collide within box", {nocollide_world_options = "6"})
	ctrl:AddOption("No collide within sphere", {nocollide_world_options = "7"})
	ctrl:AddOption("No collide within box all constrained", {nocollide_world_options = "8"})
	ctrl:AddOption("No collide within sphere all constrained", {nocollide_world_options = "9"})
	ctrl:AddOption("To all selected entities", {nocollide_world_options = "10"})
	
	local left = vgui.Create("DLabel", CPanel)
	left:SetText("Nocollide Options")
	left:SetDark(true)
	ctrl:SetHeight(25)
	ctrl:Dock(TOP)
	
	CPanel:AddItem(left, ctrl)
	
	CPanel.IgnoreCheckbox = CPanel:AddControl("Checkbox", {Label = "Ignore No Collide", Command = "nocollide_world_ignore"})
	
	CPanel.RemoveCheckbox = CPanel:AddControl("Checkbox", {Label = "Remove No Collide Or Ignore", Command = "nocollide_world_remove"})
	
	CPanel.AddDistance = vgui.Create("Panel", CPanel)
	CPanel.AddDistance:Dock(TOP)
	CPanel.AddDistance:DockMargin(4, 20, 0, 0)
	CPanel.AddDistance:SetVisible(true)
	
	CPanel.AddDistance.TextArea = CPanel.AddDistance:Add("DTextEntry")
	CPanel.AddDistance.TextArea:SetDrawBackground(false)
	CPanel.AddDistance.TextArea:SetNumeric(true)
	CPanel.AddDistance.TextArea.OnChange = function(val)
		val = tonumber(val:GetValue()) or 0
		if val then
			CPanel.AddDistance.Scratch:SetValue(val)
			val = tonumber(CPanel.AddDistance.Scratch:GetFloatValue()) or 0
			CPanel.AddDistance.Slider:SetSlideX(CPanel.AddDistance.Scratch:GetFraction(val))
		end
	end
	
	CPanel.AddDistance.Slider = CPanel.AddDistance:Add("DSlider", CPanel.AddDistance)
	CPanel.AddDistance.Slider:SetLockY(0.5)
	CPanel.AddDistance.Slider.TranslateValues = function(slider, x, y)
		local val = math.Clamp(x*1000, 0, 1000)
		if val then
			CPanel.AddDistance.Scratch:SetValue(val)
			if CPanel.AddDistance.TextArea != vgui.GetKeyboardFocus() then
				local str = CPanel.AddDistance.Scratch:GetTextValue()
				if string.find(str,".",1,true) then str = string.Explode(".", str, true)[1] end
				CPanel.AddDistance.TextArea:SetValue(str)
			end
		end
		return CPanel.AddDistance.Scratch:GetFraction(), y
	end
	CPanel.AddDistance.Slider:SetTrapInside(true)
	Derma_Hook(CPanel.AddDistance.Slider, "Paint", "Paint", "NumSlider")
	CPanel.AddDistance.Slider:SetNotches(10)
	
	CPanel.AddDistance.Label = vgui.Create("DLabel", CPanel.AddDistance)
	CPanel.AddDistance.Label:SetMouseInputEnabled(true)
	CPanel.AddDistance.Label:SetDark(true)
	CPanel.AddDistance.Label:SetText("Add Distance")
	
	CPanel.AddDistance.Scratch = CPanel.AddDistance.Label:Add("DNumberScratch")
	CPanel.AddDistance.Scratch:SetImageVisible(false)
	CPanel.AddDistance.Scratch:Dock(FILL)
	CPanel.AddDistance.Scratch.OnValueChanged = function()
		local val = tonumber(CPanel.AddDistance.Scratch:GetFloatValue()) or 0
		CPanel.AddDistance.Slider:SetSlideX(CPanel.AddDistance.Scratch:GetFraction(val))
		if CPanel.AddDistance.TextArea != vgui.GetKeyboardFocus() then
			local str = CPanel.AddDistance.Scratch:GetTextValue()
			if string.find(str,".",1,true) then str = string.Explode(".", str, true)[1] end
			CPanel.AddDistance.TextArea:SetValue(str)
		end
	end
	CPanel.AddDistance.Scratch:SetMin(0)
	CPanel.AddDistance.Scratch:SetMax(1000)
	CPanel.AddDistance.Scratch:SetDecimals(0)
	CPanel.AddDistance.Scratch:SetConVar("nocollide_world_distance")
	
	CPanel.AddDistance:SetTall(32)
	
	function CPanel.AddDistance:PerformLayout()
		local Left = 5
		CPanel.AddDistance.Label:SetPos(Left, 0)
		CPanel.AddDistance.Label:SetWide(70, 0)
		Left = Left+70
		CPanel.AddDistance.Slider:SetPos(Left, 0)
		local Right = CPanel:GetWide()-10
		Right = Right-35
		CPanel.AddDistance.TextArea:SetPos(Right, 0)
		CPanel.AddDistance.TextArea:SetWide(30)
		CPanel.AddDistance.Slider:SetWide((Right-Left)-5)
	end
	
	local val = GetConVarNumber("nocollide_world_distance") or 0
	if val then
		CPanel.AddDistance.Scratch:SetValue(val)
		val = tonumber(CPanel.AddDistance.Scratch:GetFloatValue()) or 0
		CPanel.AddDistance.Slider:SetSlideX(CPanel.AddDistance.Scratch:GetFraction(val))
		if CPanel.AddDistance.TextArea != vgui.GetKeyboardFocus() then
			local str = CPanel.AddDistance.Scratch:GetTextValue()
			if string.find(str,".",1,true) then str = string.Explode(".", str, true)[1] end
			CPanel.AddDistance.TextArea:SetValue(str)
		end
	end
	
	CPanel:AddControl("Checkbox", {Label = "Hide Effect", Command = "nocollide_world_effect"})
	
	local function CVarChange(_,Old,New)
		if New then
			if CPanel.IgnoreCheckbox then if New == "3" or New == "4" or New == "8" or New == "9" then CPanel.IgnoreCheckbox:SetVisible(true) else CPanel.IgnoreCheckbox:SetVisible(false) end end
			if CPanel.AddDistance then if New == "6" or New == "7" or New == "8" or New == "9" then CPanel.AddDistance:SetVisible(true) else CPanel.AddDistance:SetVisible(false) end end
			if CPanel.RemoveCheckbox and New == "10" then CPanel.RemoveCheckbox:SetVisible(true) else CPanel.RemoveCheckbox:SetVisible(false) end
		end
	end
	cvars.AddChangeCallback("nocollide_world_options", CVarChange)
	CVarChange(nil,nil,GetConVarString("nocollide_world_options"))
end

if SERVER then
	hook.Add("Tick", "NoCollideWorldTick", function()
		for k,pl in pairs(player.GetAll()) do
			if SendToClient[pl] and SendToClient[pl][SendDone[pl]+1] then
				local S = SendDone[pl]+1
				SendDone[pl] = S
				net.Start("DrawNoCollide")
				if SendToClient[pl][S][2] then net.WriteString(tostring(SendToClient[pl][S][1]).."_"..SendToClient[pl][S][2].."_"..SendToClient[pl][S][3]) else net.WriteString(tostring(SendToClient[pl][S][1]).."_"..SendToClient[pl][S][3]) end
				net.Send(pl)
				if !SendToClient[pl][S+1] then
					SendDone[pl] = 0
					SendToClient[pl] = {}
				end
			end
			if SendToClient2[pl] and SendToClient2[pl][SendDone2[pl]+1] then
				local S = SendDone2[pl]+1
				SendDone2[pl] = S
				net.Start("DrawNoCollide")
				if SendToClient2[pl][S][2] then net.WriteString(tostring(SendToClient2[pl][S][1]).."_"..SendToClient2[pl][S][2].."_"..SendToClient2[pl][S][3]) else net.WriteString(tostring(SendToClient2[pl][S][1]).."_"..SendToClient2[pl][S][3]) end
				net.Send(pl)
				if !SendToClient2[pl][S+1] then
					SendDone2[pl] = 0
					SendToClient2[pl] = {}
				end
			end
		end
	end)

	local MAX_CONSTRAINTS_PER_SYSTEM = 100
	
	local function CreateConstraintSystem()
		local System = ents.Create("phys_constraintsystem")
		if !IsValid(System) then return end
		System:SetKeyValue("additionaliterations", GetConVarNumber("gmod_physiterations"))
		System:Spawn()
		System:Activate()
		return System
	end
	
	local function FindOrCreateConstraintSystem(Ent1, Ent2)
		local System
		if !Ent1:IsWorld() and Ent1:GetTable().ConstraintSystem and Ent1:GetTable().ConstraintSystem:IsValid() then System = Ent1:GetTable().ConstraintSystem end
		if System and System:IsValid() and System:GetVar("constraints", 0) > MAX_CONSTRAINTS_PER_SYSTEM then System = nil end
		if !System and !Ent2:IsWorld() and Ent2:GetTable().ConstraintSystem and Ent2:GetTable().ConstraintSystem:IsValid() then System = Ent2:GetTable().ConstraintSystem end
		if System and System:IsValid() and System:GetVar("constraints", 0) > MAX_CONSTRAINTS_PER_SYSTEM then System = nil end
		if !System or !System:IsValid() then System = CreateConstraintSystem() end
		if !System then return end
		Ent1.ConstraintSystem = System
		Ent2.ConstraintSystem = System
		System.UsedEntities = System.UsedEntities or {}
		table.insert(System.UsedEntities, Ent1)
		table.insert(System.UsedEntities, Ent2)
		System:SetVar("constraints", System:GetVar("constraints", 0)+1)
		return System
	end
	
	function constraint.NoCollideWorld(Ent1, Ent2, Bone1, Bone2)
		if !Ent1 or !Ent2 then return false end
		
		if Ent1 == game.GetWorld() then
			Ent1 = Ent2
			Ent2 = game.GetWorld()
			Bone1 = Bone2
			Bone2 = 0
		end
		
		if !Ent1:IsValid() or (!Ent2:IsWorld() and !Ent2:IsValid()) then return false end
		
		Bone1 = Bone1 or 0
		Bone2 = Bone2 or 0
		
		local Phys1 = Ent1:GetPhysicsObjectNum(Bone1)
		local Phys2 = Ent2:GetPhysicsObjectNum(Bone2)
		
		if !Phys1 or !Phys1:IsValid() or !Phys2 or !Phys2:IsValid() then return false end
		
		if Phys1 == Phys2 then return false end
		
		if Ent1:GetTable().Constraints then
			for k, v in pairs(Ent1:GetTable().Constraints) do
				if v:IsValid() then
					local CTab = v:GetTable()
					if (CTab.Type == "NoCollideWorld" or CTab.Type == "NoCollide") and ((CTab.Ent1 == Ent1 and CTab.Ent2 == Ent2) or (CTab.Ent2 == Ent1 and CTab.Ent1 == Ent2)) then return false end
				end	
			end
		end
		
		local System = FindOrCreateConstraintSystem(Ent1, Ent2)
		
		if !IsValid(System) then return false end
		
		SetPhysConstraintSystem(System)
		
		local Constraint = ents.Create("phys_ragdollconstraint")
		
		if !IsValid(Constraint) then
			SetPhysConstraintSystem(NULL)
			return false
		end
		Constraint:SetKeyValue("xmin", -180)
		Constraint:SetKeyValue("xmax", 180)
		Constraint:SetKeyValue("ymin", -180)
		Constraint:SetKeyValue("ymax", 180)
		Constraint:SetKeyValue("zmin", -180)
		Constraint:SetKeyValue("zmax", 180)
		Constraint:SetKeyValue("spawnflags", 3)
		Constraint:SetPhysConstraintObjects(Phys1, Phys2)
		Constraint:Spawn()
		Constraint:Activate()
		
		SetPhysConstraintSystem(NULL)
		constraint.AddConstraintTable(Ent1, Constraint, Ent2)
		
		local ctable = 
		{
			Type 			= "NoCollideWorld",
			Ent1  			= Ent1,
			Ent2 			= Ent2,
			Bone1 			= Bone1,
			Bone2 			= Bone2
		}
		
		Constraint:SetTable(ctable)
		
		return Constraint
	end
	duplicator.RegisterConstraint("NoCollideWorld", constraint.NoCollideWorld, "Ent1", "Ent2", "Bone1", "Bone2")
end