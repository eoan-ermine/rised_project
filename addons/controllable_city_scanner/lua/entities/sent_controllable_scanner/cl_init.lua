-- "addons\\controllable_city_scanner\\lua\\entities\\sent_controllable_scanner\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Initialize()
    self.yawOffset = 0
    self.isSelfDestructing = false
    self.isInThirdPerson = false
    self.ownerClientPlayerModel = NULL
    self.ownerClientGlassesModel = NULL
    self.oldControlActive = false
end

function ENT:Think()
    local newValue = self:GetControlActive()
    
    if self.oldControlActive ~= newValue then
        local playerController = self:GetPlayerController()
        
        if IsValid(playerController) then
            if newValue then
                local angle = playerController:EyeAngles()
                angle.p = 0
                
                self.oldHullDuckMins, self.oldHullDuckMaxs = playerController:GetHullDuck()
                playerController:SetHullDuck(playerController:GetHull())
                
                self:HookAdd("Think", "UpdateClientModel", function()
                    if IsValid(playerController) then
                        -- if not IsValid(self.ownerClientPlayerModel) then
                        --     self.ownerClientPlayerModel = ClientsideModel(playerController:GetModel(), RENDERGROUP_BOTH)
                        --     self.ownerClientPlayerModel:SetAngles(angle)
                            
                        --     local sequenceID, sequenceDuration = playerController:LookupSequence(ControllableScanner.ConVarHideHeadModel() and self.ClientPlayerModelNoHeadModelSequence or self.ClientPlayerModelSequence)
                            
                        --     if sequenceID == -1 then
                        --         sequenceID, sequenceDuration = playerController:LookupSequence(self.ClientPlayerModelAlternative1Sequence)
                        --     end
                            
                        --     if sequenceID == -1 then
                        --         sequenceID, sequenceDuration = playerController:LookupSequence(self.ClientPlayerModelAlternative2Sequence)
                        --     end
                            
                        --     if sequenceID == -1 then
                        --         sequenceID, sequenceDuration = playerController:LookupSequence(self.ClientPlayerModelAlternative3Sequence)
                        --     end
                            
                        --     if sequenceID == -1 then
                        --         for sequenceID2, sequence2 in ipairs(playerController:GetSequenceList()) do
                        --             if string.find(sequence2, "idle") then
                        --                 sequenceID = sequenceID2
                                        
                        --                 break
                        --             end
                        --         end
                        --     end
                            
                        --     if sequenceID != -1 then
                        --         self.ownerClientPlayerModel:SetSequence(sequenceID)
                        --     end
                            
                        --     self.ownerClientPlayerModel.GetPlayerColor = function()
                        --         if IsValid(playerController) and playerController.GetPlayerColor then
                        --             return playerController:GetPlayerColor()
                        --         else
                        --             return Vector()
                        --         end
                        --     end
                        -- end
                        
                        -- self.ownerClientPlayerModel:SetPos(playerController:GetPos())
                        
                        -- if not ControllableScanner.ConVarHideHeadModel() then
                        --     local glassesBone = self.ownerClientPlayerModel:LookupBone(self.ClientGlassesBone)
                            
                        --     if glassesBone then
                        --         local headBoneMatrix = self.ownerClientPlayerModel:GetBoneMatrix(self.ownerClientPlayerModel:LookupBone(self.ClientGlassesBone))
                                
                        --         if headBoneMatrix then
                        --             if not IsValid(self.ownerClientGlassesModel) then
                        --                 self.ownerClientGlassesModel = ClientsideModel(self.ClientGlassesModel, RENDERGROUP_BOTH)
                        --                 self.ownerClientGlassesModel:SetModelScale(self.ClientGlassesScale, 0)
                        --             end
                                    
                        --             local position, angle = LocalToWorld(self.ClientGlassesOffsetPos, self.ClientGlassesOffsetAngle, headBoneMatrix:GetTranslation(), headBoneMatrix:GetAngles())
                                    
                        --             self.ownerClientGlassesModel:SetPos(position)
                        --             self.ownerClientGlassesModel:SetAngles(angle)
                        --         end
                        --     end
                        -- end
                        
                        playerController:SetNoDraw(true)
                    end
                end)
                
                self:HookAdd("PlayerFootstep", "MuteFootsteps", function(ply, pos, foot, sound, volume, filter)
                    if ply == playerController then
                        return true
                    end
                end)
                
                self:HookAdd("PrePlayerDraw", "HidePlayer", function(ply)
                    if ply == playerController then
                        ply:DestroyShadow()
                        
                        return true
                    end
                end)
            else
                self:StopControlling()
                
                if self.oldHullDuckMins and self.oldHullDuckMaxs then
                    playerController:SetHullDuck(self.oldHullDuckMins, self.oldHullDuckMaxs)
                end
            end
            
            local weapon = playerController:GetWeapon(ControllableScanner.manhackWeaponClassName)
            
            if IsValid(weapon) then
                weapon.HideWorldModel = newValue
            end
        end
        
        self.oldControlActive = newValue
    end
