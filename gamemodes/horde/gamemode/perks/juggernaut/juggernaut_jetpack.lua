PERK.PrintName = "Jetpack"
PERK.Description = "Press Shift + E to boost yourself forwards into the air. \nGain immunity to fall damage. {2} second cooldown."
PERK.Icon = "materials/perks/specops/smokescreen.png"
PERK.Params = {
    [1] = {value = 0.9, percent = true},
    [2] = {value = 10},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "juggernaut_jetpack" then
        if ply:Horde_GetPerk("juggernaut_jetpack") then
            ply:Horde_SetPerkCooldown(10)
        end
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Smokescreen, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "juggernaut_jetpack" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Smokescreen, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("juggernaut_jetpack") then return end
	
	  local effectdata = EffectData()
    effectdata:SetOrigin(ply:GetPos())
    util.Effect("m2_flame_explosion", effectdata)
	
	sound.Play("juggernaut_jetpack.wav", ply:GetPos())

    local dir = 0.6 * ply:GetForward() + 0.4 * Vector(0,0,1)
    dir:Normalize()
    local vel = dir * 650
    ply:SetLocalVelocity(vel)
  
end

PERK.Hooks.Horde_GetFallDamage = function(ply, speed, bonus)
    if ply:Horde_GetPerk("juggernaut_jetpack") then
        bonus.less = bonus.less * 0
		end
end