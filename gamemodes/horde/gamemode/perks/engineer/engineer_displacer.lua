PERK.PrintName = "Displacer"
PERK.Description = [[Press SHIFT+E to teleport a targeted minion to your side.
Recover {1} of the teleported minion's health.
Displacer has a cooldown of {2} seconds.]]
PERK.Icon = "materials/perks/displacer.png"
PERK.Params = {
    [1] = { value = 0.05, percent = true },
    [2] = { value = 3 },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "engineer_displacer" then return end

    ply:Horde_SetPerkCooldown( 3 )
    ply:Horde_SetPerkInternalCooldown( 0 )

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_Displacer, 8 )
        net.WriteUInt( 1, 3 )
    net.Send( ply )
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "engineer_displacer" then return end

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_Displacer, 8 )
        net.WriteUInt( 0, 3 )
    net.Send( ply )
end

PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "engineer_displacer" ) then return end

    local tr = util.TraceLine( {
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:GetAimVector() * 25000,
        filter = { "player" },
        mask = MASK_SOLID,
    } )

    local ent = tr.Entity

    if ent:IsWorld() or not HORDE:IsPlayerOrMinion( ent ) then
        ply:EmitSound( "items/suitchargeno1.wav" )

        return true
    end

    local owner = ent:GetNWEntity( "HordeOwner" )
    if not IsValid( owner ) or owner ~= ply then
        ply:EmitSound( "items/suitchargeno1.wav" )

        return true
    end

    local item = HORDE.items[ent:GetClass()]
    if not item then return end

    local plyPos = ply:GetPos()
    local dir = tr.HitPos - plyPos
    dir:Normalize()

    local dropPos = plyPos + dir * item.entity_properties.x
    dropPos.z = plyPos.z + item.entity_properties.z

    local dropAng = Angle( 0, ply:GetAngles().y + item.entity_properties.yaw, 0 )
    --[[ Currently replaced w/ temp sniper turret model so not currently needed
    if ent:GetClass() == "npc_vj_horde_sniper_turret" then
        drop_ang.r = 180
    end
    --]]

    local hitboxMins = ent:OBBMins()
    local hitboxMaxs = ent:OBBMaxs()

    local mins = hitboxMins + Vector( hitboxMins.x, hitboxMins.y, 5 )
    local maxs = hitboxMaxs + Vector( hitboxMaxs.x, hitboxMaxs.y, 5 )

    local trOpenSpaceCheck = util.TraceHull( {
        start = dropPos,
        endpos = dropPos + Vector( 0, 0, hitboxMaxs.y ),
        mins = mins,
        maxs = maxs,
        filter = function( filterEnt )
            if not IsValid( filterEnt ) then return true end
            if HORDE:IsPlayerOrMinion( filterEnt ) then return false end
            return true
        end
    } )

    --[[ Debugging
    debugoverlay.Line( plyPos, dropPos + dir, 5, Color( 0, 255, 0 ), true )
    debugoverlay.Box( dropPos, mins, maxs, 5, Color( 255, 0, 0, 50 ) )
    ]]

    local openSpaceCheckEnt = trOpenSpaceCheck.Entity
    if openSpaceCheckEnt:IsWorld() or IsValid( openSpaceCheckEnt ) then
        HORDE:SendNotification( "Not enough free room!", 1, ply )
        ply:EmitSound( "items/suitchargeno1.wav" )

        return true
    end

    ent:SetPos( dropPos )
    ent:SetAngles( dropAng )
    if ent.MovementType == VJ_MOVETYPE_STATIONARY then
        ply:PickupObject( ent )
        ent:GetPhysicsObject():EnableMotion( true )
    end
    ent:SetHealth( math.min( ent:GetMaxHealth(), ent:GetMaxHealth() * 0.05 + ent:Health() ) )

    ply:EmitSound( "weapons/physcannon/physcannon_pickup.ogg" )
end