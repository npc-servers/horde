util.AddNetworkString( "Horde_HitnumbersDebuffSpawn" )

local on = true

hook.Add( "Horde_PostEnemyDebuffApply", "Horde_HitnumbersDebuff", function ( target, inflictor, debuff, pos )
    if IsValid( inflictor ) and inflictor:IsPlayer() then
        net.Start( "Horde_HitnumbersDebuffSpawn", true )
        	net.WriteUInt( debuff, 32 )
        	net.WriteVector( pos )
        net.Send( inflictor )
    end
end )