local plyMeta = FindMetaTable( "Player" )

function plyMeta:Horde_SetSpectreCount( count, ult )
    if ult then
        self.Horde_UltSpectreCount = math.max( 0, count )

        net.Start( "Horde_SyncStatus" )
            net.WriteUInt( HORDE.Status_NecromancerUltSpectre, 8 )
            net.WriteUInt( self.Horde_UltSpectreCount, 8 )
        net.Send( self )

        return
    end

    self.Horde_SpectreCount = math.max( 0, count )

    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_NecromancerSpectre, 8 )
        net.WriteUInt( self.Horde_SpectreCount, 8 )
    net.Send( self )
end

function plyMeta:Horde_GetSpectreCount( ult )
    return ult and ( self.Horde_UltSpectreCount or 0 )  or ( self.Horde_SpectreCount or 0 )
end