if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_p90")
    killicon.Add("arccw_horde_p90", "arccw/weaponicons/arccw_go_p90", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_p90"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "P90 TR"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_p90.mdl"

SWEP.Damage = 42
SWEP.DamageMin = 30
SWEP.Penetration = 12

SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.P90_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.P90_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.P90_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

sound.Add( {
    name = "ArcCW_Horde.GSO.P90_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/p90/p90_01.wav",")arccw_go/p90/p90_02.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.P90_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/mp5/mp5_01.wav"
} )