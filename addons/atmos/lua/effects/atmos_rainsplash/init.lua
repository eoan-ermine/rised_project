-- "addons\\atmos\\lua\\effects\\atmos_rainsplash\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

function EFFECT:Init( data )

	local em = ParticleEmitter( data:GetOrigin() );

	if ( em ) then

		local p = em:Add( "atmos/warp_ripple3", data:GetOrigin() );

		p:SetDieTime( 0.5 );
		p:SetStartAlpha( 200 );
		p:SetEndAlpha( 0 );
		p:SetStartSize( 4 );
		p:SetEndSize( 4 );
		p:SetColor( 255, 255, 255 );

		em:Finish();

	end

end

function EFFECT:Think()

	return false;

end

function EFFECT:Render() end
