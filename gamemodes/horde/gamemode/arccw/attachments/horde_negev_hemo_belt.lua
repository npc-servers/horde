if not ArcCWInstalled then return end

AddCSLuaFile()
local att = {}
att.PrintName = "85-Round Razor Belt"
att.Icon = Material("entities/acwatt_go_negev_belt_100.png", "mips smooth")
att.Description = "Experimental Frangible ammunition for the Negev, splits inside the first target causing severe internal trauma at the cost of penetration and immediate lethality\nprobably doesn't adhere to the geneva convention"
att.SortOrder = 100
att.Desc_Pros = {
    "Causes bleed buildup on the first target hit and splits into two projectiles after penetrating"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "go_negev_belt"

att.Override_ClipSize = 85
att.Override_DamageType = DMG_SLASH
att.Mult_RPM = 0.8
att.Mult_Damage = 0.9
att.Mult_DamageMin = 0.9

att.Mult_Penetration = 0.5
att.Mult_Recoil = 1.2

--att.Override_Ammo = "buckshot"

att.Override_Trivia_Calibre = "Experimental 7.62x51mm Razor"

att.Hook_GetShootSound = function(wep, fsound)
    if fsound == "arccw_go/negev/negev_04.wav" then return "weapons/go_negev/negev_shred_01.wav" end
end



if SERVER then
    att.Hook_BulletHit = function(wep, data)
--        local att = data.att

        local tr = data.tr
        local entHit = tr.Entity

        local bulletDmg = data.damage
            if HORDE:IsEnemy(entHit) then
                entHit:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, bulletDmg * 0.5, data.att)
            end
    end
end
att.Hook_PostBulletHit = function(wep, data)
        local tr = data.tr

        local bullet = {
        Damage = wep:GetDamage((tr.HitPos - tr.StartPos):Length() * ArcCW.HUToM),
        DamageType = wep:GetBuff_Override("Override_DamageType") or wep.DamageType,
        Weapon = wep,
        Penetration = wep:GetBuff("Penetration"),
        Attacker = wep:GetOwner(),
        Travelled = (tr.HitPos - tr.StartPos):Length()
    }

    ArcCW:DoPenetration(tr, bullet.Damage, bullet, data.penleft, false, data.alreadypenned)
--atm this so far works as intended, when something is hit, the bullet splits into 2 bullets (the first target doesn't get hit by the second bullet), if this produces any more than 2 total bullets (not counting ricochets), start screaming
end
ArcCW.LoadAttachmentType(att, "horde_negev_hemo_belt")