end

function ENT:DrawTranslucent()
    local playerController = self:GetPlayerController()
    local shouldDraw = false

    if not IsValid(playerController) or playerController ~= LocalPlayer() or (playerController == LocalPlayer() and (not self:GetControlActive() or (self:GetControlActive() and GetConVar("rised_thirdpersonview_enable"):GetBool()))) then
        self:DrawModel()
        
        --local sprite1Matrix = self:GetBoneMatrix(self:LookupBone(self.GlowSprite1Bone))
        --local sprite2Matrix = self:GetBoneMatrix(self:LookupBone(self.GlowSprite2Bone))
        
        if sprite1Matrix and sprite2Matrix then
            --local sprite1Pos = LocalToWorld(self.GlowSprite1Offset, Angle(0, 0, 0), sprite1Matrix:GetTranslation(), sprite1Matrix:GetAngles())
            --local sprite2Pos = LocalToWorld(self.GlowSprite2Offset, Angle(0, 0, 0), sprite2Matrix:GetTranslation(), sprite2Matrix:GetAngles())
            
            cam.Start3D()
    		render.SetMaterial(self.GlowSpriteMaterial)
            
            --If self destructing
            if self.isSelfDestructing then
                render.DrawSprite((CurTime() * 2 % 1) < 0.5 and sprite1Pos or sprite2Pos, 16, 16, self.GlowSpriteColorSelfDesctructing)
            --If is being controlled
            elseif self:GetControlActive() or not ControllableScanner.ConVarMultiGlowColor() then
                render.DrawSprite(sprite1Pos, 16, 16, self.GlowSpriteColorActive)
        		render.DrawSprite(sprite2Pos, 16, 16, self.GlowSpriteColorActive)
            --If deploying
            elseif self:GetSequence() == self:LookupSequence(self.SequenceDeploy) then
                render.DrawSprite(sprite1Pos, 16, 16, self.GlowSpriteColorDeploy)
        		render.DrawSprite(sprite2Pos, 16, 16, self.GlowSpriteColorDeploy)
            --If inactive
            else
                render.DrawSprite(sprite1Pos, 16, 16, self.GlowSpriteColorInactive)
        		render.DrawSprite(sprite2Pos, 16, 16, self.GlowSpriteColorInactive)
            end
            
        	cam.End3D()
        end
    end
end

function ENT:OnRemove()
    self:StopControlling()
end

