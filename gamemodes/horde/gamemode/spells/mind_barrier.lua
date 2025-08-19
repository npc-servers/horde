SPELL.PrintName      = "Mind Barrier"
SPELL.Mind           = { 10 }
SPELL.ChargeTime     = { 0 }
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

local BARRIER_UPGRADES = {
    [0] = 20,
    [1] = 35,
    [2] = 50,
}

if SERVER then
    util.AddNetworkString( "horde_mind_barrier_effect" )
end

SPELL.Fire = function( ply )
    local level = ply:Horde_GetSpellUpgrade( "mind_barrier" )
    local plyPos = ply:GetPos()

    net.Start( "horde_mind_barrier_effect" )
        net.WriteVector( plyPos )
    net.Broadcast()

    ply:EmitSound( "horde/player/life_diffuser.ogg", 100, 100, 1, CHAN_AUTO )

    local nearbyEnts = ents.FindInSphere( plyPos, 160 )
    for _, ent in ipairs( nearbyEnts ) do
        if ent:IsPlayer() then
            ent:Horde_AddBarrierStack( BARRIER_UPGRADES[level] )
        end
    end
end

if CLIENT then
    net.Receive( "horde_mind_barrier_effect", function()
        local pos = net.ReadVector()
        local effectdata = EffectData()
        effectdata:SetOrigin( pos )
        effectdata:SetRadius( 160 )
        util.Effect( "horde_mind_barrier", effectdata )
    end )
end