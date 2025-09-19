if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_deagle")
    killicon.Add("arccw_horde_deagle", "arccw/weaponicons/arccw_go_deagle", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_deagle"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "Desert Eagle"

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_deagle.mdl"

SWEP.Damage = 134
SWEP.DamageMin = 85

SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 200

SWEP.ShootSound = "ArcCW_Horde.GSO.Deagle_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.Deagle_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

sound.Add( {
    name = "ArcCW_Horde.GSO.Deagle_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/deagle/deagle_01.wav",")arccw_go/deagle/deagle_02.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.Deagle_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/mosin_suppressed_fp.wav"
} )