-- "addons\\rised_notepad_system\\lua\\weapons\\weapon_notepad\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

if CLIENT then
SWEP.PrintName			= "Документ"			
SWEP.Slot				= 3
SWEP.SlotPos			= 14
SWEP.DrawCrosshair		= false
end

SWEP.Author = "D-Rised";
SWEP.Contact = "";
SWEP.Instructions	= "Левый клик - прочитать.   Правый клик - закрыть."
SWEP.Category = "A - Rised - [Гражданское]"

SWEP.ViewModel		= "models/props_lab/clipboard.mdl"
SWEP.WorldModel		= "models/props_lab/clipboard.mdl"

SWEP.Weight				= 0.2
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "normal"
SWEP.AnimPrefix = "normal"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Notepad_ID = -1

function SWEP:Initialize()
	self:SetHoldType( "normal" )
end

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 2, "NextSoundTime")
end

function SWEP:Holster()
	self:SetNWBool('PlaceMode', false)
	if CLIENT then
		if IsValid(LocalPlayer()) then
   	   		local Viewmodel = LocalPlayer():GetViewModel()

			if IsValid(Viewmodel) then
				Viewmodel:SetMaterial("")
			end
		end
	end
	return true
end


local canOpen = false
function SWEP:PrimaryAttack()
    if CLIENT then
        if self:GetNWBool('PlaceMode') then return end
        if canOpen == false then
            canOpen = true
            
                net.Start("Risednotepad-Server")
                net.WriteEntity(self)
                net.WriteInt(1,10)
                net.SendToServer()
                
            timer.Simple(1, function() canOpen = false end)
        end
    elseif self:GetNWBool("PlaceMode") and !self.Dropped then
		if self.Owner:GetPos():DistToSqr(self.Owner:GetEyeTrace().HitPos) > 8000 then return end
		self.Dropped = true
		self:Remove()
		local ent = ents.Create("spawned_weapon")

		if self:GetNWInt("ID") > 0 then
			ent.Notepad_ID = self:GetNWInt("ID")
		end
		local ang = self.Owner:GetAngles()
		ang.p = 90
		ang.r = 180
		ent:SetPos(self.Owner:GetEyeTrace().HitPos)
		ent:SetCollisionGroup(15)
		ent:SetModel('models/props_lab/clipboard.mdl')
		ent:SetWeaponClass(self:GetClass())
		ent:SetAngles(ang + Angle(0,0,0))
		ent.nodupe = true
		ent:Spawn()
		local phys = ent:GetPhysicsObject()
		phys:EnableMotion(false)
	end
    
    self:SetNextPrimaryFire(CurTime() + 1)
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + .5)
	self:SetNWBool("PlaceMode", !self:GetNWBool('PlaceMode'))
end


if CLIENT then
surface.CreateFont('yesfont', {font = 'Marske', size = 10, weight = 0, extended = true})

function SWEP:DrawHUD()
	if !self:GetNWBool("PlaceMode") then return end
	if self.Owner:GetPos():DistToSqr(self.Owner:GetEyeTrace().HitPos) > 8000 then return end

	local tr = self.Owner:GetEyeTrace()

	local pos = tr.HitPos
	pos.z = pos.z - 5

	local ang = self.Owner:GetAngles()
	ang.p = 0
	ang.r = 0

	cam.Start3D()
		render.DrawWireframeBox( pos, ang, Vector(0,0,0),Vector(1,7,10) )
	cam.End3D()

end

