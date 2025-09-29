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

local reloadMult = 0.6

SWEP.Animations = {
    ["sgreload_start"] = {
        Source = "start_reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        Mult = reloadMult,
    },
    ["sgreload_insert"] = {
        Source = "insert",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
        Mult = reloadMult,
    },
    ["sgreload_finish"] = {
        Source = "end_reload",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.2,
        Mult = reloadMult,
    },
    ["sgreload_finish_empty"] = {
        Source = "end_reload_empty",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.2,
        Mult = reloadMult,
    }
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
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {100, 105},
    sound = ")arccw_go/m590_suppressed_fp.wav"
} )