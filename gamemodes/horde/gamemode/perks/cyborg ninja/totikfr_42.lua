PERK.PrintName = "Ripper Mode"
PERK.Description = [[
Unlocks Ripper Mode (Shift+E). Requires full armor to activate.
While in Ripper mode, you deal 100% more damage, damage will build up Bleeding, 
and gain 35% speed boost. Battery drains while active.]]
PERK.Icon = "materials/perks/bloodlust.png"
PERK.Params = {
    [1] = {value = 2, percent = true},
}

PERK.Hooks = {}

HORDE:RegisterStatus("Ripper_Mode", "materials/perks/bloodlust.png", nil, nil, true)
HORDE:RegisterStatus("Jack", "materials/perks/graceful_guard.png")

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_42" then
        ply:Horde_SetPerkCooldown(1)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Ripper_Mode, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_42" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Ripper_Mode, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end


PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("totikfr_42") then return end
	if ply.Horde_In_Frenzy_Mode or ply.Horde_Ripper_Mode or ply.Horde_Ripper_Mode or ply:Armor()<ply:GetMaxArmor() then 
	ply:EmitSound("items/suitchargeno1.wav")
	return end


ply.ripperMode = true
ply.Horde_Ripper_Mode = true
net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Jack, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
sound.Play("horde/status/shock_trigger.ogg", ply:GetPos())
ply:ScreenFade(SCREENFADE.STAYOUT, Color(180, 0, 0, 50), 0.2, 5)
ply.ripperTimer=CurTime()

--timer.Simple(5, function() ripperMode = false ply:ScreenFade(SCREENFADE.PURGE, Color(60, 60, 200, 0), 0.1, 0.1) end)

return false
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("totikfr_42") then return end
	if not ply.ripperMode then return end
    if HORDE:IsMeleeDamage(dmginfo) then
        bonus.more = bonus.more * 2
		npc:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, dmginfo:GetDamage() * 0.5, ply, dmginfo:GetDamagePosition())
    end
end


PERK.Hooks.PlayerTick = function (ply, mv)
	if not ply:Horde_GetPerk("totikfr_42") then return end
	if SERVER then
    if ply.ripperMode and CurTime() >= ply.ripperTimer then
        ply:SetArmor(math.max(0, ply:Armor() - 1))
        ply.ripperTimer = CurTime() + 0.2
    end
	if ply:Armor()<1 then
        ply.ripperMode = false
		ply.Horde_Ripper_Mode = nil
		net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Jack, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
        ply:ScreenFade(SCREENFADE.PURGE, Color(60, 60, 200, 0), 0.1, 0.1)
	end
	end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("totikfr_42") then return end
	if ply.Horde_Ripper_Mode then
    bonus_walk.increase = bonus_walk.increase + 0.35
    bonus_run.increase = bonus_run.increase + 0.35
	end
end
