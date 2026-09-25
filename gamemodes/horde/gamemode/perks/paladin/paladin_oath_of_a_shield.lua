PERK.PrintName = "Oath of a Shield"
PERK.Icon = "materials/perks/paladin/oath_of_a_shield.png"
PERK.Description = [[
Gain 2 damage block.
Taking Physical damage deflect 300% of it to attacker as Shock damage.
Losing Faith stack has 33% chance to immediately regain it.]]
PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "paladin_oath_of_a_shield" ) then return end

    bonus.block = bonus.block + 2

    local attacker = dmginfo:GetAttacker()
    if not IsValid( attacker ) then return end
    if attacker:IsPlayer() then return end

    if dmginfo:GetDamage() <= 0 then return end
    if not HORDE:IsPhysicalDamage( dmginfo ) then return end

    local dmgTaken = dmginfo:GetDamage()

    local dmg = DamageInfo()
    dmg:SetAttacker( ply )
    dmg:SetInflictor( ply )
    dmg:SetDamageType( DMG_SHOCK )
    dmg:SetDamage( dmgTaken * 3 )
    attacker:TakeDamageInfo( dmg )
end

PERK.Hooks.Horde_Paladin_OnLoseFaith = function( ply )
    if not ply:Horde_GetPerk( "paladin_oath_of_a_shield" ) then return end

    local faithChance = 0.33
    local faithRng = math.random()

    if faithRng <= faithChance then
        ply:Horde_AddPaladinFaithStack()
    end
end