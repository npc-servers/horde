PERK.PrintName = "Parry"
PERK.Description = "Activating Blade Mode will give you {1} physical resist for {2} second."
PERK.Icon = "materials/perks/samurai/blade_dance.png"
PERK.Params = {
    [1] = { value = 1, percent = true },
    [2] = { value = 1 },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if SERVER and perk == "cyborg_ninja_parry" then
        ply.Horde_CheckCyborgDodge = true
        ply.Horde_DoCyborgDodge = nil
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if SERVER and perk == "cyborg_ninja_parry" then
        ply.Horde_CheckCyborgDodge = nil
        ply.Horde_DoCyborgDodge = nil

        local id = ply:SteamID64()
        timer.Stop( "CyborgNinja_EndDodge" .. id )

        net.Start( "Horde_SyncStatus" )
            net.WriteUInt( HORDE.Status_Parry, 8 )
            net.WriteUInt( 0, 8 )
        net.Send( ply )
    end
end

PERK.Hooks.PlayerSwitchFlashlight = function( ply, switchOn )
    if not ply:Horde_GetPerk( "cyborg_ninja_parry" ) then return end

    local id = ply:SteamID64()
    timer.Stop( "CyborgNinja_EndDodge" .. id )

    if not switchOn then
        ply.Horde_DoCyborgDodge = nil
        return
    end

    ply.Horde_DoCyborgDodge = true
    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_Parry, 8 )
        net.WriteUInt( 1, 8 )
    net.Send( ply )

    timer.Create( "CyborgNinja_EndDodge" .. id, 1, 1, function()
        ply.Horde_DoCyborgDodge = nil
        net.Start( "Horde_SyncStatus" )
            net.WriteUInt( HORDE.Status_Parry, 8 )
            net.WriteUInt( 0, 8 )
        net.Send( ply )
    end )
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus, silent )
    if not ply:Horde_GetPerk( "cyborg_ninja_parry" ) then return end
    if not HORDE:IsPhysicalDamage( dmginfo ) then return end
    if not ply.Horde_In_Frenzy_Mode then return end
    if not ply.Horde_CheckCyborgDodge and not ply.Horde_DoCyborgDodge then return end

    bonus.resistance = bonus.resistance + 1.0

    local e = EffectData()
    if dmginfo:GetDamagePosition() ~= Vector( 0, 0, 0 ) then
        e:SetOrigin( dmginfo:GetDamagePosition() )
    else
        e:SetOrigin( ply:GetPos() + Vector( 0, 0, 30 ) )
    end

    util.Effect( "horde_aerial_parry", e, true, true )
    if not silent then
        sound.Play( "horde/gadgets/guard" .. tostring( math.random( 1, 2 ) ) .. ".ogg", ply:GetPos(), 125, 100, 1, CHAN_AUTO )
    end
end

