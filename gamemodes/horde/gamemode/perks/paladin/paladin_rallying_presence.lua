PERK.PrintName = "Rallying Presence"
PERK.Icon = "materials/perks/paladin/rallying_presence.png"
PERK.Description = [[
All players inside Sacred Aura deal 25% more damage when their health is full.
All players inside Sacred Aura regenerate 2% health if their health is lower than full.]]
PERK.Hooks = {}

local function insideAura( ply, insideAuraPly )
    local aura = ply.Horde_PaladinAura
    if not aura then return false end

    local entsInside = aura.EntitiesInside
    if not ( entsInside or entsInside[insideAuraPly:EntIndex()] ) then return false end

    return true
end

local function getProtectingPaladins( ply )
    local protectors = {}
    for _, auraPly in ipairs( player.GetAll() ) do
        if insideAura( auraPly, ply ) and auraPly:Horde_GetPerk( "paladin_rallying_presence" ) then
            table.insert( protectors, auraPly )
        end
    end

    return protectors
end

local dmgPercentIncrease = 0.25

PERK.Hooks.OnPlayerDamage = function( ply, _, bonus )
    if ply:Health() < ply:GetMaxHealth() then return end

    if not ply:Horde_GetPerk( "paladin_rallying_presence" ) then
        local protectors = getProtectingPaladins( ply )

        if not protectors then return end
    end

    bonus.increase = bonus.increase + dmgPercentIncrease
end