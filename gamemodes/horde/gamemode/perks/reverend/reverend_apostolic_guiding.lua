PERK.PrintName = "Apostolic Guiding"
PERK.Description = "Healing players gives barrier equal to the amount healed. \nRegenerate {3} health per second."
PERK.Icon = "materials/perks/reverend/apostolic_guiding.png"
PERK.Params = {
[1] = { value = 0.5, percent = true },
[2] = { value = 1, percent = true },
[3] = { value = 0.02, percent = true },
[4] = { value = 10 },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if SERVER and perk == "reverend_apostolic_guiding" then
        ply:Horde_SetHealthRegenPercentage( 0.02 )
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if SERVER and perk == "reverend_apostolic_guiding" then
        ply:Horde_SetHealthRegenPercentage( 0 )
    end
end

PERK.Hooks.Horde_OnPlayerHeal = function( ply, healinfo )
    local healer = healinfo:GetHealer()
    if not healer:IsPlayer() or not healer:Horde_GetPerk( "reverend_apostolic_guiding" ) then return end

    ply:Horde_AddBarrierStack( healinfo:GetHealAmount() )
end