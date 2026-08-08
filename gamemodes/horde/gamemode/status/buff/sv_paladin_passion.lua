local plymeta = FindMetaTable( "Player" )

function plymeta:Horde_AddPassion( duration )
    if not self:IsValid() then return end

    timer.Remove( "Horde_RemovePassion" .. self:SteamID() )
    timer.Create( "Horde_RemovePassion" .. self:SteamID(), duration, 1, function ()
        self:Horde_RemovePassion()
    end )

    self.Horde_Passion = 1

    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_PaladinPassion, 8 )
        net.WriteUInt( 1, 8 )
    net.Send( self )
end

function plymeta:Horde_RemovePassion()
    if not self:IsValid() then return end
    if self.Horde_Passion == 0 then return end

    self.Horde_Passion = 0

    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_PaladinPassion, 8 )
        net.WriteUInt( 0, 8 )
    net.Send( self )
end

function plymeta:Horde_GetPassion()
    return self.Horde_Passion or 0
end

hook.Add( "Horde_OnPlayerDamage", "Horde_PassionDamage", function( ply, npc, _, _, dmginfo )
    if dmginfo:GetDamage() <= 0.5 then return end
    if ply:Horde_GetPassion() ~= 1 then return end

    local burnDmginfo = DamageInfo()
    burnDmginfo:SetDamage( 0 )
    burnDmginfo:SetDamageType( DMG_BURN )
    burnDmginfo:SetAttacker( ply )
    burnDmginfo:SetInflictor( ply )

    npc:Horde_SetIgniteDamage( 10 )
    npc:Horde_SetMostRecentFireAttacker( ply, burnDmginfo )
    npc:Ignite( ply:Horde_GetApplyIgniteDuration() )
end )

hook.Add( "Horde_ResetStatus", "Horde_PassionReset", function( ply )
    ply.Horde_Passion = 0
end )