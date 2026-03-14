local plymeta = FindMetaTable( "Player" )

function plymeta:Horde_AddPaladinFaithStack()
    if not self:IsValid() or not self:IsPlayer() then return end

    if self:Horde_GetPaladinFaithStack() < self:Horde_GetMaxPaladinFaithStack() then
        self.Horde_PaladinFaithStack = self.Horde_PaladinFaithStack + 1
    end

    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_PaladinFaith, 8 )
        net.WriteUInt( self.Horde_PaladinFaithStack, 8 )
    net.Send( self )
end

function plymeta:Horde_RemovePaladinFaithStack()
    if not self:IsValid() then return end
    if self:Horde_GetPaladinFaithStack() <= 0 then return end

    self.Horde_PaladinFaithStack = math.max( 0, self.Horde_PaladinFaithStack - 1 )

    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_PaladinFaith, 8 )
        net.WriteUInt( self.Horde_PaladinFaithStack, 8 )
    net.Send( self )

    hook.Run( "Horde_Paladin_OnLoseFaith", self )

    local effect = EffectData()
    effect:SetOrigin( self:GetPos() + Vector( 0, 0, 30 ) )

    util.Effect( "horde_faith_loss", effect, true, true )
    self:EmitSound( "horde/player/focus_slash.ogg"   )
end

function plymeta:Horde_GetPaladinFaithStack()
    return self.Horde_PaladinFaithStack or 0
end

function plymeta:Horde_GetMaxPaladinFaithStack()
    return 10
end

hook.Add( "Horde_ResetStatus", "Horde_PaladinFaithReset", function( ply )
    ply.Horde_PaladinFaithStack = 0
end )