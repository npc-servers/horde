PERK.PrintName = "Shield Bash"
PERK.Icon = "materials/perks/paladin/shield_bash.png"
PERK.Description = [[
Divine Shield reduce debuff buildups by 50%.
Press Shift + E dash forward, dealing 200 Blunt damage, stunning
and pushing enemies you hit away. Cooldown: 10 seconds.]]
PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "paladin_shield_bash" then return end

    ply:Horde_SetPerkCooldown( 10 )

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_PaladinShieldBash, 8 )
        net.WriteUInt( 1, 3 )
    net.Send( ply )

    ply.Horde_PaladinShieldBashHitTargets = {}
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk ~= "paladin_shield_bash" then return end

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_PaladinShieldBash, 8 )
        net.WriteUInt( 0, 3 )
    net.Send( ply )

    ply.Horde_PaladinShieldBashHitTargets = nil
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function ( ply, _, bonus )
    if not ply:Horde_GetPerk( "paladin_shield_bash" ) then return end
    if not ply.Horde_PaladinShielding then return end

    bonus.less = bonus.less * 0.5
end

local bashKnockback = 1000
local bashKnockUp = Vector( 0, 0, 200 )
local bashDuration = 0.5

local dmgAmt = 200
local dmgType = DMG_CLUB

PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "paladin_shield_bash" ) then return end

    ply.Horde_PaladinBashing = true

    local forward = ply:GetForward()
    local forwardForce = forward * ( ply:IsOnGround() and 2000 or 1000 )
    ply:SetLocalVelocity( forwardForce )

    ply:EmitSound( "horde/spells/charge.ogg" )

    timer.Create( "PaladinBash_" .. ply:EntIndex(), 0.05, bashDuration / 0.05, function()
        if not IsValid( ply ) or not ply.Horde_PaladinBashing then
            timer.Remove( "PaladinBash_" .. ply:EntIndex() )

            return
        end

        local bashDmginfo = DamageInfo()
        bashDmginfo:SetDamage( dmgAmt )
        bashDmginfo:SetDamageType( dmgType )
        bashDmginfo:SetAttacker( ply )
        bashDmginfo:SetInflictor( ply )

        local hit = false
        local plyPos = ply:GetPos()

        for _, target in ipairs( ents.FindInSphere( plyPos, 80 ) ) do
            if IsValid( target ) and HORDE:IsEnemy( target ) and not ply.Horde_PaladinShieldBashHitTargets[target] then
                local targetPos = target:GetPos()
                local toTarget = ( targetPos - plyPos ):GetNormalized()
                local dot = ply:GetForward():Dot( toTarget )

                if dot > 0.5 then
                    ply:SetLocalVelocity( vector_origin )
                    ply.Horde_PaladinShieldBashHitTargets[target] = true

                    bashDmginfo:SetDamagePosition( targetPos )
                    target:TakeDamageInfo( bashDmginfo )

                    local knockbackForce = ply:GetForward() * bashKnockback + bashKnockUp
                    target:SetVelocity( knockbackForce )
                    target:Horde_AddDebuffBuildup( HORDE.Status_Stun, 19208, ply, targetPos )

                    hit = true
                end
            end
        end

        if hit then
            ply:EmitSound( "horde/player/quickstep.ogg" )
            ply:EmitSound( "physics/flesh/flesh_impact_hard" .. math.random( 1, 5 ) .. ".wav" )
        end
    end )

    timer.Simple( bashDuration, function()
        if IsValid( ply ) then
            ply.Horde_PaladinBashing = nil
            ply.Horde_PaladinShieldBashHitTargets = {}
        end
    end )
end