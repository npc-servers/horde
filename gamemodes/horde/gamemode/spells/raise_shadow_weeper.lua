SPELL.PrintName       = "Raise Weeper Spectre"
SPELL.Weapon          = { "horde_void_projector" }
SPELL.Mind            = { 60, 0 }
SPELL.ChargeTime      = { 0, 0.5 }
SPELL.ChargeRelease   = nil
SPELL.Cooldown        = 11
SPELL.Slot            = HORDE.Spell_Slot_Reload
SPELL.DamageType      = { HORDE.DMG_COLD }
SPELL.Type            = { HORDE.Spell_Type_Minion }
SPELL.Icon            = "spells/raise_shadow_hulk.png"
SPELL.Description     = [[Raises a Weeper Spectre created using dark matter. Weeper Spectre will attack nearby enemies with a frost nova, dealing Cold damage and inflicting Frostbite. You can create at most 1 Weeper Spectre.]]
SPELL.Fire            = function( ply, _, charge_stage )
    if charge_stage == 2 then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end

        for _, ent in pairs( HORDE.player_drop_entities[ply:SteamID()] ) do
            if ent:IsNPC() and ent:GetClass() == "npc_vj_horde_shadow_weeper" then

                local rand = VectorRand() * 50
                rand.z = 0
                ent:SetPos( ply:GetPos() + rand )

            end
        end

        return
    end

    return HORDE:RaiseSpectre( ply, {
        weeper_spectre = true
    } )
end
SPELL.Price                 = 1500
SPELL.Upgrades              = 3
SPELL.Upgrade_Description   = "Increases minion health and frost nova / melee damage."
SPELL.Upgrade_Prices        = function( upgrade_level )
    return 800 + 100 * upgrade_level
end