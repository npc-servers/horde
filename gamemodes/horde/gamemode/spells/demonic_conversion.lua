SPELL.PrintName       = "Demonic Conversion"
SPELL.Weapon          = {"horde_void_projector"}
SPELL.Mind            = {10}
SPELL.ChargeTime      = {0}
SPELL.ChargeRelease   = true
SPELL.Cooldown        = 10
SPELL.Slot            = HORDE.Spell_Slot_Utility
SPELL.DamageType      = nil
SPELL.Icon            = "spells/demonic_conversion.png"
SPELL.Type           = {HORDE.Spell_Type_Minion, HORDE.Spell_Type_Utility}
SPELL.Description     = [[Instantly kills a non-elite target and converts it into a Spectre returning half the Mind Cost of a Spectre to you upon a successful cast if your Mind is below 90%.
If you have Raise Greater Spectre equipped, a Greater Spectre will be spawned instead and only returns Mind when your Mind is below 80%.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    local filter = {ply}
    local tr = util.TraceLine({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:GetAimVector() * 1000,
        filter = filter,
        mask = MASK_SHOT_HULL
    })
    if !IsValid(tr.Entity) or not HORDE:IsEnemy(tr.Entity) then return true end
    if tr.Entity:Horde_IsElite() then return true end

    if ply.Horde_drop_entities["npc_vj_horde_spectre"] and ply.Horde_drop_entities["npc_vj_horde_spectre"] >= (ply.Horde_Spectre_Max_Count) then
        return true
    end

    tr.Entity:TakeDamage(tr.Entity:GetMaxHealth() + 1, ply, ply)

    local param = {}
    if ply:Horde_HasSpell("raise_greater_spectre") then
        param.greater_spectre = true
		ply:Horde_SetMind( math.min( ply:Horde_GetMaxMind(), 22 + ply:Horde_GetMind() ) )
		elseif ply:Horde_HasSpell("raise_greater_spectre") and ply:Horde_GetMind() >= 80 then
		param.greater_spectre = true
    end
	if ply:Horde_HasSpell("raise_spectre") then
        param.spectre = true
		ply:Horde_SetMind( math.min( ply:Horde_GetMaxMind(), 15 + ply:Horde_GetMind() ) )
		elseif ply:Horde_HasSpell("raise_spectre") and ply:Horde_GetMind() >= 90 then
		param.spectre = true
    end
    HORDE:RaiseSpectre(ply, param, tr.Entity:GetPos())
    sound.Play("horde/weapons/void_projector/devour.ogg", tr.Entity:GetPos(), 150, 100)
end
SPELL.Price = 750