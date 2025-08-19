PERK.PrintName = "Pain Inhibitors"
PERK.Description = "{1} global damage resistance in Blade Mode. \nReduce debuff buildup by {2}."
PERK.Icon = "materials/perks/nanomachine.png"
PERK.Params = {
    [1] = { value = 0.35, percent = true },
    [2] = { value = 0.5, percent = true },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, _, bonus )
    if not ply:Horde_GetPerk( "cyborg_ninja_pain_inhibitors" ) then return end
    if not ply.Horde_In_Frenzy_Mode then return end

    bonus.resistance = bonus.resistance + 0.35
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function( ply, _, bonus )
    if not ply:Horde_GetPerk( "cyborg_ninja_pain_inhibitors" ) then return end

    bonus.less = bonus.less * 0.5
end





