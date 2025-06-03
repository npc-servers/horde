PERK.PrintName = "Rifle Mechanism"
PERK.Description =
[[Unlocks a Special Attack (Shift + E).
Perform an attack that deals 1000 Physical damage.
15 second cooldown.]]
PERK.Icon = "materials/perks/samurai/focus_slash.png"

PERK.Hooks = {}

HORDE:RegisterStatus("Rifle_Mechanism", "materials/perks/samurai/focus_slash.png", nil, nil, true)

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_41" then
        ply:Horde_SetPerkCooldown(15)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Rifle_Mechanism, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_41" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Rifle_Mechanism, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end


PERK.Hooks.Horde_UseActivePerk = function (ply, dmginfo)
    if not ply:Horde_GetPerk("totikfr_41") then return end	
	
    local ent = util.TraceLine(util.GetPlayerTrace(ply)).Entity
	local startpos = util.TraceLine(util.GetPlayerTrace(ply)).StartPos
	local hitpos = util.TraceLine(util.GetPlayerTrace(ply)).HitPos
	local distance = math.sqrt((hitpos.x - startpos.x)^2 + (hitpos.y - startpos.y)^2 + (hitpos.z - startpos.z)^2)
	
	if not ent:IsValid() or distance > 196 then
	ply:EmitSound("items/suitchargeno1.wav")
	ply:Horde_SetPerkCooldown(1)
	return end

    if ent:IsValid() and ent:IsNPC() then --no way this thing works
		if distance <= 196 then
		sound.Play("horde/weapons/katana/melee_katana_02.ogg", ply:GetPos())
		ply:Horde_SetPerkCooldown(15)
		
		local fx = EffectData()
		fx:SetOrigin(hitpos)
		util.Effect("BloodImpact", fx)
		
		
		local dmginfo = DamageInfo()
                        dmginfo:SetDamage(1000)
                        dmginfo:SetAttacker(ply)
                        dmginfo:SetInflictor(ply)
                        dmginfo:SetDamagePosition(ent:GetPos())
                        dmginfo:SetDamageType(DMG_CRUSH)
                        ent:TakeDamageInfo(dmginfo)
						
		--ent:TakeDamage(1000, ply)
	--	return true
		end
	end
--return true
end
