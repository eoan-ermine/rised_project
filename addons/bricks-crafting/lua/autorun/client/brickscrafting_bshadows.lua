-- "addons\\bricks-crafting\\lua\\autorun\\client\\brickscrafting_bshadows.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--This code can be improved a lot.
--Feel free to improve, use or modify in any way although credit would be appreciated.

--Global table
if BCS_BSHADOWS == nil then
BCS_BSHADOWS = {}

--The original drawing layer
BCS_BSHADOWS.RenderTarget = GetRenderTarget("bshadows_original", ScrW(), ScrH())

--The shadow layer
BCS_BSHADOWS.RenderTarget2 = GetRenderTarget("bshadows_shadow",  ScrW(), ScrH())

--The matarial to draw the render targets on
BCS_BSHADOWS.ShadowMaterial = CreateMaterial("bshadows","UnlitGeneric",{
	["$translucent"] = 1,
	["$vertexalpha"] = 1,
	["alpha"] = 1
})

--When we copy the rendertarget it retains color, using this allows up to force any drawing to be black
--Then we can blur it to create the shadow effect
BCS_BSHADOWS.ShadowMaterialGrayscale = CreateMaterial("bshadows_grayscale","UnlitGeneric",{
	["$translucent"] = 1,
	["$vertexalpha"] = 1,
	["$alpha"] = 1,
	["$color"] = "0 0 0",
	["$color2"] = "0 0 0"
})

--Call this to begin drawing a shadow
BCS_BSHADOWS.BeginShadow = function( AreaX, AreaY, AreaEndX, AreaEndY )
	--Set the render target so all draw calls draw onto the render target instead of the screen
	render.PushRenderTarget(BCS_BSHADOWS.RenderTarget)

	--Clear is so that theres no color or alpha
	render.OverrideAlphaWriteEnable(true, true)
	render.Clear(0,0,0,0)
	render.OverrideAlphaWriteEnable(false, false)

	if( AreaX and AreaY and AreaEndX and AreaEndY ) then
		render.SetScissorRect( AreaX, AreaY, AreaEndX, AreaEndY, true )
	end

	--Start Cam2D as where drawing on a flat surface 
	cam.Start2D()

	--Now leave the rest to the user to draw onto the surface
end

--This will draw the shadow, and mirror any other draw calls the happened during drawing the shadow
BCS_BSHADOWS.EndShadow = function(intensity, spread, blur, opacity, direction, distance, _shadowOnly)
	--Set default opcaity
	opacity = opacity or 255
	direction = direction or 0
	distance = distance or 0
	_shadowOnly = _shadowOnly or false

	--Copy this render target to the other
	render.CopyRenderTargetToTexture(BCS_BSHADOWS.RenderTarget2)

	--Blur the second render target
	if blur > 0 then
		render.OverrideAlphaWriteEnable(true, true)
		render.BlurRenderTarget(BCS_BSHADOWS.RenderTarget2, spread, spread, blur)
		render.OverrideAlphaWriteEnable(false, false) 
	end

	--First remove the render target that the user drew
	render.PopRenderTarget()

	--Now update the material to what was drawn
	BCS_BSHADOWS.ShadowMaterial:SetTexture('$basetexture', BCS_BSHADOWS.RenderTarget)

	--Now update the material to the shadow render target
	BCS_BSHADOWS.ShadowMaterialGrayscale:SetTexture('$basetexture', BCS_BSHADOWS.RenderTarget2)

	--Work out shadow offsets
	local xOffset = math.sin(math.rad(direction)) * distance 
	local yOffset = math.cos(math.rad(direction)) * distance

	--Now draw the shadow
	BCS_BSHADOWS.ShadowMaterialGrayscale:SetFloat("$alpha", opacity/255) --set the alpha of the shadow
	render.SetMaterial(BCS_BSHADOWS.ShadowMaterialGrayscale)
	for i = 1 , math.ceil(intensity) do
		render.DrawScreenQuadEx(xOffset, yOffset, ScrW(), ScrH())
	end

	if not _shadowOnly then
		--Now draw the original
		BCS_BSHADOWS.ShadowMaterial:SetTexture('$basetexture', BCS_BSHADOWS.RenderTarget)
		render.SetMaterial(BCS_BSHADOWS.ShadowMaterial)
		render.DrawScreenQuad()
	end

	cam.End2D()

	render.SetScissorRect( 0, 0, 0, 0, false )
end

--This will draw a shadow based on the texture you passed it.
BCS_BSHADOWS.DrawShadowTexture = function(texture, intensity, spread, blur, opacity, direction, distance, shadowOnly)

	--Set default opcaity
	opacity = opacity or 255
	direction = direction or 0
	distance = distance or 0
	shadowOnly = shadowOnly or false

	--Copy the texture we wish to create a shadow for to the shadow render target
	render.CopyTexture(texture, BCS_BSHADOWS.RenderTarget2)

	--Blur the second render target
	if blur > 0 then
		render.PushRenderTarget(BCS_BSHADOWS.RenderTarget2)
		render.OverrideAlphaWriteEnable(true, true)
		render.BlurRenderTarget(BCS_BSHADOWS.RenderTarget2, spread, spread, blur)
		render.OverrideAlphaWriteEnable(false, false) 
		render.PopRenderTarget()
	end

	--Now update the material to the shadow render target
	BCS_BSHADOWS.ShadowMaterialGrayscale:SetTexture('$basetexture', BCS_BSHADOWS.RenderTarget2)

	--Work out shadow offsets
	local xOffset = math.sin(math.rad(direction)) * distance 
	local yOffset = math.cos(math.rad(direction)) * distance

	--Now draw the shadow 
	BCS_BSHADOWS.ShadowMaterialGrayscale:SetFloat("$alpha", opacity/255) --Set the alpha
	render.SetMaterial(BCS_BSHADOWS.ShadowMaterialGrayscale)
	for i = 1 , math.ceil(intensity) do
		render.DrawScreenQuadEx(xOffset, yOffset, ScrW(), ScrH())
	end
	if not shadowOnly then
		--Now draw the original
		BCS_BSHADOWS.ShadowMaterial:SetTexture('$basetexture', texture)
		render.SetMaterial(BCS_BSHADOWS.ShadowMaterial)
		render.DrawScreenQuad()
	end
end
end