if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "7.62x51mm NATO Conversion"
att.AbbrevName = "Conversion Kit"
att.Icon = Material("entities/acwatt_go_ak_mag_15_545.png", "mips smooth")
att.Description = "7.62x51mm NATO conversion for the M14."
att.SortOrder = 15
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = false
att.Slot = "ammo_m14"

att.Override_ClipSize = 8
att.Override_Ammo = "ar2"

att.Mult_Recoil = 2
att.Mult_RPM = 0.5

att.Mult_Damage = 1.72
att.Mult_DamageMin = 1.50
att.Mult_Range = 1.5
att.Mult_Penetration = 1.15

att.Override_Trivia_Calibre = "7.62x51mm NATO"

att.Hook_GetShootSound = function(wep, fsound) return ")weapons/fesiugmw2/fire/m14.wav" end
att.Hook_GetShootMechSound = function(wep, msound) return ArcCW_MW2_Mech end
att.Hook_GetShootSoundExt = function(wep, msound) return "" end
att.Hook_GetShootSoundExtExt = function(wep, msound) return "" end

ArcCW.LoadAttachmentType(att, "bo1_m14_762_conversion")