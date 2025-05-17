GADGET.PrintName = "Proximity Defense"
GADGET.Description = "Triggers an explosion that deals {1} Blast damage and stuns nearby enemies."
GADGET.Icon = "items/gadgets/proximity_defense.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
    [1] = { value = 300 },
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_proximity_defense" then return end
    local effectdata = EffectData()
    effectdata:SetOrigin(ply:GetPos())
    util.Effect("Explosion", effectdata)
    ply:EmitSound("phx/kaboom.wav", 125, 100, 1, CHAN_AUTO)
	
    local dmg = DamageInfo()
    dmg:SetAttacker(ply)
    dmg:SetInflictor(ply)
    dmg:SetDamageType(DMG_BLAST)
    dmg:SetDamage(300)
    dmg:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
    util.BlastDamageInfo(dmg, ply:GetPos(), 225)

    for _, ent in pairs(ents.FindInSphere(ply:GetPos(), 225)) do
        if ent:IsNPC() then
            ent:Horde_AddDebuffBuildup(HORDE.Status_Stun, 1000, ply, ent:GetPos())
        end
    end
end