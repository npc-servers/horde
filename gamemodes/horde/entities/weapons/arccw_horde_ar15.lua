if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ar15")
    killicon.Add("arccw_horde_ar15", "arccw/weaponicons/arccw_go_ar15", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_ar15"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "AR-15"

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_car15.mdl"

SWEP.Damage = 42
SWEP.DamageMin = 32

SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 725
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.FirstShootSound = "ArcCW_Horde.GSO.AR15_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.AR15_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.AR15_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

sound.Add( {
    name = "ArcCW_Horde.GSO.AR15_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/m4a1/m4a1_us_01.wav",")arccw_go/m4a1/m4a1_us_02.wav",")arccw_go/m4a1/m4a1_us_03.wav",")arccw_go/m4a1/m4a1_us_04.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.AR15_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m4a1/m4a1_silencer_01.wav"
} )