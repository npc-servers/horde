PERK.PrintName = "Sanctuary"
PERK.Icon = "materials/perks/paladin/sanctuary.png"
PERK.Description = [[
Sacred Aura slowly decreases debuff buildups per second.
Divine Shield prevents all players inside Sacred Aura from
taking damage higher than 50% of their health.]]
PERK.Hooks = {}

local function insideAura( ply, insideAuraPly )
    local aura = ply.Horde_PaladinAura
    if not aura then return false end

    local entsInside = aura.Entities
    if not entsInside or not entsInside[insideAuraPly] then return false end

    return true
end

local function getProtectingPaladins( ply )
    for _, auraPly in ipairs( player.GetAll() ) do
        if auraPly:Horde_GetPerk( "paladin_sanctuary" ) and insideAura( auraPly, ply ) then
            return true
        end
    end

    return false
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "paladin_sanctuary" ) then
        local protected = getProtectingPaladins( ply )

        if not protected then return end
    end

    local dmg = dmginfo:GetDamage()
    local maxHP = ply:GetMaxHealth()

    bonus.block = bonus.block + math.max( 0, dmg - maxHP * 0.5 )
end

-- Aura debuff reduction is in paladin_sacred_aura/init