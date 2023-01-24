-- "addons\\rised_animations\\lua\\autorun\\ra_swep_thinker.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
Only allowed to use in Addons by
​Mattis 'Mattzimann' Krämer
]]--

AddCSLuaFile()

AnimationSWEP = {}

if CLIENT then
    AnimationSWEP.GestureAngles = {}

    local function applyAnimation(ply, targetValue, class)
        if not IsValid(ply) then return end
        if ply.animationSWEPAngle ~= targetValue then
            ply.animationSWEPAngle = Lerp(FrameTime() * 5, ply.animationSWEPAngle, targetValue)
        end

        local oldanimationclass = ply:GetNWString("oldanimationClass")
        if oldanimationclass ~= class and AnimationSWEP.GestureAngles[oldanimationclass] then
        	for boneName, angle in pairs(AnimationSWEP.GestureAngles[oldanimationclass]) do
            local bone = ply:LookupBone(boneName)

            if bone then
                ply:ManipulateBoneAngles( bone, angle * 0)
            end
       		end
        end

       	ply:SetNWString("oldanimationClass",class)

       if AnimationSWEP.GestureAngles[class] then
        for boneName, angle in pairs(AnimationSWEP.GestureAngles[class]) do
            local bone = ply:LookupBone(boneName)

            if bone then
                ply:ManipulateBoneAngles( bone, angle * ply.animationSWEPAngle)
            end
        end
   		end

        if math.Round(ply.animationSWEPAngle, 2) == targetValue and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() ~= class then
            ply:SetNWString("animationClass", "")
        end
    end

    hook.Add("Think", "AnimationSWEP.Think", function ()
       	for _, ply in pairs( player.GetHumans() ) do
            local animationClass = ply:GetNWString("animationClass")

            if animationClass ~= "" then
                if not ply.animationSWEPAngle then
                    ply.animationSWEPAngle = 0
                end

                if ply:GetNWBool("animationStatus") then
                    applyAnimation(ply, 1, animationClass)
                else
                    applyAnimation(ply, 0, animationClass)
                end
            end

    		
    	end
	end)
else

	local function VelocityIsHigher(ply, value)
		local x, y, z = math.abs(ply:GetVelocity().x), math.abs(ply:GetVelocity().y), math.abs(ply:GetVelocity().z)
		if x > value or y > value or z > value then
			return true
		else
			return false
		end
	end

    hook.Add("SetupMove", "AnimationSWEP.SetupMove", function(ply, moveData, cmd)
        if ply:GetNWBool("animationStatus") then
        	local deactivateOnMove = ply:GetNWInt("deactivateOnMove", 5)
        	
	            if VelocityIsHigher(ply, deactivateOnMove) then
	                AnimationSWEP:Toggle(ply, false)
	            end

	            if ply:KeyDown(IN_DUCK) then
	                AnimationSWEP:Toggle(ply, false)
	            end

	            if ply:KeyDown(IN_USE) then
	                AnimationSWEP:Toggle(ply, false)
	            end

	            if ply:KeyDown(IN_JUMP) then
	                AnimationSWEP:Toggle(ply, false)
	            end
        end
    end)

    function AnimationSWEP:Toggle(ply, crossing, class, deactivateOnMove)
        if crossing then
            ply:SetNWBool("animationStatus", true)
            
            if class then
                ply:SetNWString("animationClass", class)
            end
            
            ply:SetNWInt("deactivateOnMove", deactivateOnMove)
        else
            ply:SetNWBool("animationStatus", false)
            ply:SetNWInt("deactivateOnMove", 5)
        end
    end
end