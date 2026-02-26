PERK.PrintName = "Ascendant"
PERK.Icon = "materials/perks/phase_walk.png"
PERK.Description = [[
Press SHIFT + E to Dash.
Provides 100% evasion during Dash.
Recharges 1 use after 3 seconds.]]

PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk == "prototype_ascendent" then
        ply:Horde_SetPerkCooldown( 3 )
        net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_Quickstep, 8 )
        net.WriteUInt( 1, 3 )
        net.Send( ply )
        ply:Horde_SetPerkCharges( 3 )
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk == "prototype_ascendent" then
        net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_Quickstep, 8 )
        net.WriteUInt( 0, 3 )
        net.Send( ply )
        ply:Horde_SetPerkCharges( 0 )
    end
end

PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "prototype_ascendent" ) then return end
    if ply:Horde_GetPerkCharges() <= 0 then return true end

    if ply:Horde_GetSpamPerkCooldown() > CurTime() then return true end
    ply:Horde_SetSpamPerkCooldown( CurTime() + 0.25 )
    
    local id = ply:SteamID()

    local max_charges = 3
    ply:Horde_SetPerkCharges( ply:Horde_GetPerkCharges() - 1 )

    timer.Remove( "Horde_Prototype_Ascendent_Timer" .. id )
    timer.Create( "Horde_Prototype_Ascendent_Timer" .. id, 3, 0, function ()
        if not ply:IsValid() or not ply:Horde_GetPerk( "prototype_ascendent" ) then timer.Remove( "Horde_Prototype_Ascendent_Timer" .. id ) return end
        if ply:Horde_GetPerkCharges() >= max_charges then timer.Remove( "Horde_Prototype_Ascendent_Timer" .. id ) return end
        ply:Horde_SetPerkCharges( math.min ( max_charges, ply:Horde_GetPerkCharges() + 1 ) )
    end )

    local dir = ply:GetForward()
    if ply:KeyDown( IN_MOVERIGHT ) then
        dir = ply:GetRight()
    elseif ply:KeyDown( IN_MOVELEFT ) then
        dir = -ply:GetRight()
    elseif ply:KeyDown( IN_BACK ) then
        dir = -dir
    elseif ply:KeyDown( IN_FORWARD ) then
    else
        dir = -dir
    end

    local vel
    if ply:IsOnGround() then
        vel = dir * 2000
    else
        vel = dir * 1000
    end

    ply:SetLocalVelocity( vel )
    ply:EmitSound( ")horde/player/prototype/Dodge3.wav", 75, math.random( 95, 105 ), 1, CHAN_AUTO )

    ply.Horde_In_Quickstep = true

    local t = 0.5
    timer.Create( "Horde_Ascendent_Effect" .. id, t, 1, function()
        timer.Remove( "Horde_Ascendent_Effect" .. id )
        if ply:IsValid() then
            ply.Horde_In_Quickstep = nil
        end
    end)

    if ply:Horde_GetPerkCharges() > 0 then
        return true
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "prototype_ascendent" ) then return end

    if ply.Horde_In_Quickstep then
        bonus.evasion = bonus.evasion + 1.0
    end
end
