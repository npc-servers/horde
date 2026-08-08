PERK.PrintName = "Oath of a Sword"
PERK.Icon = "materials/perks/paladin/paladin_oath_of_a_sword.png"
PERK.Description = [[
Increased Melee damage by 25%.
Your melee hits heal 5% health and reduce debuff buildups to all players in aura.
Increase speed by 20%.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus, _, dmginfo )
    if not ply:Horde_GetPerk( "paladin_oath_of_a_sword" ) then return end
    if not HORDE:IsMeleeDamage( dmginfo ) then return end

    bonus.increase = bonus.increase + 0.25
end

local healPercent = 0.05

PERK.Hooks.Horde_OnPlayerDamagePost = function( ply, _, _, _, dmginfo )
    if not ply:Horde_GetPerk( "paladin_oath_of_a_sword" ) then return end
    if not HORDE:IsMeleeDamage( dmginfo ) then return end

    local aura = ply.Horde_PaladinAura
    if not aura then return end

    local entsInside = aura.Entities
    if not entsInside then return end

    for ent, _ in pairs( entsInside ) do
        if IsValid( ent ) and ent:IsPlayer() then
            local healinfo = HealInfo:New( { amount = ent:GetMaxHealth() * healPercent, healer = ply } )
            HORDE:OnPlayerHeal( ent, healinfo )

            for debuff, _ in pairs( ent.Horde_Debuff_Buildup ) do
                ent:Horde_ReduceDebuffBuildup( debuff, 25 )
            end
        end
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function( ply, bonus_walk, bonus_run )
    if not ply:Horde_GetPerk( "paladin_oath_of_a_sword" ) then return end

    bonus_walk.increase = bonus_walk.increase + 0.2
    bonus_run.increase = bonus_run.increase + 0.2
end