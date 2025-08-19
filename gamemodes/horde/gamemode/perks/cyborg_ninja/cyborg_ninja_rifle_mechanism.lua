PERK.PrintName = "Rifle Mechanism"
PERK.Description =
[[Unlocks a Special Attack (Shift + E).
Perform an attack that deals 1000 Physical damage.
15 second cooldown.]]
PERK.Icon = "materials/perks/samurai/focus_slash.png"

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if SERVER and perk == "cyborg_ninja_rifle_mechanism" then
        ply:Horde_SetPerkCooldown( 15 )
        net.Start( "Horde_SyncActivePerk" )
            net.WriteUInt( HORDE.Status_Rifle_Mechanism, 8 )
            net.WriteUInt( 1, 3 )
        net.Send( ply )
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if SERVER and perk == "cyborg_ninja_rifle_mechanism" then
        net.Start( "Horde_SyncActivePerk" )
            net.WriteUInt( HORDE.Status_Rifle_Mechanism, 8 )
            net.WriteUInt( 0, 3 )
        net.Send( ply )
    end
end


PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "cyborg_ninja_rifle_mechanism" ) then return end

    local trace = util.TraceLine( util.GetPlayerTrace( ply ) )
    local ent = trace.Entity
    local startpos = trace.StartPos
    local hitpos = trace.HitPos
    local distance = math.sqrt( ( hitpos.x - startpos.x ) ^ 2 + ( hitpos.y - startpos.y ) ^ 2 + ( hitpos.z - startpos.z ) ^ 2 )

    if not ent:IsValid() or not ent:IsNPC() or distance > 196 then
        ply:EmitSound( "items/suitchargeno1.wav" )
        ply:Horde_SetPerkCooldown( 1 )
        return
    end

    sound.Play( "horde/weapons/katana/melee_katana_02.ogg", ply:GetPos() )
    ply:Horde_SetPerkCooldown( 15 )

    local fx = EffectData()
    fx:SetOrigin( hitpos )
    util.Effect( "BloodImpact", fx )

    local dmginfo = DamageInfo()
    dmginfo:SetDamage( 1000 )
    dmginfo:SetAttacker( ply )
    dmginfo:SetInflictor( ply )
    dmginfo:SetDamagePosition( ent:GetPos() )
    dmginfo:SetDamageType( DMG_CRUSH )
    ent:TakeDamageInfo( dmginfo )

    --ent:TakeDamage(1000, ply)
end
