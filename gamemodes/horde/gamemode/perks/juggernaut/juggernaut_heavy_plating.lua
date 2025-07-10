PERK.PrintName = "Heavy Plating"
PERK.Description = [[
+{2} damage block.
+{3} physical damage resistance. Gain immunity to bleeding.]]
PERK.Icon = "materials/perks/liquid_armor.png"
PERK.Params = {
    [1] = { value = 25 },
    [2] = { value = 5 },
    [3] = { value = 0.20, percent = true },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "juggernaut_heavy_plating" ) then return end

    if HORDE:IsPhysicalDamage( dmginfo ) then
       bonus.resistance = bonus.resistance + 0.20
    end

    bonus.block = bonus.block + 5
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function( ply, debuff, bonus )
    if not ply:Horde_GetPerk( "juggernaut_heavy_plating" ) then return end
    if debuff ~= HORDE.Status_Bleeding then return end

    bonus.apply = 0
end