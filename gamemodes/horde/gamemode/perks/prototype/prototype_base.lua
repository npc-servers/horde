PERK.PrintName = "Prototype Base"
PERK.Description = [[
The Prototype class is a close-range fighter with unique abilities.
Complexity: MEDIUM

{1} increased damage at close-range ({2} + {3} per level, up to {4}).

Leech 5 health at close range.

Has access to light weapons and shotguns.]]

PERK.Params = {
    [1] = { percent = true, level = 0.01, base = 0.25, max = 0.50, classname = "Prototype" },
    [2] = { value = 0.25, percent = true },
    [3] = { value = 0.01, percent = true },
    [4] = { value = 0.50, percent = true },
}

PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk == "prototype_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk == "prototype_base" then
        ply.Horde_PrototypeGetMaxHealth = nil
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function( ply )
    ply:Horde_SetPerkLevelBonus( "prototype_base", math.min( 0.50, 0.25 + 0.01 * ply:Horde_GetLevel( "Prototype" ) ) )
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
    if not HORDE:IsBallisticDamage( dmginfo ) then return end

    local hitPos = dmginfo:GetDamagePosition()
    local selfPos = ply:GetPos()
    local sqrDist = hitPos:DistToSqr( selfPos )

    local plyLevel = ply:Horde_GetPerkLevelBonus( "prototype_base" )
    if sqrDist < 15000 then
        bonus.increase = bonus.increase + plyLevel

        if ply:Health() == ply.Horde_PrototypeGetMaxHealth then return end
        if dmginfo:GetDamage() <= 0 then return end

        ply:EmitSound( "horde/player/prototype/HpGet.wav", 75, math.random( 95, 105 ), 1, CHAN_AUTO )
        HORDE:SelfHeal( ply, ply:Horde_GetPerk( "prototype_gluttonous_maw" ) and 10 or 5 )
    elseif sqrDist < 30000 then
        bonus.increase = bonus.increase + plyLevel / 2

        if ply:Health() == ply.Horde_PrototypeGetMaxHealth then return end
        if not ply:Horde_GetPerk( "prototype_hemo_siphon" ) then return end
        if dmginfo:GetDamage() <= 0 then return end

        ply:EmitSound( "horde/player/prototype/HpGet.wav", 75, math.random( 95, 105 ), 1, CHAN_AUTO )
        HORDE:SelfHeal( ply, 5 )
    elseif sqrDist < 45000 then
        bonus.increase = bonus.increase + plyLevel / 4
    elseif sqrDist < 60000 then
        return
    end
end
