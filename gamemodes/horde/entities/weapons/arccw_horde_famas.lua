if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_famas")
    killicon.Add("arccw_horde_famas", "arccw/weaponicons/arccw_go_famas", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_famas"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "FAMAS G1"

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_famas.mdl"

SWEP.Damage = 50
SWEP.DamageMin = 40

SWEP.RecoilRise = 0.4
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 1000
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = -3,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.FirstShootSound = "ArcCW_Horde.GSO.FAMAS_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.FAMAS_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.FAMAS_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

sound.Add( {
    name = "ArcCW_Horde.GSO.FAMAS_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/famas/famas_01.wav",")arccw_go/famas/famas_02.wav",")arccw_go/famas/famas_03.wav",")arccw_go/famas/famas_04.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.FAMAS_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m4a1/m4a1_silencer_01.wav"
} )