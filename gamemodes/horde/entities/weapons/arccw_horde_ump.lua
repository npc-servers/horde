if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ump")
    killicon.Add("arccw_horde_ump", "arccw/weaponicons/arccw_go_ump", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_ump"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "UMP-45"

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_ump45.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_ump45.mdl"

SWEP.Damage = 38
SWEP.DamageMin = 28

SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.UMP_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.UMP_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.UMP_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

sound.Add( {
    name = "ArcCW_Horde.GSO.UMP_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = ")arccw_go/ump45/ump45_02.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.UMP_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/mp5/mp5_01.wav"
} )