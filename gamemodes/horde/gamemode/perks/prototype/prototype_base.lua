PERK.PrintName = "Prototype Base"
PERK.Description = [[
The Prototype class is a close-range fighter with unique abilities.
Complexity: MEDIUM

{1} increased Physical damage at close-range ({2} + {3} per level, up to {4}).

Leech health when near enemies.

Has full access to shotguns.]]

PERK.Params = {
    [1] = { percent = true, level = 0.01, base = 0.05, max = 0.25, classname = "Prototype" },
    [2] = { value = 0.05, percent = true },
    [3] = { value = 0.01, percent = true },
    [4] = { value = 0.25, percent = true },
}

PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk == "prototype_base" then
        ply.Horde_PrototypeGetMaxHealth = nil
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function( ply )
    ply:Horde_SetPerkLevelBonus( "prototype_base", math.min( 0.25, 0.05 + 0.01 * ply:Horde_GetLevel( "Prototype" ) ) )
end

PERK.Hooks.Horde_OnSetMaxHealth = function( ply )
    if not ply:Horde_GetPerk( "prototype_base" ) then return end
    
    timer.Simple( 0, function() 
        if IsValid( ply ) then 
            ply.Horde_PrototypeGetMaxHealth = ply:GetMaxHealth() 
        end 
    end )
end

PERK.Hooks.Horde_OnPlayerDamage = function( ply, npc, bonus, hitgroup, dmginfo )
    if not ply:Horde_GetPerk( "prototype_base" ) then return end
    if not HORDE:IsPhysicalDamage( dmginfo ) then return end

    local plyLevel = ply:Horde_GetPerkLevelBonus( "prototype_base" )

    local hitPos = dmginfo:GetDamagePosition()
    local selfPos = ply:GetPos()
    local sqrDist = hitPos:DistToSqr( selfPos )

    if sqrDist < 250 ^ 2 then
        bonus.increase = bonus.increase + plyLevel
        ply:EmitSound( ")horde/player/prototype/Impacts_SIMPLE_003.wav", 75, math.random( 75, 85 ), 1, CHAN_WEAPON )
    elseif sqrDist < 375 ^ 2 then
        bonus.increase = bonus.increase + plyLevel / 2
        ply:EmitSound( ")horde/player/prototype/Impacts_SIMPLE_003.wav", 75, math.random( 95, 105 ), 0.5, CHAN_WEAPON )
    elseif sqrDist < 500 ^ 2 then
        bonus.increase = bonus.increase + plyLevel / 4
        ply:EmitSound( ")horde/player/prototype/Impacts_SIMPLE_003.wav", 75, math.random( 115, 125 ), 0.25, CHAN_WEAPON )
    elseif sqrDist < 750 ^ 2 then
        return
    end

    if ply:Health() == ply.Horde_PrototypeGetMaxHealth then return end
    if dmginfo:GetDamage() <= 0 then return end

    if sqrDist < 250 ^ 2 then
        HORDE:SelfHeal( ply, ply:Horde_GetPerk( "prototype_gluttonous_maw" ) and 4 or 2 )
        ply:EmitSound( ")horde/player/prototype/HpGet.wav", 75, math.random( 95, 105 ), 1, CHAN_AUTO )
    elseif sqrDist < 500 ^ 2 then
        if not ply:Horde_GetPerk( "prototype_hemo_siphon" ) then return end
        HORDE:SelfHeal( ply, 2 )
        ply:EmitSound( ")horde/player/prototype/HpGet.wav", 75, math.random( 115, 125 ), 0.5, CHAN_AUTO )
    end
end
