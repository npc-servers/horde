GADGET.PrintName = "Barbeque"
GADGET.Description =
[[Kills heal you for {1} of your max health.
Ignited enemies killed by you drop edible gibs.
Each gib restores {2} of your max health.]]
GADGET.Icon = "items/gadgets/barbeque.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
    [1] = { value = 0.05, percent=true },
    [2] = { value = 0.1, percent=true },
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if killer:Horde_GetGadget() ~= "gadget_barbeque" then return end
    
    HORDE:SelfHeal(killer, killer:GetMaxHealth() * 0.05)

    local health = victim:GetMaxHealth()
    for _ = 1, math.min( health / 200, 10 ) do
        local ent = ents.Create("horde_edible_gib")
        local pos = victim:GetPos()
        local drop_pos = pos
        drop_pos = drop_pos + VectorRand() * 5
        drop_pos.z = pos.z + 15
        ent:SetPos(drop_pos)
        ent.Owner = killer
        ent:Spawn()
    end
end
