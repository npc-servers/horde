if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mac10")
    killicon.Add("arccw_horde_mac10", "arccw/weaponicons/arccw_go_mac10", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_mac10"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "MAC-10"

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mac10.mdl"

SWEP.Damage = 32
SWEP.DamageMin = 20

SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.MAC10_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.MAC10_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.MAC10_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

sound.Add( {
    name = "ArcCW_Horde.GSO.MAC10_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/mac10/mac10_01.wav",")arccw_go/mac10/mac10_02.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.MAC10_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/mp5/mp5_01.wav"
} )