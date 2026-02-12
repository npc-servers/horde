PERK.PrintName = "Sanctuary"
PERK.Icon = "materials/perks/paladin/sanctuary.png"
PERK.Description = [[
Sacred Aura slowly decreases debuff buildups per second.
When you're using Divine Shield, every player inside your Sacred Aura cannot take more damage than 50% of their health in one instance. ]]
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
        if insideAura( auraPly, ply ) and auraPly:Horde_GetPerk( "horde_sanctuary" ) and auraPly.Horde_PaladinShielding then
            table.insert( protectors, auraPly )
        end
    end

    return protectors
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    local physicalDmg = HORDE:IsPhysicalDamage( dmginfo )
    if not ( physicalDmg or isElementalDamage( dmginfo ) ) then return end
    if dmginfo:GetDamage() <= 0 then return end

    local protectors = getProtectingPaladins( ply )
    if not protectors then return end

    local dmg = dmginfo:GetDamage()
    local maxHP = ply:GetMaxHealth()

    bonus.block = bonus.block + math.max( 0, dmg - maxHP * 0.5 )
end