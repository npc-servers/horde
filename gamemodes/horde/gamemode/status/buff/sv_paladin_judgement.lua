local plymeta = FindMetaTable( "Player" )

function plymeta:Horde_AddJudgement( duration )
    if not self:IsValid() then return end

    timer.Remove( "Horde_RemoveJudgement" .. self:SteamID() )
    timer.Create( "Horde_RemoveJudgement" .. self:SteamID(), duration, 1, function()
        self:Horde_RemoveJudgement()
    end )

    self.Horde_Judgement = 1

    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_PaladinJudgement, 8 )
        net.WriteUInt( 1, 8 )
    net.Send( self )
end

function plymeta:Horde_RemoveJudgement()
    if not self:IsValid() then return end
    if self.Horde_Judgement == 0 then return end

    self.Horde_Judgement = 0

    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_PaladinJudgement, 8 )
        net.WriteUInt( 0, 8 )
    net.Send( self )
end

function plymeta:Horde_GetJudgement()
    return self.Horde_Judgement or 0
end

hook.Add( "Horde_OnPlayerDamage", "Horde_JudgementDamage", function( ply, npc, _, _, dmginfo )
    if ply:Horde_GetJudgement() == 1 then
        npc:Horde_AddDebuffBuildup( HORDE.Status_Shock, dmginfo:GetDamage() * 0.25, ply, dmginfo:GetDamagePosition() )
    end
end )

hook.Add( "Horde_ResetStatus", "Horde_JudgementReset", function( ply )
    ply.Horde_Judgement = 0
end )