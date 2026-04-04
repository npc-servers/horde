util.AddNetworkString( "Horde_HitnumbersSpawn" )
util.AddNetworkString( "Horde_HitnumbersDebuffSpawn" )
util.AddNetworkString( "Horde_HitSounds" )

local on = true

hook.Add( "PostEntityTakeDamage", "Horde_HitnumbersDamagePost", function( target, dmginfo, took )
    if not took then return end
	local attacker = dmginfo:GetAttacker()
	local attackerIsPlayer = attacker:IsPlayer()

	if not ( attackerIsPlayer ) then return end
	if attacker == target  then return end
    if not target:IsNPC() then return end

	local dmgAmount = dmginfo:GetDamage()
	local dmgType = dmginfo:GetDamageType()
	local pos = dmginfo:GetDamagePosition()
		
    if not pos or dmginfo:IsExplosionDamage() then
        pos = target:GetPos()
    end

	net.Start( "Horde_HitnumbersSpawn", true )
		net.WriteFloat( dmgAmount )
		net.WriteUInt( dmgType, 32 )
		net.WriteVector( pos )
	net.Send( attacker )

	net.Start("Horde_HitSounds")
    net.Send( attacker )
end )

hook.Add( "Horde_PostEnemyDebuffApply", "Horde_HitnumbersDebuff", function ( target, inflictor, debuff, pos )
    if IsValid( inflictor ) and inflictor:IsPlayer() then
        net.Start( "Horde_HitnumbersDebuffSpawn", true )
        	net.WriteUInt( debuff, 32 )
        	net.WriteVector( pos )
        net.Send( inflictor )
    end
end )