function ENT:StartControlling()
    self:HookAddOverride("CalcView", "ManhackView", function(ply, pos, angles, fov)
        local angle = ply:EyeAngles()
        
        if not self.yawOffset then
            self.yawOffset = self:GetAngles().y - angle.y
        end
        
        angle.y = angle.y + self.yawOffset
        
        if GetConVar("rised_thirdpersonview_enable"):GetBool() then
            local traceHull = util.TraceHull({
        		start = self:GetPos(),
        		endpos = self:GetPos() - angle:Forward() * self.ThirdPersonDistance,
        		mins = Vector(-self.ThirdPersonHullSize, -self.ThirdPersonHullSize, -self.ThirdPersonHullSize),
                maxs = Vector(self.ThirdPersonHullSize, self.ThirdPersonHullSize, self.ThirdPersonHullSize),
        		filter = self
        	})
            
            return {
                origin = self:GetPos() - angle:Forward() * (self:GetPos():Distance(traceHull.HitPos)),
            	angles = angle,
            	fov = fov,
            	drawviewer = true
            }
        else
            return {
                origin = self:GetPos(),
            	angles = angle,
            	fov = fov,
            	drawviewer = true
            }
        end
    end)
    
    self:HookAddOverride("HUDPaint", "ManhackHUD", function()
        if ControllableScanner.ConVarHUDTargets() and not GetConVar("rised_thirdpersonview_enable"):GetBool() then
            for entIndex, ent in pairs(ents.FindInSphere(self:GetPos(), self.HUDShowTargetDistance)) do
                local className = ent:GetClass()
				if ent:IsPlayer() then
					if className ~= self.ClassName then
						local text
						
						if className == "player" then
							text = string.upper(ent:Nick())
						elseif string.find(className, "npc_*") then
							text = string.upper(ent:GetClass())
						end
						
						if text and not ent.Alive or (ent.Alive and ent:Alive()) then
							local screenPosition = (ent:GetPos() + ent:OBBCenter()):ToScreen()
							
                            local id64 = 0
                            if !ent:IsBot() then
                                id64 = ent:SteamID64()
                            else
                                id64 = "00000"
                            end

							if screenPosition.visible then
								
								if ent:isCP() || FaceMemory_Check(ent) then
									surface.SetDrawColor(255, 165, 0, 125)
									surface.DrawTexturedRect(screenPosition.x - 200/2, screenPosition.y - 40, 125, 2)
									surface.DrawTexturedRect(screenPosition.x - 200/4, screenPosition.y - 0, 125, 2)
								
									draw.SimpleTextOutlined(text, self.HUDTextFont, screenPosition.x, screenPosition.y - self.HUDTargetYSpacing * 1.5, self.HUDTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, self.HudTextOutlineSize, self.HUDTextOutlineColor)
									draw.SimpleTextOutlined("ID: " .. id64, self.HUDTextFont, screenPosition.x, screenPosition.y + self.HUDTargetYSpacing + 10, self.HUDTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, self.HudTextOutlineSize, self.HUDTextOutlineColor)
									draw.SimpleTextOutlined("LT: " .. ent:GetNWInt("LoyaltyTokens", 0), self.HUDTextFont, screenPosition.x, screenPosition.y + self.HUDTargetYSpacing * 3 + 5, self.HUDTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, self.HudTextOutlineSize, self.HUDTextOutlineColor)
								else
									surface.SetDrawColor(255, 165, 0, 125)
                                    
									surface.DrawTexturedRect(screenPosition.x - 200/2 + math.random(-2, 2), screenPosition.y - 40 + math.random(-2, 2), 125, 2)
									surface.DrawTexturedRect(screenPosition.x - 200/4 + math.random(-2, 2), screenPosition.y - 0 + math.random(-2, 2), 125, 2)
                                    local symbols = {
                                        '!',
                                        '@',
                                        '#',
                                        '$',
                                        '%',
                                        '^',
                                        '&',
                                        '*',
                                    }
                                    local rndWord = table.Random(symbols) .. table.Random(symbols) .. table.Random(symbols) .. table.Random(symbols) .. table.Random(symbols) .. table.Random(symbols) .. table.Random(symbols) .. table.Random(symbols)
									draw.SimpleTextOutlined(rndWord, self.HUDTextFont, screenPosition.x, screenPosition.y - self.HUDTargetYSpacing * 1.5, self.HUDTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, self.HudTextOutlineSize, self.HUDTextOutlineColor)
                                end
							end
						end
					end
				end
            end
        end
        
        if ControllableScanner.ConVarHUDTexts() and not GetConVar("rised_thirdpersonview_enable"):GetBool() or (GetConVar("rised_thirdpersonview_enable"):GetBool() and ControllableScanner.ConVarThirdPersonHUD()) then
            surface.SetFont(self.HUDTextFont)
            local seperatorTextSizeX, seperatorTextSizeY = surface.GetTextSize(self.HUDTextSeperator)
            
            for hudTextIndex, hudText in pairs(self.HUDTexts) do
                local y = ScrH() - self.HUDTextOffset.y + self.HUDTextYSpacing * hudTextIndex - (#self.HUDTexts) * (seperatorTextSizeY + self.HUDTextSeperatorXSpacing * 2)
                
                draw.SimpleTextOutlined(hudText.name, "combine_5", self.HUDTextOffset.x, y, self.HUDTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, self.HudTextOutlineSize, self.HUDTextOutlineColor)
                draw.SimpleTextOutlined(self.HUDTextSeperator, "combine_5", self.HUDTextOffset.x + self.HUDTextSeperatorXSpacing, y, self.HUDTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, self.HudTextOutlineSize, self.HUDTextOutlineColor)
                draw.SimpleTextOutlined(hudText:GetValue(self), "combine_5", self.HUDTextOffset.x + self.HUDTextSeperatorXSpacing * 2 + seperatorTextSizeX, y, self.HUDTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, self.HudTextOutlineSize, self.HUDTextOutlineColor)
            end
        end
    end)
    
    self:HookAdd("Move", "PreventOwnerMovement", function(ply, moveData)
        if ply == LocalPlayer() then
            return true
        end
    end)
    
    local preventWalkPress = false
    self:HookAdd("KeyPress", "KeyActions", function(ply, key)
        if ply == LocalPlayer() then
            if key == IN_WALK and not preventWalkPress then
                if ControllableScanner.ConVarThirdPersonAllowed() then
                    self.isInThirdPerson = not self.isInThirdPerson
                end
                
                preventWalkPress = true
                
                timer.Simple(0, function()
                    preventWalkPress = false
                end)
            end
        end
    end)
    
    self:HookAdd("RenderScreenspaceEffects", "Overlay", function()
        if ControllableScanner.ConVarHUDOverlay() and not GetConVar("rised_thirdpersonview_enable"):GetBool() then
            DrawMaterialOverlay(self.OverlayMaterial, 1)
            DrawColorModify(self.ColorModify)
        end
    end)
    
    self:HookAdd("HUDShouldDraw", "HideNormalHUD", function(name)
        if not self.HUDWhitelist[name] then
            return false
        end
    end)
    
    ControllableScanner.RealHUDDrawTargetID = ControllableScanner.RealHUDDrawTargetID or GAMEMODE.HUDDrawTargetID
    
    function GAMEMODE:HUDDrawTargetID()
        --Empty function to stop drawing target ID
    end
    
    self:SetControlActive(true)
    ControllableScanner.manhackBeingControlled = self
end

function ENT:StopControlling()
    self:HookRemoveOverride("CalcView", "ManhackView")
    self:HookRemoveOverride("HUDPaint", "ManhackHUD")
    self:HookRemove("Move", "PreventOwnerMovement")
    self:HookRemove("KeyPress", "KeyActions")
    self:HookRemove("RenderScreenspaceEffects", "Overlay")
    self:HookRemove("HUDShouldDraw", "HideNormalHUD")
    self:HookRemove("Think", "UpdateClientModel")
    self:HookRemove("PrePlayerDraw", "HidePlayer")
    self:HookRemove("PlayerFootstep", "MuteFootsteps")
    
    if ControllableScanner.RealHUDDrawTargetID then
        GAMEMODE.HUDDrawTargetID = ControllableScanner.RealHUDDrawTargetID
    end
    
    SafeRemoveEntity(self.ownerClientPlayerModel)
    SafeRemoveEntity(self.ownerClientGlassesModel)
    
    if self:GetControlActive() then
        self:SetControlActive(false)
    end
    
    local playerController = self:GetPlayerController()
    
    if IsValid(playerController) then
        playerController:SetNoDraw(false)
        
        if playerController == LocalPlayer() and IsValid(ControllableScanner.manhackBeingControlled) and ControllableScanner.manhackBeingControlled == self then
            ControllableScanner.manhackBeingControlled = nil
        end
        
        local weapon = playerController:GetWeapon(ControllableScanner.manhackWeaponClassName)
        
        if IsValid(weapon) then
            weapon.HideWorldModel = false
        end
    end
end

function ENT:IsCharging()
    return self:GetPoseParameter("Panel1") > 0
end

function ENT:ThirdPersonEnabled()
    return ControllableScanner.ConVarThirdPersonAllowed() and self.isInThirdPerson
end

net.Receive(ControllableScanner.manhackEntityClassName .. ".ClientStartControlling", function(length)
    local manhack = net.ReadEntity()
    local yawOffset = net.ReadFloat()
    
    if IsValid(manhack) and manhack.StartControlling then
        manhack.yawOffset = yawOffset
        manhack:StartControlling()
    end
end)

net.Receive(ControllableScanner.manhackEntityClassName .. ".ClientStopControlling", function(length)
    local manhack = net.ReadEntity()
    
    if IsValid(manhack) and manhack.StopControlling then
        manhack:StopControlling()
    end
end)

net.Receive(ControllableScanner.manhackEntityClassName .. ".ClientDestroyed", function(length)
    local origin = net.ReadVector()
    
    local effectData = EffectData()
    effectData:SetOrigin(origin)
    effectData:SetNormal(Vector(0, 0, 1))
    effectData:SetScale(1)
	effectData:SetMagnitude(1)
    util.Effect("ElectricSpark", effectData)
end)

net.Receive(ControllableScanner.manhackEntityClassName .. ".ClientSelfDestructing", function(length)
    local manhack = net.ReadEntity()
    
    if IsValid(manhack) then
        manhack.isSelfDestructing = true
    end
end)
