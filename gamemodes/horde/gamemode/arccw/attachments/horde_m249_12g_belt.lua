if not ArcCWInstalled then return end

AddCSLuaFile()
local att = {}

att.PrintName = "45 Round 12G Belt"
att.Icon = Material("entities/acwatt_go_m249_mag_12g_45.png", "mips smooth")
att.Description = "Conversion for the M249, turning it into a 12 gauge automatic shotgun."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.SortOrder = 40
att.AutoStats = true
att.Slot = "go_m249_mag"

att.Override_MuzzleEffect = "muzzleflash_m3"

att.Mult_Range = 0.25
att.Range = 70 -- in METRES
att.MultRangeMin = 0.5
att.Mult_Penetration = 0.3
att.Mult_Recoil = 1.75
att.Mult_RPM = 0.6
att.Mult_AccuracyMOA = 6
att.Override_ClipSize = 45
att.Mult_Damage = 3.5
att.Mult_DamageMin = 1.5
att.Mult_HipDispersion = 1.55

att.Override_Num_Priority = 0.5
att.Override_Num = 8

att.Override_IsShotgun = true

att.Override_Ammo = "buckshot"

att.Override_ShellModel = "models/shells/shell_12gauge.mdl"
att.Override_ShellSounds = ArcCW.ShotgunShellSoundsTable
att.Override_ShellScale = 2

att.Override_Trivia_Class = "Machine Shotgun"
att.Override_Trivia_Calibre = "12 Gauge"
att.ActivateElements = {"go_m249_mag_12g_45"}

att.Override_BulletBones = {
    [1] = "v_weapon.bullet11",
    [2] = "v_weapon.bullet09",
    [3] = "v_weapon.bullet07",
    [4] = "v_weapon.bullet05",
    [5] = "v_weapon.bullet03",
    [6] = "v_weapon.bullet01",
}

att.Hook_GetShootSound = function(wep, fsound)
    if fsound == "arccw_go/m249/m249-1.wav" then return "arccw_go/nova/nova-1.wav" end
    if fsound == "arccw_go/m4a1/m4a1_silencer_01.wav" then return "arccw_go/m590_suppressed_fp.wav" end
end
ArcCW.LoadAttachmentType(att, "horde_m249_12g_belt")
