PERK.PrintName = "Pneumatic Legs"
PERK.Description =
[[Adds {1} maximum Hypertrophy stacks. Gain immunity to fall damage.
Press SPACE in air to descend, dealing area Physical damage based on your speed.
Hinders and launches enemies away from you on impact.]]
PERK.Icon = "materials/perks/carcass/pneumatic_legs.png"
PERK.Params = {
    [1] = { value = 1 },
    [2] = { value = 0.9, percent = true },
    [3] = { value = 5 },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if SERVER and perk == "carcass_pneumatic_legs" then
        ply:Horde_SetMaxHypertrophyStack( ply:Horde_GetMaxHypertrophyStack() + 1 )
        ply.Horde_Pneumatic_Leg_Ready = true
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if SERVER and perk == "carcass_pneumatic_legs" then
        ply:Horde_SetMaxHypertrophyStack( ply:Horde_GetMaxHypertrophyStack() - 1 )
        ply.Horde_Pneumatic_Leg_Ready = nil
    end
end

PERK.Hooks.Horde_GetFallDamage = function( ply, speed, bonus )
    if ply:Horde_GetPerk( "carcass_pneumatic_legs" ) then
        bonus.less = bonus.less * 0
        local dmg = math.max( 0, math.ceil( 0.2418 * speed - 141.75 ) ) * 6
        local rad, pos = 320, ply:GetPos()
        if dmg < 10 then return end
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker( ply )
        dmginfo:SetInflictor( ply )
        dmginfo:SetDamageType( DMG_GENERIC )
        dmginfo:SetDamage( dmg )
        dmginfo:SetDamagePosition( pos )
        util.BlastDamageInfo( dmginfo, pos, rad )

        local e = EffectData()
            e:SetNormal( Vector( 0, 0, 1 ) )
            e:SetOrigin( pos )
            e:SetRadius( rad )
        util.Effect("seismic_wave", e, true, true)

         for _, target in ipairs( ents.FindInSphere( pos, rad ) ) do
            if IsValid( target ) and HORDE:IsEnemy( target ) then
                local bashKnockback
                local targetPos, bashKnockUp = target:GetPos(), Vector( 0, 0, 100 )
                local toTarget = ( targetPos - pos ):GetNormalized() * Vector( 1, 1, 0 )
                local dist = ( rad - pos:Distance2D( targetPos ) ) * 0.01

                if speed <= 400 then
                    bashKnockback = 400 / 1.5
                else
                    bashKnockback = speed / 1.5
                end

                local knockbackForce = ( ( toTarget * bashKnockback ) * dist ) + bashKnockUp
                if not target:Horde_GetBossProperties() then
                    target:SetVelocity( knockbackForce )
                end
                target:Horde_AddHinder( ply, ply:Horde_GetApplyDebuffDuration(), ply:Horde_GetApplyDebuffMore() )
            end
        end

        ply.Horde_Pneumatic_Leg_Ready = true
    end
end

PERK.Hooks.PlayerButtonDown = function ( ply, key )
    local velocity = ply:GetVelocity():Length()
            local tr = util.TraceLine({
            start = ply:GetPos(),
            endpos = ply:GetPos() - Vector( 0, 0, 50 ),
            mask = MASK_SOLID,
            filter = ply
        })
        local Cur = 0
    if key == KEY_SPACE and ply:Horde_GetPerk( "carcass_pneumatic_legs" ) and not ply:IsOnGround() and ( ( velocity >= 400 ) or not tr.Hit ) and ply.Horde_Pneumatic_Leg_Ready then
        local dir = Vector( 0, 0, -1 )
        local vel = dir * math.max( 590, velocity + 250 )
        ply:SetLocalVelocity( vel )
        ply.Horde_Pneumatic_Leg_Ready = false
        Cur = CurTime()
    end
    if ply:Horde_GetPerk("carcass_pneumatic_legs") and not ply:IsOnGround() and not ply.Horde_Pneumatic_Leg_Ready and (Cur + 1.5) <= CurTime() then
    ply.Horde_Pneumatic_Leg_Ready = true
    end
end
