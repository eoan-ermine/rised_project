-- "addons\\rised_bonemerge_works\\lua\\autorun\\rbw_bonemerge.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
RandomBonemerge_Torso = {
	'models/clothes/male/male_torso_beta.mdl',
	'models/clothes/male/male_torso_beta2.mdl',
	'models/clothes/male/male_torso_black_jacket.mdl',
	'models/clothes/male/male_torso_blue_dress_shirt.mdl',
	'models/clothes/male/male_torso_blue_jacket.mdl',
	'models/clothes/male/male_torso_brownsuit.mdl',
	'models/clothes/male/male_torso_medic_2.mdl',
	'models/clothes/male/male_torso_medic_6.mdl',
	'models/clothes/male/male_torso_white_dress_shirt.mdl',
	'models/clothes/male/male_vest_rebel.mdl',
	'models/clothes/male/male_torso_refugee_3.mdl',
}

RandomBonemerge_Hands = {
	'models/clothes/male/male_hands_black.mdl',
	'models/clothes/male/male_hands_glove_fingerless_black.mdl',
	'models/clothes/male/male_hands_glove_fingerless_white.mdl',
}

RandomBonemerge_Legs = {
	'models/clothes/male/male_legs_cwu.mdl',
	'models/clothes/male/male_legs_medic.mdl',
	'models/clothes/male/male_legs_loyalist.mdl',
	'models/clothes/male/male_legs_overwatch.mdl',
	'models/clothes/male/male_legs_rebel_1.mdl',
	'models/clothes/male/male_legs_rebel_3.mdl',
}

RandomBonemerge_Random = {
	'models/clothes/male/male_pouch_1.mdl',
	'models/clothes/male/male_satchel_1.mdl',
	'models/clothes/male/male_bag_1.mdl',
	'models/clothes/male/male_badge_1.mdl',
	'models/clothes/male/male_armband_lambda.mdl',
}

hook.Add("PlayerLoadout", "Rised_Bonemerge_PlayerLoadout", function(ply)
	if ply:Team() == TEAM_TESTER then

		constraint.RemoveConstraints( ply, "EasyBonemerge" )
		constraint.RemoveConstraints( ply, "EasyBonemergeParent" )

		ply:SetModel("models/heads/rised_male_07.mdl")

		
		local bonemerge = ents.Create("prop_effect")
		bonemerge:SetModel(table.Random(RandomBonemerge_Torso))
		bonemerge:SetPos(ply:GetPos())
		bonemerge:Spawn()
		ApplyBonemerge(bonemerge, ply)

		local bonemerge = ents.Create("prop_effect")
		bonemerge:SetModel(table.Random(RandomBonemerge_Hands))
		bonemerge:SetPos(ply:GetPos())
		bonemerge:Spawn()
		ApplyBonemerge(bonemerge, ply)

		local bonemerge = ents.Create("prop_effect")
		bonemerge:SetModel(table.Random(RandomBonemerge_Legs))
		bonemerge:SetPos(ply:GetPos())
		bonemerge:Spawn()
		ApplyBonemerge(bonemerge, ply)

		for i=0, 20 do
			local bonemerge = ents.Create("prop_effect")
			bonemerge:SetModel(table.Random(RandomBonemerge_Random))
			bonemerge:SetPos(ply:GetPos())
			bonemerge:Spawn()
			ApplyBonemerge(bonemerge, ply)
		end
		
		-- undo.Create( "bonemerge" )
		-- 	undo.AddEntity( newEntity )
		-- 	undo.SetPlayer( ply:GetOwner() )
		-- undo.Finish()

	end
end)

