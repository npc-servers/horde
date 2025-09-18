if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mp5")
    killicon.Add("arccw_horde_mp5", "arccw/weaponicons/arccw_go_mp5", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_mp5"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "MP5A3"

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mp5.mdl"

SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.MP5_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.MP5_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.MP5_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

sound.Add( {
    name = "ArcCW_Horde.GSO.MP5_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = {107, 113},
    sound = ")arccw_go/mp5/mp5_unsil.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.MP5_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/mp5/mp5_01.wav"
} )