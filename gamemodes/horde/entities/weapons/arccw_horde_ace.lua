if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ace")
    killicon.Add("arccw_horde_ace", "arccw/weaponicons/arccw_go_ace", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_ace"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "ACE 22"

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_ace.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_ace.mdl"

SWEP.Damage = 54
SWEP.DamageMin = 44

SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 700

SWEP.ShootSound = "ArcCW_Horde.GSO.ACE_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.ACE_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

sound.Add( {
    name = "ArcCW_Horde.GSO.ACE_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/galilar/galil_01.wav",")arccw_go/galilar/galil_02.wav",")arccw_go/galilar/galil_03.wav",")arccw_go/galilar/galil_04.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.ACE_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m4a1/m4a1_silencer_01.wav"
} )