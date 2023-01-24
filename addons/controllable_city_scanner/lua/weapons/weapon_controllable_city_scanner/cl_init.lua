-- "addons\\controllable_city_scanner\\lua\\weapons\\weapon_controllable_city_scanner\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

SWEP.PrintName = "City Scanner"
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.vRenderOrder = nil
SWEP.VElements = {
	["manhack"] = { type = "Model", model = "models/props_combine/combinebutton.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(2.721, 2.238, -1.711), angle = Angle(179.328, 142.119, -5.4), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["manhack"] = { type = "Model", model = "models/props_combine/combinebutton.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.673, 4.599, -0.691), angle = Angle(171.438, 89.553, 4.699), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.ViewModelBoneMods = {
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

function SWEP:PrimaryAttack()
	if IsValid(self.Owner) and self:HasAmmo() and not IsValid(ControllableScanner.manhackBeingControlled) or (IsValid(ControllableScanner.manhackBeingControlled) and not ControllableScanner.manhackBeingControlled:GetControlActive()) then
		self.Owner:GetViewModel():SendViewModelMatchingSequence(self.PrimarySequence)
		
		timer.Simple(self.SpawnDelay, function()
			if IsValid(self) then
				self.VElements["manhack"].color = Color(255, 255, 255, 0)
			end
		end)
		
		timer.Simple(self.ResetDelay, function()
			if IsValid(self) then
				self.VElements["manhack"].color = Color(255, 255, 255, 255)
				
				self.Owner:GetViewModel():SendViewModelMatchingSequence(self.PrimarySequence2)
			end
		end)
		
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	end
end

function SWEP:SecondaryAttack()
	
end

function SWEP:Initialize()
    if !IsValid(OperationsMenu) and LocalPlayer():HasWeapon("weapon_controllable_city_scanner") then
        OperationsMenu = vgui.Create("DFrame")
        OperationsMenu:SetSize(400, 100)
        OperationsMenu:SetPos(ScrW()/2 - 200,ScrH()- 150)
        OperationsMenu:SetTitle("")
        OperationsMenu:SetDraggable(false)
        OperationsMenu:ShowCloseButton(false)
        OperationsMenu.active = true
        OperationsMenu.Paint = function(self, w, h)
            if OperationsMenu.active then
                local offset = 40
                draw.SimpleText("1", "zejton30", 30, -20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("2", "zejton30", 140, -20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("3", "zejton30", 240, -20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("4", "zejton30", 345, -20 + offset, Color(255,165,0,75), 1, 1)

                draw.RoundedBox(2, 0, 0 + offset, w, 2, Color(255,165,0,75))

                draw.SimpleText("Stop!", "zejton20", 30, 20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("Scanning!", "zejton20", 140, 20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("Failed!", "zejton20", 240, 20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("Go away!", "zejton20", 345, 20 + offset, Color(255,165,0,75), 1, 1)
            end
        end

        CursorPanel = vgui.Create("DFrame")
        CursorPanel:SetSize(3, 3)
        CursorPanel:SetPos(ScrW()/2+5, ScrH()/2+5)
        CursorPanel:SetTitle("")
        CursorPanel:SetDraggable(false)
        CursorPanel.active = true
        CursorPanel.Paint = function(self, w, h)
            if CursorPanel.active then
                draw.RoundedBox(2, 0, 0, w, h, color_orange)
            end
        end
    end
end

function SWEP:Deploy()
    if !IsValid(OperationsMenu) and LocalPlayer():HasWeapon("weapon_controllable_city_scanner") then
        OperationsMenu = vgui.Create("DFrame")
        OperationsMenu:SetSize(400, 100)
        OperationsMenu:SetPos(ScrW()/2 - 200,ScrH()- 150)
        OperationsMenu:SetTitle("")
        OperationsMenu:SetDraggable(false)
        OperationsMenu:ShowCloseButton(false)
        OperationsMenu.active = true
        OperationsMenu.Paint = function(self, w, h)
            if OperationsMenu.active then
                local offset = 40
                draw.SimpleText("1", "zejton30", 30, -20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("2", "zejton30", 140, -20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("3", "zejton30", 240, -20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("4", "zejton30", 345, -20 + offset, Color(255,165,0,75), 1, 1)

                draw.RoundedBox(2, 0, 0 + offset, w, 2, Color(255,165,0,75))

                draw.SimpleText("Stop!", "zejton20", 30, 20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("Scanning!", "zejton20", 140, 20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("Failed!", "zejton20", 240, 20 + offset, Color(255,165,0,75), 1, 1)
                draw.SimpleText("Go away!", "zejton20", 345, 20 + offset, Color(255,165,0,75), 1, 1)
            end
        end

        CursorPanel = vgui.Create("DFrame")
        CursorPanel:SetSize(3, 3)
        CursorPanel:SetPos(ScrW()/2+5, ScrH()/2+5)
        CursorPanel:SetTitle("")
        CursorPanel:SetDraggable(false)
        CursorPanel.active = true
        CursorPanel.Paint = function(self, w, h)
            if CursorPanel.active then
                draw.RoundedBox(2, 0, 0, w, h, color_orange)
            end
        end
    end
end

function SWEP:Holster()
    if IsValid(OperationsMenu) then
        OperationsMenu:Close()
    end
    if IsValid(CursorPanel) then
        CursorPanel:Close()
    end
end

function SWEP:Think()
	if IsValid(self.Owner) then
		self.Owner:DrawViewModel(self:HasAmmo())
        if LocalPlayer():GetNWBool("Rised_Combot_Entered") then
            if IsValid(OperationsMenu) then
                OperationsMenu.active = true
            end
            
            if input.IsButtonDown(KEY_1) then
                net.Start("Rised_Combot_Server")
                net.WriteInt(1,10)
                net.SendToServer()
            elseif input.IsButtonDown(KEY_2) then
                net.Start("Rised_Combot_Server")
                net.WriteInt(2,10)
                net.SendToServer()
            elseif input.IsButtonDown(KEY_3) then
                net.Start("Rised_Combot_Server")
                net.WriteInt(3,10)
                net.SendToServer()
            elseif input.IsButtonDown(KEY_4) then
                net.Start("Rised_Combot_Server")
                net.WriteInt(4,10)
                net.SendToServer()
            end
        else
            if IsValid(OperationsMenu) then
                OperationsMenu.active = false
            end
        end
	end
end

function SWEP:ViewModelDrawn()
	local vm = IsValid(self.Owner) and self.Owner:GetViewModel()
    if !IsValid(vm) then return end
    
    if (!self.VElements) then return end
    
    self:UpdateBonePositions(vm)

    if (!self.vRenderOrder) then
        
        --we build a render order because sprites need to be drawn after models
        self.vRenderOrder = {}

        for k, v in pairs( self.VElements ) do
            if (v.type == "Model") then
                table.insert(self.vRenderOrder, 1, k)
            elseif (v.type == "Sprite" or v.type == "Quad") then
                table.insert(self.vRenderOrder, k)
            end
        end
        
    end

    for k, name in ipairs( self.vRenderOrder ) do
    
        local v = self.VElements[name]
        if (!v) then self.vRenderOrder = nil break end
        if (v.hide) then continue end
        
        local model = v.modelEnt
        local sprite = v.spriteMaterial
        
        if (!v.bone) then continue end
        
        local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
        
        if (!pos) then continue end
        
        if (v.type == "Model" and IsValid(model)) then

            model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)

            model:SetAngles(ang)
            --model:SetModelScale(v.size)
            local matrix = Matrix()
            matrix:Scale(v.size)
            model:EnableMatrix( "RenderMultiply", matrix )
            
            if (v.material == "") then
                model:SetMaterial("")
            elseif (model:GetMaterial() != v.material) then
                model:SetMaterial( v.material )
            end
            
            if (v.skin and v.skin != model:GetSkin()) then
                model:SetSkin(v.skin)
            end
            
            if (v.bodygroup) then
                for k, v in pairs( v.bodygroup ) do
                    if (model:GetBodygroup(k) != v) then
                        model:SetBodygroup(k, v)
                    end
                end
            end
            
            if (v.surpresslightning) then
                render.SuppressEngineLighting(true)
            end
            
            render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
            render.SetBlend(v.color.a/255)
            model:DrawModel()
            render.SetBlend(1)
            render.SetColorModulation(1, 1, 1)
            
            if (v.surpresslightning) then
                render.SuppressEngineLighting(false)
            end
            
        elseif (v.type == "Sprite" and sprite) then
            
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            render.SetMaterial(sprite)
            render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
            
        elseif (v.type == "Quad" and v.draw_func) then
            
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)
            
            cam.Start3D2D(drawpos, ang, v.size)
                v.draw_func( self )
            cam.End3D2D()

        end
        
    end
    
end

SWEP.wRenderOrder = nil
function SWEP:DrawWorldModel()
	if self.HideWorldModel then
		return
	end
    
	if not IsValid(self.Owner) then
		self:DrawModel()
		
		return
	end
	
    if (!self.WElements) then return end
    
    if (!self.wRenderOrder) then

        self.wRenderOrder = {}

        for k, v in pairs( self.WElements ) do
            if (v.type == "Model") then
                table.insert(self.wRenderOrder, 1, k)
            elseif (v.type == "Sprite" or v.type == "Quad") then
                table.insert(self.wRenderOrder, k)
            end
        end

    end
    
    if (IsValid(self.Owner)) then
        bone_ent = self.Owner
    else
        --when the weapon is dropped
        bone_ent = self
    end
    
    for k, name in pairs( self.wRenderOrder ) do
    
        local v = self.WElements[name]
        if (!v) then self.wRenderOrder = nil break end
        if (v.hide) then continue end
        
        local pos, ang
        
        if (v.bone) then
            pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
        else
            pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
        end
        
        if (!pos) then continue end
        
        local model = v.modelEnt
        local sprite = v.spriteMaterial
        
        if (v.type == "Model" and IsValid(model)) then

            model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)

            model:SetAngles(ang)
            --model:SetModelScale(v.size)
            local matrix = Matrix()
            matrix:Scale(v.size)
            model:EnableMatrix( "RenderMultiply", matrix )
            
            if (v.material == "") then
                model:SetMaterial("")
            elseif (model:GetMaterial() != v.material) then
                model:SetMaterial( v.material )
            end
            
            if (v.skin and v.skin != model:GetSkin()) then
                model:SetSkin(v.skin)
            end
            
            if (v.bodygroup) then
                for k, v in pairs( v.bodygroup ) do
                    if (model:GetBodygroup(k) != v) then
                        model:SetBodygroup(k, v)
                    end
                end
            end
            
            if (v.surpresslightning) then
                render.SuppressEngineLighting(true)
            end
            
            render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
            render.SetBlend(v.color.a/255)
            model:DrawModel()
            render.SetBlend(1)
            render.SetColorModulation(1, 1, 1)
            
            if (v.surpresslightning) then
                render.SuppressEngineLighting(false)
            end
            
        elseif (v.type == "Sprite" and sprite) then
            
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            render.SetMaterial(sprite)
            render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
            
        elseif (v.type == "Quad" and v.draw_func) then
            
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)
            
            cam.Start3D2D(drawpos, ang, v.size)
                v.draw_func( self )
            cam.End3D2D()

        end
        
    end
    
end

function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
    
    local bone, pos, ang
    if (tab.rel and tab.rel != "") then
        
        local v = basetab[tab.rel]
        
        if (!v) then return end
        
        --Technically, if there exists an element with the same name as a bone
        --you can get in an infinite loop. Let's just hope nobody's that stupid.
        pos, ang = self:GetBoneOrientation( basetab, v, ent )
        
        if (!pos) then return end
        
        pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
        ang:RotateAroundAxis(ang:Up(), v.angle.y)
        ang:RotateAroundAxis(ang:Right(), v.angle.p)
        ang:RotateAroundAxis(ang:Forward(), v.angle.r)
            
    else
    
        bone = ent:LookupBone(bone_override or tab.bone)

        if (!bone) then return end
        
        pos, ang = Vector(0,0,0), Angle(0,0,0)
        local m = ent:GetBoneMatrix(bone)
        if (m) then
            pos, ang = m:GetTranslation(), m:GetAngles()
        end
        
        if (IsValid(self.Owner) and self.Owner:IsPlayer() and
            ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
            ang.r = -ang.r --Fixes mirrored models
        end
    
    end
    
    return pos, ang
end

function SWEP:CreateModels( tab )

    if (!tab) then return end

    --Create the clientside models here because Garry says we can't do it in the render hook
    for k, v in pairs( tab ) do
        if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and
                string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
            
            v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
            if (IsValid(v.modelEnt)) then
                v.modelEnt:SetPos(self:GetPos())
                v.modelEnt:SetAngles(self:GetAngles())
                v.modelEnt:SetParent(self)
                v.modelEnt:SetNoDraw(true)
                v.createdModel = v.model
            else
                v.modelEnt = nil
            end
            
        elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite)
            and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
            
            local name = v.sprite.."-"
            local params = { ["$basetexture"] = v.sprite }
            --make sure we create a unique name based on the selected options
            local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
            for i, j in pairs( tocheck ) do
                if (v[j]) then
                    params["$"..j] = 1
                    name = name.."1"
                else
                    name = name.."0"
                end
            end

            v.createdSprite = v.sprite
            v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
            
        end
    end
    
end

local allbones
local hasGarryFixedBoneScalingYet = false

function SWEP:UpdateBonePositions(vm)
    
    if self.ViewModelBoneMods then
        
        if (!vm:GetBoneCount()) then return end
        
        --!! WORKAROUND !! --
        --We need to check all model names :/
        local loopthrough = self.ViewModelBoneMods
        if (!hasGarryFixedBoneScalingYet) then
            allbones = {}
            for i=0, vm:GetBoneCount() do
                local bonename = vm:GetBoneName(i)
                if (self.ViewModelBoneMods[bonename]) then
                    allbones[bonename] = self.ViewModelBoneMods[bonename]
                else
                    allbones[bonename] = {
                        scale = Vector(1,1,1),
                        pos = Vector(0,0,0),
                        angle = Angle(0,0,0)
                    }
                end
            end
            
            loopthrough = allbones
        end
        --!! -----------!! --
        
        for k, v in pairs( loopthrough ) do
            local bone = vm:LookupBone(k)
            if (!bone) then continue end
            
            --!! WORKAROUND !! --
            local s = Vector(v.scale.x,v.scale.y,v.scale.z)
            local p = Vector(v.pos.x,v.pos.y,v.pos.z)
            local ms = Vector(1,1,1)
            if (!hasGarryFixedBoneScalingYet) then
                local cur = vm:GetBoneParent(bone)
                while(cur >= 0) do
                    local pscale = loopthrough[vm:GetBoneName(cur)].scale
                    ms = ms * pscale
                    cur = vm:GetBoneParent(cur)
                end
            end
            
            s = s * ms
            --!! -----------!! --
            
            if vm:GetManipulateBoneScale(bone) != s then
                vm:ManipulateBoneScale( bone, s )
            end
            if vm:GetManipulateBoneAngles(bone) != v.angle then
                vm:ManipulateBoneAngles( bone, v.angle )
            end
            if vm:GetManipulateBonePosition(bone) != p then
                vm:ManipulateBonePosition( bone, p )
            end
        end
    else
        self:ResetBonePositions(vm)
    end
       
end
 
function SWEP:ResetBonePositions(vm)
    
    if (!vm:GetBoneCount()) then return end
    for i=0, vm:GetBoneCount() do
        vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
        vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
        vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
    end
    
end

function SWEP:DrawWeaponSelection(x, y, w, h, a)
	local size = math.min(w, h)
	
	surface.SetDrawColor(255, 255, 255, a)
	--surface.SetMaterial(self.SelectIcon)
	surface.DrawTexturedRect(x + w / 2 - size / 2, y, size, size)
end

--Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
--Does not copy entities of course, only copies their reference.
--WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
function table.FullCopy( tab )

    if (!tab) then return nil end
    
    local res = {}
    for k, v in pairs( tab ) do
        if (type(v) == "table") then
            res[k] = table.FullCopy(v) --recursion ho!
        elseif (type(v) == "Vector") then
            res[k] = Vector(v.x, v.y, v.z)
        elseif (type(v) == "Angle") then
            res[k] = Angle(v.p, v.y, v.r)
        else
            res[k] = v
        end
    end
    
    return res
    
end
