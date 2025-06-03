PERK.PrintName = "Parry"
PERK.Description = "Activating Blade Mode will give you {1} physical resist for {2} second."
PERK.Icon = "materials/perks/samurai/blade_dance.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
	[2] = {value = 1},
}

PERK.Hooks = {}

HORDE:RegisterStatus("Parry", "materials/perks/samurai/blade_dance.png")

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_22" then
	ply.Horde_CheckCyborgDodge = true
     ply.Horde_DoCyborgDodge = nil
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_22" then
        ply.Horde_CheckCyborgDodge = nil
     ply.Horde_DoCyborgDodge = nil
	 timer.Stop( "CyborgNinja_EndDodge" )
	 net.Start("Horde_SyncStatus")
           net.WriteUInt(HORDE.Status_Parry, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
    end
end

PERK.Hooks.PlayerSwitchFlashlight = function (ply, switchOn)
    if not ply:Horde_GetPerk("totikfr_22") then return end
	
	local id = ply:SteamID()
	
    if switchOn then
		timer.Stop( "CyborgNinja_EndDodge" )
        ply.Horde_DoCyborgDodge = true
		net.Start("Horde_SyncStatus")
           net.WriteUInt(HORDE.Status_Parry, 8)
            net.WriteUInt(1, 8)
        net.Send(ply)
		timer.Create("CyborgNinja_EndDodge" .. id, 1, 1, function ()
		ply.Horde_DoCyborgDodge = nil
		net.Start("Horde_SyncStatus")
           net.WriteUInt(HORDE.Status_Parry, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
            end)
		else
		ply.Horde_DoCyborgDodge = nil
		timer.Stop( "CyborgNinja_EndDodge" )
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("totikfr_22")  then return end
	
	if ply:Horde_GetPerk("totikfr_22") and HORDE:IsPhysicalDamage(dmginfo) and ply.Horde_In_Frenzy_Mode and ply.Horde_CheckCyborgDodge and ply.Horde_DoCyborgDodge then
			bonus.resistance = bonus.resistance + 1.0	
			
			local e = EffectData()
        if dmginfo:GetDamagePosition() ~= Vector(0,0,0) then
            e:SetOrigin(dmginfo:GetDamagePosition())
        else
            e:SetOrigin(ply:GetPos() + Vector(0,0,30))
        end
            
        util.Effect("horde_aerial_parry", e, true, true)
        if not silent then
            sound.Play("horde/gadgets/guard" .. tostring(math.random(1,2)) ..".ogg", ply:GetPos(), 125, 100, 1, CHAN_AUTO)
        end
			end
			
			
end

