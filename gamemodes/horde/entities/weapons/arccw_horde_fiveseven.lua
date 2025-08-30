if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_fiveseven")
    killicon.Add("arccw_horde_fiveseven", "arccw/weaponicons/arccw_go_fiveseven", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_fiveseven"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "Five-seveN"

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_fiveseven.mdl"

SWEP.Damage = 34
SWEP.DamageMin = 27

SWEP.RecoilPunch = 0

SWEP.ShootSound = "ArcCW_Horde.GSO.FiveSeven_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.FiveSeven_Fire_Sil"
SWEP.DistantShootSound = "ArcCW_Horde.GSO.FiveSeven_Fire_Dist"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

sound.Add( {
    name = "ArcCW_Horde.GSO.FiveSeven_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = {99, 101},
    sound = ")arccw_go/fiveseven/fiveseven_01.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.FiveSeven_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = {")arccw_go/usp/usp_01.wav",")arccw_go/usp/usp_02.wav",")arccw_go/usp/usp_03.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.FiveSeven_Fire_Dist",
    channel = CHAN_WEAPON,
    volume = 0.25,
    level = 140,
    pitch = {99, 101},
    sound = "arccw_go/fiveseven/fiveseven-1-distant.wav"
} )