if SERVER then

	hook.Add("ShowSpare1", "Rised_Bonemerge_Remove", function(ply, ent)
		constraint.RemoveConstraints( ply, "EasyBonemerge" )
		constraint.RemoveConstraints( ply, "EasyBonemergeParent" )
	end)

	function ApplyBonemerge(ent, selectedEnt)
		local oldent = ent
		if ( IsValid( ent ) && ent:GetClass() == "prop_effect" ) then oldent = ent.AttachedEntity end
		
		local newEntity = ReplaceEntity( oldent )
	
		constraint_EasyBonemerge( selectedEnt, newEntity )
		CheckForBonemerges( oldent, newEntity )
		CheckForWelds( oldent, newEntity )
	
		ent:Remove()
	
		return newEntity
	end
	
	function ReplaceEntity( oldent )
		
		local newEntity = ents.Create( "ent_bonemerged" )
		newEntity:SetModel( oldent:GetModel() )
		newEntity:SetSkin( oldent:GetSkin() || 0 )
		if ( oldent:GetFlexScale() != newEntity:GetFlexScale() ) then newEntity:SetFlexScale( oldent:GetFlexScale() ) end -- Don't create unnecessary entities
		if ( oldent:GetNumBodyGroups() ) then
			for id = 0, oldent:GetNumBodyGroups() - 1 do newEntity:SetBodygroup( id, oldent:GetBodygroup( id ) ) end
		end
		for i = 0, oldent:GetFlexNum() - 1 do newEntity:SetFlexWeight( i, oldent:GetFlexWeight( i ) ) end
		for i = 0, oldent:GetBoneCount() do
			if ( oldent:GetManipulateBoneScale( i ) != newEntity:GetManipulateBoneScale( i ) ) then newEntity:ManipulateBoneScale( i, oldent:GetManipulateBoneScale( i ) ) end
			if ( oldent:GetManipulateBoneAngles( i ) != newEntity:GetManipulateBoneAngles( i ) ) then newEntity:ManipulateBoneAngles( i, oldent:GetManipulateBoneAngles( i ) ) end
			if ( oldent:GetManipulateBonePosition( i ) != newEntity:GetManipulateBonePosition( i ) ) then newEntity:ManipulateBonePosition( i, oldent:GetManipulateBonePosition( i ) ) end
			if ( oldent:GetManipulateBoneJiggle( i ) != newEntity:GetManipulateBoneJiggle( i ) ) then newEntity:ManipulateBoneJiggle( i, oldent:GetManipulateBoneJiggle( i ) ) end
		end

		newEntity:Spawn()

		newEntity.EntityMods = oldent.EntityMods
		newEntity.BoneMods = oldent.BoneMods

		duplicator.ApplyEntityModifiers( nil, newEntity )
		duplicator.ApplyBoneModifiers( nil, newEntity )

		return newEntity
	end

	function CheckForBonemerges( oldent, newent )
		for id, ent in pairs( ents.GetAll() ) do
			if ( ent:GetParent() == oldent && ent:GetClass() == "ent_bonemerged" && !ent.LocalPos ) then
				ApplyBonemerge( ent, newent )
			end
		end
	end

	function CheckForWelds( ent, parent )
		if ( !constraint.HasConstraints( ent ) ) then return end

		for _, v in pairs( constraint.GetAllConstrainedEntities( ent ) ) do
			if ( v == ent ) then continue end
			if ( constraint.FindConstraint( v, "EasyBonemergeParent" ) ) then continue end

			local oldent = v
			if ( IsValid( v ) && v:GetClass() == "prop_effect" ) then oldent = v.AttachedEntity end

			local newEntity = ReplaceEntity( oldent )

			newEntity.LocalPos = ent:WorldToLocal( v:GetPos() )
			newEntity.LocalAng = ent:WorldToLocalAngles( v:GetAngles() )

			constraint_EasyBonemergeParent( parent, newEntity )

			v:Remove()
		end
	end

	function constraint_EasyBonemerge( ent_parent, Ent2, EntityMods, BoneMods )
		if ( !IsValid( ent_parent ) ) then MsgN( "Easy Bonemerge Tool: Your dupe/save is missing the target entity, cannot apply bonemerged props!" ) return end
		if ( !IsValid( Ent2 ) ) then MsgN( "Easy Bonemerge Tool: Your dupe/save is missing the bonemerged prop, cannot restore bonemerged prop!" ) return end

		Ent2:SetParent( ent_parent, 0 )
		if ( IsValid( ent_parent ) && ent_parent:GetClass() == "prop_effect" ) then
			Ent2:SetParent( ent_parent.AttachedEntity, 0 )
			-- A horrible hack, but necessary
			ent_parent.PhysicsUpdate = Ent2.PhysicsUpdatePatch
		end

		-- I don't remember why I put these here
		Ent2:SetMoveType( MOVETYPE_NONE )
		Ent2:SetSolid( SOLID_NONE )
		Ent2:SetLocalPos( Vector( 0, 0, 0 ) )
		Ent2:SetLocalAngles( Angle( 0, 0, 0 ) )

		Ent2:AddEffects( EF_BONEMERGE )
		--Ent2:Fire( "SetParentAttachment", ent_parent:GetAttachments()[1].name )

		constraint.AddConstraintTable( ent_parent, Ent2, Ent2 )

		Ent2:SetTable( {
			Type = "EasyBonemerge",
			Ent1 = ent_parent,
			Ent2 = Ent2,
			EntityMods = EntityMods || Ent2.EntityMods,
			BoneMods = BoneMods || Ent2.BoneMods
		} )

		duplicator.ApplyEntityModifiers( nil, Ent2 )
		duplicator.ApplyBoneModifiers( nil, Ent2 )

		ent_parent:DeleteOnRemove( Ent2 )

		return Ent2
	end
	duplicator.RegisterConstraint( "EasyBonemerge", constraint_EasyBonemerge, "Ent1", "Ent2", "EntityMods", "BoneMods" )

	function constraint_EasyBonemergeParent( Ent1, Ent2, LocalPos, LocalAng, EntityMods, BoneMods )
		if ( !IsValid( Ent1 ) ) then MsgN( "Easy Bonemerge Tool: Your dupe/save is missing parent target entity, cannot apply bonemerged props!" ) return end
		if ( !IsValid( Ent2 ) ) then MsgN( "Easy Bonemerge Tool: Your dupe/save is missing parent bonemerged prop, cannot restore bonemerged prop!" ) return end

		Ent2:SetParent( Ent1, 0 )
		if ( IsValid( Ent1 ) && Ent1:GetClass() == "prop_effect" ) then Ent2:SetParent( Ent1.AttachedEntity, 0 ) end

		Ent2.BoneMergeParent = true

		Ent2:SetLocalPos( LocalPos || Ent2.LocalPos )
		Ent2:SetLocalAngles( LocalAng || Ent2.LocalAng )

		constraint.AddConstraintTable( Ent1, Ent2, Ent2 )

		Ent2:SetTable( {
			Type = "EasyBonemergeParent",
			Ent1 = Ent1,
			Ent2 = Ent2,
			LocalPos = LocalPos || Ent2.LocalPos,
			LocalAng = LocalAng || Ent2.LocalAng,
			EntityMods = EntityMods || Ent2.EntityMods,
			BoneMods = BoneMods || Ent2.BoneMods
		} )

		duplicator.ApplyEntityModifiers( nil, Ent2 )
		duplicator.ApplyBoneModifiers( nil, Ent2 )

		Ent1:DeleteOnRemove( Ent2 )

		return Ent2
	end
	duplicator.RegisterConstraint( "EasyBonemergeParent", constraint_EasyBonemergeParent, "Ent1", "Ent2", "LocalPos", "LocalAng", "EntityMods", "BoneMods" )

end