SPELL.PrintName       = "Raise Phantasm"
SPELL.Weapon          = { "horde_void_projector" }
SPELL.Mind            = { 30, 0 }
SPELL.Price           = 50
SPELL.ChargeTime      = { 0, 0.5 }
SPELL.ChargeRelease   = true
SPELL.Cooldown        = 3
SPELL.Upgrades        = 5
SPELL.Upgrade_Description   = "Increases minion animation speed and damage."
SPELL.Upgrade_Prices        = function( upgrade_level )
    return 550 + 50 * upgrade_level
end
SPELL.Slot            = HORDE.Spell_Slot_RMB
SPELL.DamageType      = { HORDE.DMG_PHYSICAL, HORDE.DMG_COLD }
SPELL.Type            = { HORDE.Spell_Type_Minion }
SPELL.Icon            = "spells/raise_spectre.png"
SPELL.Description     = [[Raises a Phantasm.
Phantasms will explode on death to deal Cold damage and build up Frostbite.
Charge to recall phantasms. Maximum number of Phantasms can be increased by perks related to Spectres.]]
SPELL.Fire = function( ply, _, charge_stage )
    if charge_stage == 2 then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end

        for _, ent in pairs( HORDE.player_drop_entities[ply:SteamID()] ) do
            if ent:IsNPC() and ent:GetClass() == "npc_vj_horde_phantasm" then
                local rand = VectorRand() * 50
                rand.z = 0
                ent:SetPos( ply:GetPos() + rand )
            end
        end

        return
    end

    return HORDE:RaiseSpectre( ply, {
        phantasm_spectre = true
    } )
end