local fr
concommand.Add('tobeornottobe', function(p,_,a)
	local note = Entity(a[1])
	if fr then return end
	fr = vgui.Create('DButton')
	fr.Paint = function() end
	fr:SetText ''
	fr:SetSize(ScrW(), ScrH())
	fr:SetPos(0,0)
	fr.DoClick = function()
		fr:Remove() fr = nil
	end
	
	frbtn = vgui.Create('DFrame', fr)
	frbtn:MakePopup()
	frbtn:SetTitle('')
	frbtn.Paint = function(s,w,h)
		draw.RoundedBox(32,0,0,w,h,Color(35, 35, 35))
	end
	frbtn:SetSize(250,30)
	frbtn:Center()
	frbtn:ShowCloseButton(false)


	frbtn.yes = vgui.Create("DButton", frbtn)
	frbtn.yes:SetSize(frbtn:GetWide() / 2 - 10, 20)
	frbtn.yes:SetPos(5, frbtn:GetTall() - 25)
	frbtn.yes:SetText ''
	frbtn.yes.Paint = function(s,w,h)
		draw.RoundedBox(32,0,0,w,h,Color(0, 184, 148))

		draw.SimpleText('Прочитать', 'yesfont', w/2, h/2, s.Hovered and Color(223, 230, 233) or Color(45, 52, 54), 1,1)
	end

	frbtn.yes.DoClick = function(s)
		net.Start("Risednotepad-Server")
		net.WriteEntity(note)
		net.WriteInt(1,10)
		net.SendToServer()
		fr:Remove() fr = nil
	end

	frbtn.no = vgui.Create("DButton", frbtn)
	frbtn.no:SetSize(frbtn:GetWide() / 2 - 10, 20)
	frbtn.no:SetPos(frbtn:GetWide() / 2 +5, frbtn:GetTall() - 25)
	frbtn.no:SetText ''
	frbtn.no.Paint = function(s,w,h)
		draw.RoundedBox(32,0,0,w,h,Color(225, 112, 85))
		draw.SimpleText('Взять в руки', 'yesfont', w/2, h/2, s.Hovered and Color(223, 230, 233) or Color(45, 52, 54), 1,1)
	end
	frbtn.no.DoClick = function(s)
		RunConsoleCommand('givenote', a[1])
		fr:Remove() fr = nil
	end
end)

