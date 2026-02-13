PERK.PrintName = "Shield Bash"
PERK.Icon = "materials/perks/paladin/shield_bash.png"
PERK.Description = [[
While shielding, reduce debuff buildups by 50%.
Press Shift + E to strike an enemy with your shield, dealing 200 Blunt damage, stunning him and pushing away from you.
Cooldown: 10 seconds.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_shield_bash" then return end

    ply:Horde_SetPerkCooldown( 10 )
    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_PaladinShieldBash, 8 )
        net.WriteUInt( 1, 3 )
    net.Send( ply )

    ply.Horde_PaladinShieldBashHitTargets = {}
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
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

local bashDmginfo = DamageInfo()
bashDmginfo:SetDamage( 200 )
bashDmginfo:SetDamageType( DMG_CLUB )

PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "paladin_shield_bash" ) then return end

    ply.Horde_PaladinBashing = true

    local forward = ply:GetForward()
    local forwardForce = forward * ( ply:IsOnGround() and 2000 or 1000 )
    ply:SetLocalVelocity( forwardForce )

    timer.Create( "PaladinBash_" .. ply:EntIndex(), 0.05, bashDuration / 0.05, function()
        if not IsValid( ply ) or not ply.Horde_PaladinBashing then
            timer.Remove( "PaladinBash_" .. ply:EntIndex() )

            return
        end

        local plyPos = ply:GetPos()
        for _, target in ipairs( ents.FindInSphere( plyPos, 80 ) ) do
            if IsValid( target ) and HORDE:IsEnemy( target ) and not ply.Horde_PaladinShieldBashHitTargets[target] then
                local targetPos = target:GetPos()
                local toTarget = ( targetPos - plyPos ):GetNormalized()
                local dot = ply:GetForward():Dot( toTarget )

                if dot > 0.5 then
                    ply:SetLocalVelocity( vector_origin )
                    ply.Horde_PaladinShieldBashHitTargets[target] = true

                    bashDmginfo:SetAttacker( ply )
                    bashDmginfo:SetInflictor( ply )
                    bashDmginfo:SetDamagePosition( targetPos )
                    target:TakeDamageInfo( bashDmginfo )

                    local knockbackForce = ply:GetForward() * bashKnockback + bashKnockUp
                    target:SetVelocity( knockbackForce )
                    target:Horde_AddDebuffBuildup( HORDE.Status_Shock, 1000, ply, targetPos )

                    ply:EmitSound( "horde/player/quickstep.ogg" )
                    ply:EmitSound( "physics/flesh/flesh_impact_hard" .. math.random( 1, 5 ) .. ".wav" )
                end
            end
        end
    end )

    timer.Simple( bashDuration, function()
        if IsValid( ply ) then
            ply.Horde_PaladinBashing = nil
            ply.Horde_PaladinShieldBashHitTargets = {}
        end
    end )
end