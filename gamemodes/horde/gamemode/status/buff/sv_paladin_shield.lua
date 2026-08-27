local plymeta = FindMetaTable( "Player" )

function plymeta:Horde_AddPaladinShield()
    self.Horde_PaladinShieldCount = ( self.Horde_PaladinShieldCount or 0 ) + 1

    if self.Horde_PaladinShieldCount == 1 then
        net.Start( "Horde_SyncStatus" )
            net.WriteUInt( HORDE.Status_PaladinShielding, 8 )
            net.WriteUInt( 1, 8 )
        net.Send( self )
    end

    self:ScreenFade( SCREENFADE.STAYOUT, Color( 255, 255, 0, 10 ), 0.2, 5 )
    self:EmitSound( ")horde/spells/negative_burst.ogg" )
end

function plymeta:Horde_RemovePaladinShield()
    self.Horde_PaladinShieldCount = ( self.Horde_PaladinShieldCount or 0 ) - 1

    if self.Horde_PaladinShieldCount <= 0 then
        self.Horde_PaladinShieldCount = nil

        net.Start( "Horde_SyncStatus" )
            net.WriteUInt( HORDE.Status_PaladinShielding, 8 )
            net.WriteUInt( 0, 8 )
        net.Send( self )
    end

    self:ScreenFade( SCREENFADE.PURGE, Color( 255, 255, 0, 0 ), 0.1, 0.1 )
end