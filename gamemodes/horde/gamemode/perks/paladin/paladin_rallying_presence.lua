PERK.PrintName = "Rallying Presence"
PERK.Icon = "materials/perks/paladin/rallying_presence.png"
PERK.Description = [[
All players inside Sacred Aura deal 25% more damage when their health is full.
All players inside Sacred Aura regenerate 2% health if their health is lower than full.]]
PERK.Hooks = {}

local function insideAura( ply, insideAuraPly )
    local aura = ply.Horde_PaladinAura
    if not aura then return false end

    local entsInside = aura.Entities
    if not ( entsInside or entsInside[insideAuraPly] ) then return false end

    return true
end

local function getProtectingPaladins( ply )
    for _, auraPly in ipairs( player.GetAll() ) do
        if auraPly:Horde_GetPerk( "paladin_providence" ) and insideAura( auraPly, ply ) then
            return true
        end
    end

    return false
end

local dmgPercentIncrease = 0.25

PERK.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus )
    if ply:Health() < ply:GetMaxHealth() then return end
    if not ply:Horde_GetPerk( "paladin_rallying_presence" ) and not getProtectingPaladins( ply ) then return end

    bonus.increase = bonus.increase + dmgPercentIncrease
end