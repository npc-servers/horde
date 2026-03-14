PERK.PrintName = "Protector's Oath"
PERK.Icon = "materials/perks/paladin/protectors_oath.png"
PERK.Description = [[
Losing Faith stacks heals you and all allies inside your Sacred Aura by 2% health.
Divine Shield provides 3% to all elemental resistances per Faith stack.
Regenerate Faith stacks even while using Divine Shield.]]
PERK.Hooks = {}

if not SERVER then return end

local horde = HORDE
local horde_IsFireDamage = horde.IsFireDamage
local horde_IsColdDamage = horde.IsColdDamage
local horde_IsLightningDamage = horde.IsLightningDamage
local horde_IsPoisonDamage = horde.IsPoisonDamage
local horde_IsBlastDamage = horde.IsBlastDamage

local function isElementalDamage( dmginfo )
    if horde_IsFireDamage( horde, dmginfo ) then return true end
    if horde_IsColdDamage( horde, dmginfo ) then return true end
    if horde_IsLightningDamage( horde, dmginfo ) then return true end
    if horde_IsPoisonDamage( horde, dmginfo ) then return true end
    if horde_IsBlastDamage( horde, dmginfo ) then return true end -- May remove later

    return false
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "paladin_protectors_oath" ) then return end

    if not ply.Horde_PaladinShielding then return end
    if ply:Horde_GetPaladinFaithStack() <= 0 then return end
    if not isElementalDamage( dmginfo ) then return end

    local faith = ply:Horde_GetPaladinFaithStack()

    bonus.resistance = bonus.resistance + faith * 0.03
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