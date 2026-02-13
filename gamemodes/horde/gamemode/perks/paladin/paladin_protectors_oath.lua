PERK.PrintName = "Protector's Oath"
PERK.Icon = "materials/perks/paladin/protectors_oath.png"
PERK.Description = [[
Losing a stack of Faith makes you heal all allies inside your Sacred Aura for 2% health.
Divine Shield provides additional 3% to all elemental resistances per Faith stack.]]
PERK.Hooks = {}

local function isElementalDamage( dmginfo )
    if HORDE:IsFireDamage( dmginfo ) then return true end
    if HORDE:IsColdDamage( dmginfo ) then return true end
    if HORDE:IsLightningDamage( dmginfo ) then return true end
    if HORDE:IsPoisonDamage( dmginfo ) then return true end
    if HORDE:IsBlastDamage( dmginfo ) then return true end -- May remove later

    return false
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "paladin_protectors_oath" ) then return end

    if not ply.Horde_PaladinShielding then return end
    if ply:Horde_GetPaladinFaithStack() <= 0 then return end
    if not isElementalDamage( dmginfo ) then return end

    bonus.resistance = bonus.resistance + 0.03
end

local healPercent = 0.02

PERK.Hooks.Horde_Paladin_OnLoseFaith = function( ply )
    if not ply:Horde_GetPerk( "paladin_protectors_oath" ) then return end

    local aura = ply.Horde_PaladinAura
    if not aura then return end

    local entsInside = aura.Entities
    if not entsInside then return end

    for ent, _ in pairs( entsInside ) do
        if IsValid( ent ) and ent:IsPlayer() then
            local healinfo = HealInfo:New( { amount = ent:GetMaxHealth() * healPercent, healer = ply } )
            HORDE:OnPlayerHeal( ent, healinfo )
        end
    end
end