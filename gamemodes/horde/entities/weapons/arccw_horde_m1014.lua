if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m1014")
    killicon.Add("arccw_horde_m1014", "arccw/weaponicons/arccw_go_m1014", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_m1014"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "M1014"

SWEP.ViewModel = "models/weapons/arccw_go/v_shot_m1014.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shot_m1014.mdl"

SWEP.Damage = 30
SWEP.DamageMin = 16
SWEP.Penetration = 10

SWEP.Recoil = 2
SWEP.RecoilSide = 1
SWEP.RecoilPunch = 0

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

SWEP.ShootSound = "ArcCW_Horde.GSO.M1014_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.M1014_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true}

SWEP.Animations = {
    ["sgreload_insert"] = {
        Source = "insert",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
        Mult = 0.9
    },
}

sound.Add( {
    name = "ArcCW_Horde.GSO.M1014_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = ")arccw_go/xm1014/xm1014-1.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.M1014_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m590_suppressed_fp.wav"
} )