-- "lua\\autorun\\zombine_playermodel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
list.Set( "PlayerOptionsModel", "zombie_soldier",		"models/player/zombine/combine_zombie.mdl" )
player_manager.AddValidModel( "zombie_soldier",		"models/player/zombine/combine_zombie.mdl" )
player_manager.AddValidHands("zombie_soldier", "models/player/zombine/combine_zombie.mdl", 0, "00000000")

if(CLIENT) then

local model = "models/player/zombine/combine_zombie.mdl"
local z_vec = Vector(0, 0, 0)
local p_vec = Vector(-100, -100, -100)

local timer = timer
local timer_id = "FixBonesTimer " .. model

local function SetBones()
	local ent = LocalPlayer()
	if(not IsValid(ent)) then return end
	
	ent = ent:GetHands()
	if(not IsValid(ent)) then return end
	
	if(ent:GetManipulateBoneScale(0) == z_vec) then return end
	
	for i = 0, 15 do
		ent:ManipulateBoneScale(i, z_vec)
		ent:ManipulateBonePosition(i, p_vec)
	end
end

local function SetBoneWatch(ent)
	if(not IsValid(ent)) then print("OnEntityCreated didn't return a valid entity!") return end
	if(ent:GetClass() ~= "gmod_hands") then return end
	
	local enabled = timer.Exists(timer_id)
	local isthemodel = ent:GetModel() == model

	if(not enabled and isthemodel) then
		timer.Create(timer_id, 0.5, 0, SetBones)
	elseif(enabled and not isthemodel) then
		timer.Destroy(timer_id)
	end
	
	if(isthemodel) then
		SetBones()
	end
end

hook.Add("OnEntityCreated", "Setup Hands Model " .. model, SetBoneWatch)

end









