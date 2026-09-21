if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_nova")
    killicon.Add("arccw_horde_nova", "arccw/weaponicons/arccw_go_nova", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_nova"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "SuperNova"

SWEP.ViewModel = "models/weapons/arccw_go/v_shot_nova.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shot_nova.mdl"

SWEP.Damage = 30
SWEP.DamageMin = 15
SWEP.Penetration = 10

SWEP.NoLastCycle = true

SWEP.Recoil = 1
SWEP.RecoilSide = 1
SWEP.RecoilPunch = 0
SWEP.SpeedMult = 1.05
SWEP.SightedSpeedMult = 0.8
SWEP.ShootVol = 75

SWEP.ShootSound = ")arccw_go/nova/nova-1.wav"
SWEP.ShootSoundSilenced = ")arccw_go/m590_suppressed_fp.wav"
SWEP.DistantShootSound = "^horde/weapons/distant/shotgun_distant.wav"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true}

local reloadMult = 0.75

SWEP.Animations = {
    ["fire"] = {
        Source = "shoot",
        Time = 0.27,
        MinProgress = 0.27,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.27,
        MinProgress = 0.27,
    },
     ["cycle"] = {
        Source = "cycle",
        ShellEjectAt = 0.25,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        Mult = 0.9,
        MinProgress = 0.45
    },
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
        LHIKOut = 1,
        Mult = reloadMult,
    },
    ["sgreload_finish_empty"] = {
        Source = "end_reload_empty",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
        ShellEjectAt = 0.5 * reloadMult,
        Mult = reloadMult,
    },
}