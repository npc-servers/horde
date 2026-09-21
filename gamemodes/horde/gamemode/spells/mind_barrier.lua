SPELL.PrintName      = "Mind Barrier"
SPELL.Mind           = { 10 }
SPELL.ChargeTime     = { 1.5 }
SPELL.ChargeRelease  = nil
SPELL.Cooldown       = 10
SPELL.Levels         = { Hatcher = 5 }
SPELL.Price          = 600
SPELL.Upgrades       = 2
SPELL.Upgrade_Prices = function()
    return 600
end
SPELL.Slot           = HORDE.Spell_Slot_Utility
SPELL.Icon           = "spells/barrier.png"
SPELL.Type           = { HORDE.Spell_Type_Utility }
SPELL.Description    = "Grants 20 Barrier in a 160hu radius around the caster."
SPELL.Upgrade_Description = "Increases barrier given by 15."

SPELL.Fire = function( ply )
    local level = ply:Horde_GetSpellUpgrade( "mind_barrier" )
    local barrier = 20 + ( 15 * level )
    local plyPos = ply:GetPos()

    ply:EmitSound( "horde/player/life_diffuser.ogg", 100, 100, 1, CHAN_AUTO )

    local effectdata = EffectData()
    effectdata:SetOrigin( plyPos )
    effectdata:SetRadius( 160 )
    util.Effect( "horde_mind_barrier", effectdata, nil, true )

    local nearbyEnts = ents.FindInSphere( plyPos, 160 )

    for i = 1, #nearbyEnts do
        local ent = nearbyEnts[i]

        if ent:IsPlayer() then
            ent:Horde_AddBarrierStack( barrier )
        end
    end
end