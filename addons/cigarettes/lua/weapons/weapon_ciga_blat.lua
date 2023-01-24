-- "addons\\cigarettes\\lua\\weapons\\weapon_ciga_blat.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-- Cigarette SWEP by Mordestein (based on Vape SWEP by Swamp Onions)

if CLIENT then
	include('weapon_ciga/cl_init.lua')
else
	include('weapon_ciga/shared.lua')
end

SWEP.PrintName = "Capitain Black"

SWEP.Instructions = "LMB : kurit kak blatnoy"

SWEP.cigaAccentColor = nil

SWEP.cigaID = 4
SWEP.ViewModel = "models/mordeciga/mordes/ciga.mdl"
SWEP.WorldModel = "models/mordeciga/mordes/ciga.mdl"

--Add your own flavors here, obviously
JuicycigaJuices = {
	{name = "witout filter", color = Color(40,40,40,255)},
	{name = "with filter", color = Color(210,180,140,255)},
}

if SERVER then
	function SWEP:Initialize2()
		self.juiceID = 0
		timer.Simple(0.1, function() SendcigaJuice(self, JuicycigaJuices[self.juiceID+1]) end)
	end

	util.AddNetworkString("cigaTankColor")
	util.AddNetworkString("cigaMessage")
end

function SWEP:SecondaryAttack()
	if SERVER then
		if not self.juiceID then self.juiceID = 0 end
		self.juiceID = (self.juiceID + 1) % (#JuicycigaJuices)
		SendcigaJuice(self, JuicycigaJuices[self.juiceID+1])

		--Client hook isn't called in singleplayer
		if game.SinglePlayer() then	self.Owner:SendLua([[surface.PlaySound("weapons/smg1/switch_single.wav")]]) end
	else
		if IsFirstTimePredicted() then
			surface.PlaySound("weapons/smg1/switch_single.wav")
		end
	end
end

if SERVER then
	function SendcigaJuice(ent, tab)
		local col = tab.color
		if col then
			local min = math.min(col.r,col.g,col.b)*0.8
			col = (Vector(col.r-min, col.g-min, col.b-min)*1.0)/255.0
		else
			col = Vector(-1,-1,-1)
		end
		net.Start("cigaTankColor")
		net.WriteEntity(ent)
		net.WriteVector(col)
		net.Broadcast()

		if IsValid(ent.Owner) then
			net.Start("cigaMessage")
			net.WriteString("Loaded "..tab.name.."")
			net.Send(ent.Owner)
		end
	end
else
	net.Receive("cigaTankColor", function()
		local ent = net.ReadEntity()
		local col = net.ReadVector()
		if IsValid(ent) then ent.cigaTankColor = col end
	end)

	cigaMessageDisplay = ""
	cigaMessageDisplayTime = 0

	net.Receive("cigaMessage", function()
		cigaMessageDisplay = net.ReadString()
		cigaMessageDisplayTime = CurTime()
	end)

	hook.Add("HUDPaint", "cigaDrawJuiceMessage", function()
		local alpha = math.Clamp((cigaMessageDisplayTime+3-CurTime())*1.5,0,1)
		if alpha == 0 then return end

		surface.SetFont("Trebuchet24")
		local w,h = surface.GetTextSize(cigaMessageDisplay)
		draw.WordBox(8, ((ScrW() - w)/2)-8, ScrH() - (h + 24), cigaMessageDisplay, "Trebuchet24", Color(0,0,0,128*alpha), Color(255,255,255,255*alpha))
	end)
end