net.Receive("Risednotepad-Client", function(len, ply)
	
	local what = net.ReadInt(10)

	if what == 1 then
	
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 600, 825 )
		frame:Center()
		frame:MakePopup()
		frame:SetTitle("Документ")
		frame.Paint = function(s,w,h)
			draw.RoundedBox(1,0,0,w,h,Color(255,255,255, 190))
			--draw.RoundedBox(1,0,0,w,25,Color(255, 195, 87, 255))
			draw.RoundedBox(1,0,0,w,25,Color(35, 35, 35, 255))
		end
		
		local TextEntry = vgui.Create( "DTextEntry", frame )
		TextEntry:SetPos( 5, 30 )
		TextEntry:SetSize( 590, 765 )
		TextEntry:SetValue( "" )
		TextEntry:SetMultiline( true )
		TextEntry:SetUpdateOnType( true )
		TextEntry.OnValueChange = function()
			if string.len(TextEntry:GetValue()) < 4096 then
				local binary = util.Compress(TextEntry:GetValue())
				net.Start("Risednotepad-Server")
				net.WriteEntity(LocalPlayer():GetActiveWeapon())
				net.WriteInt(2,10)
				net.WriteInt(#binary, 32)
				net.WriteData(binary, #binary)
				net.SendToServer()
			end
		end
		
		local button01 = vgui.Create("DButton", frame)
		button01:SetText("Подписать")
		button01:SetSize(150,30)
		button01:SetPos(125, 795)
		button01.Paint = function(me, w, h)
			draw.RoundedBoxEx(0, 0, 0, w, h, Color(255, 255, 255, 145), false, true, false, false)
			if (me.Hovered) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 195, 87, 255), false, true, false, false)
			end

			if (me:IsDown()) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(0, 0, 0, 255), false, true, false, false)
			end
		end
		button01.DoClick = function()
			frame:Close()
			net.Start("Risednotepad-Server")
			net.WriteEntity(LocalPlayer():GetActiveWeapon())
			net.WriteInt(3,10)
			net.SendToServer()
		end
		
		local button02 = vgui.Create("DButton", frame)
		button02:SetText("Разорвать")
		button02:SetSize(150,30)
		button02:SetPos(325, 795)
		button02.Paint = function(me, w, h)
			draw.RoundedBoxEx(0, 0, 0, w, h, Color(255, 255, 255, 145), false, true, false, false)
			if (me.Hovered) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 195, 87, 255), false, true, false, false)
			end

			if (me:IsDown()) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(0, 0, 0, 255), false, true, false, false)
			end
		end
		button02.DoClick = function()
			frame:Close()
			net.Start("Risednotepad-Server")
			net.WriteEntity(LocalPlayer():GetActiveWeapon())
			net.WriteInt(4,10)
			net.SendToServer()
		end
		
	elseif what == 2 then
		local netlenth = net.ReadInt(32)
		local fileData = net.ReadData(netlenth)
		local text = util.Decompress(fileData)
		local iseditable = net.ReadBool()
		
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 600, 825 )
		frame:Center()
		frame:MakePopup()
		frame:SetTitle("Документ")
		frame.Paint = function(s,w,h)
			draw.RoundedBox(1,0,0,w,h,Color(255,255,255, 190))
			draw.RoundedBox(1,0,0,w,25,Color(35, 35, 35, 255))
		end
		
		local locked = string.StartWith(text, "[lock]")
		
		if locked then
			text = string.Replace(text, "[lock]", "")
		end
		
		local TextEntry = vgui.Create( "DTextEntry", frame )
		TextEntry:SetPos( 5, 30 )
		TextEntry:SetSize( 590, 765 )
		TextEntry:SetValue( text )
		TextEntry:SetEditable( iseditable )
		TextEntry:SetMultiline( true )
		TextEntry:SetUpdateOnType( true )
		TextEntry.OnValueChange = function()
			if string.len(TextEntry:GetValue()) < 4096 then
				local binary = util.Compress(TextEntry:GetValue())
				net.Start("Risednotepad-Server")
				net.WriteEntity(LocalPlayer():GetActiveWeapon())
				net.WriteInt(2,10)
				net.WriteInt(#binary, 32)
				net.WriteData(binary, #binary)
				net.SendToServer()
			end
		end
		if !iseditable then return end
		local button01 = vgui.Create("DButton", frame)
		button01:SetText("Подписать")
		button01:SetSize(150,30)
		button01:SetPos(125, 795)
		button01.Paint = function(me, w, h)
			draw.RoundedBoxEx(0, 0, 0, w, h, Color(255, 255, 255, 145), false, true, false, false)
			if (me.Hovered) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 195, 87, 255), false, true, false, false)
			end

			if (me:IsDown()) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(0, 0, 0, 255), false, true, false, false)
			end
		end
		button01.DoClick = function()
			
			frame:Close()
			net.Start("Risednotepad-Server")
			net.WriteEntity(LocalPlayer():GetActiveWeapon())
			net.WriteInt(3,10)
			net.SendToServer()
		end
		
		local button02 = vgui.Create("DButton", frame)
		button02:SetText("Разорвать")
		button02:SetSize(150,30)
		button02:SetPos(325, 795)
		button02.Paint = function(me, w, h)
			draw.RoundedBoxEx(0, 0, 0, w, h, Color(255, 255, 255, 145), false, true, false, false)
			if (me.Hovered) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 195, 87, 255), false, true, false, false)
			end

			if (me:IsDown()) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(0, 0, 0, 255), false, true, false, false)
			end
		end
		button02.DoClick = function()
			frame:Close()
			net.Start("Risednotepad-Server")
			net.WriteEntity(LocalPlayer():GetActiveWeapon())
			net.WriteInt(4,10)
			net.SendToServer()
		end
		
	end

end)

function SWEP:GetViewModelPosition(vPos, aAngles)
	vPos = vPos + LocalPlayer():GetUp() * -10
	vPos = vPos + LocalPlayer():GetAimVector() * 20
	vPos = vPos + LocalPlayer():GetRight() * 8
	aAngles:RotateAroundAxis(aAngles:Right(), 90)
	aAngles:RotateAroundAxis(aAngles:Forward(), 0)
	aAngles:RotateAroundAxis(aAngles:Up(), 180)
	
	return vPos, aAngles
end

function SWEP:OnRemove()
	if !IsValid(LocalPlayer()) or !IsValid(self.Owner) then return end
    local Viewmodel = self.Owner:GetViewModel()

	if IsValid(Viewmodel) then
		Viewmodel:SetMaterial("")
	end
end

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.5 + HAng:Forward() * 7 + HAng:Up() * 0.518

		HAng:RotateAroundAxis(HAng:Right(), 10)
		HAng:RotateAroundAxis(HAng:Forward(),  90)
		HAng:RotateAroundAxis(HAng:Up(), 80)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:SetMaterial("models/props_lab/clipboard.mdl")
		self:DrawModel()
	end
end

end
