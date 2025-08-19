PERK.PrintName = "Iron Faith"
PERK.Description = "Kills grant yourself and nearby players {4} of their max armor. \nPlayers with Mind will be restored {1} of their max Mind instead."
PERK.Icon = "materials/perks/reverend/iron_faith.png"
PERK.Params = {
    [1] = { value = 0.1, percent = true },
    [2] = { value = 0.20, percent = true },
    [3] = { value = 2 },
    [4] = { value = 0.02, percent = true },
    [5] = { value = 0.2, percent = true },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyKilled = function( _, killer, _ )
    if not killer:Horde_GetPerk( "reverend_iron_faith" ) then return end

    for _, ent in pairs( ents.FindInSphere( killer:GetPos(), 250 ) ) do
        if ent:IsValid() and ent:IsPlayer() and ent:Alive() then
            local armor = ent:Armor()
            local maxArmor = ent:MaxArmor()
            if armor < maxArmor and maxArmor > 0 then
                ent:SetArmor( math.min( MaxArmor, armor + maxArmor * 0.02 ) )
            end

            local maxMind = ent:Horde_GetMaxMind()
            if maxMind > 0 then
                local mind = ent:Horde_GetMind()
                ent:Horde_SetMind( maxMind, mind + maxMind * 0.1 )
            end
        end
    end
end