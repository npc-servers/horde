PERK.PrintName = "Paladin Base"
PERK.Description = [[
Paladin is a durable melee fighter, using his shield to protect allies or his holy power to banish enemies.
COMPLEXITY: MEDIUM

{1} Increased Melee and Lightning damage dealt (1% per level, up to 25%)
Health and Armor increased to 150.
Immunity to Poison/Break.

- Divine Shield:
Passively you regenerate Faith stacks, one per 2 seconds.
You can have up to 10 stacks.
Divine Shield provides high damage resistances when you have at least 1 Faith stack.
Divine Shield reduces Physical damage taken by 50% and other types of damage taken by 25%.
Divine Shield reduces your movement speed by 20%.
Taking Physical damage makes you lose 1 Faith stack.
When you don't have Faith stacks, you lose damage reduction provided by Divine Shield.

- Sacred Aura:
You're surrounded with yellow-colore zone.
Every time you lose Faith stack (only by taking Physical damage), heal all players inside your aura by 3% health.

Has only access to melee weapons.]]

PERK.Params = {
    [1] = { percent = true, base = 0, level = 0.01, max = 0.25, classname = "Paladin" },
}
PERK.Hooks = {}

if not SERVER then return end

local faithRegen = 2
local SHIELDING_TIMER_NAME = "Horde_PaladinShielding"

local function createFaithTimer( ply )
    local timerName = SHIELDING_TIMER_NAME .. ply:SteamID64()
    timer.Create( timerName, faithRegen, 0, function()
        if not IsValid( ply ) then
            timer.Remove( timerName )

            return
        end

        ply:Horde_AddPaladinFaithStack()
    end )
end

local function removeFaithTimer( ply )
    local timerName = SHIELDING_TIMER_NAME .. ply:SteamID64()
    if timer.Exists( timerName ) then
        timer.Remove( timerName )
    end
end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "paladin_base" then return end

    ply:Horde_AddPaladinAura()
    createFaithTimer( ply )
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk ~= "paladin_base" then return end

    ply:Horde_RemovePaladinAura()
    removeFaithTimer( ply )
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function( ply )
    ply:Horde_SetPerkLevelBonus( "paladin_base", math.min( 0.25, 0.01 * ply:Horde_GetLevel( "Paladin" )))
    ply:Horde_SetPerkLevelBonus( "paladin_base_auraradius", 1.5 )
end

PERK.Hooks.Horde_OnSetMaxArmor = function ( ply, bonus )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end

    bonus.increase = bonus.increase + 0.5
end

PERK.Hooks.Horde_OnSetMaxHealth = function( ply, bonus )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end

    bonus.add = bonus.add + 50
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end

    if ply:Horde_GetPaladinFaithStack() > 0 then
        bonus.resistance = bonus.resistance + 0.25

        if HORDE:IsPhysicalDamage( dmginfo ) then
            bonus.resistance = bonus.resistance + 0.25

            if dmginfo:GetDamage() > 0 then
                ply:Horde_RemovePaladinFaithStack()
            end
        end
    end

    if HORDE:IsPoisonDamage( dmginfo ) then
        bonus.resistance = bonus.resistance + 1.0

        return
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function ( ply, npc, bonus, _, dmginfo )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end
    if not HORDE:IsMeleeDamage( dmginfo ) then return end
    if not HORDE:IsLightningDamage( dmginfo ) then return end

    bonus.more = bonus.more * ply:Horde_GetPerkLevelBonus( "paladin_base" )
end

PERK.Hooks.Horde_PlayerMoveBonus = function( ply, bonus_walk, bonus_run )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end
    if ply:Horde_GetPaladinFaithStack() <= 0 then return end

    bonus_walk.increase = bonus_walk.increase - 0.2
    bonus_run.increase = bonus_run.increase - 0.2
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function( ply, debuff, bonus )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end
    if debuff ~= HORDE.Status_Break then return end

    bonus.apply = 0

    return true
end

local healPercent = 0.03

PERK.Hooks.Horde_Paladin_OnLoseFaith = function( ply )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end

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