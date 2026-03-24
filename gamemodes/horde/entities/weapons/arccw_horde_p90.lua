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

SWEP.Damage = 44
SWEP.DamageMin = 36
SWEP.Penetration = 20
SWEP.HoldtypeActive = "revolver"
SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.P90_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.P90_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.P90_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        Time = 1.76,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 1,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        Time = 2.06,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
    },
    ["reload_smallmag"] = {
        Source = "reload_smallmag",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
    },
    ["reload_smallmag_empty"] = {
        Source = "reload_smallmag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
    },
}
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