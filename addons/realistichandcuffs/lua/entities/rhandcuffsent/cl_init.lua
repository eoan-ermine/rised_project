-- "addons\\realistichandcuffs\\lua\\entities\\rhandcuffsent\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

net.Receive("rhc_sendcuffs", function()
	local Player, Cuffs = net.ReadEntity(), net.ReadEntity()
	
	Cuffs.CuffedPlayer = Player
end)

function ENT:Initialize()
	self.CSBoneMani = RHandcuffsConfig.BoneManipulateClientside
end

function ENT:Think ()	
end

function ENT:Draw()
	local owner = self.CuffedPlayer

	if owner == LocalPlayer() then return end	
	if !IsValid(owner) or !owner or !owner:IsPlayer() or !owner:Alive() then return end
	
	local boneindex = owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then
		local pos, ang = owner:GetBonePosition(boneindex)
		if pos and pos ~= owner:GetPos() then	

			ang:RotateAroundAxis(ang:Right(),25)
			ang:RotateAroundAxis(ang:Up(),0)
			ang:RotateAroundAxis(ang:Forward(),75)
				
			self:SetModelScale(1.2,0)
			
			if self.CSBoneMani then
				self.Entity:SetPos(pos + ang:Right()*6 + ang:Up()*0.5 + ang:Forward()*1)
			else
				self.Entity:SetPos(pos + ang:Right()*6 + ang:Up()*0.5 + ang:Forward()*1)	
			end
					
			self.Entity:SetAngles(ang)
		end
    end	
	self.Entity:DrawModel()
end

function ENT:OnRemove( )
end	
