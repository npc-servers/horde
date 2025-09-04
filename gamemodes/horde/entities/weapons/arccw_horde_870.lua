if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_870")
    killicon.Add("arccw_horde_870", "arccw/weaponicons/arccw_go_870", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_870"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "Model 870"

SWEP.ViewModel = "models/weapons/arccw_go/v_shot_870.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shot_870.mdl"

SWEP.Damage = 28
SWEP.DamageMin = 12
SWEP.Penetration = 10

SWEP.NoLastCycle = true

SWEP.Recoil = 1.5
SWEP.RecoilSide = 1
SWEP.RecoilPunch = 0

SWEP.ShootSound = "ArcCW_Horde.GSO.M870_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.M870_Fire_Sil"
SWEP.DistantShootSound = "ArcCW_Horde.GSO.M870_Fire_Dist"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true}

SWEP.Animations = {
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
        MinProgress = 0.5
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.5,
        MinProgress = 0.5
    },
    ["sgreload_insert"] = {
        Source = "insert",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
        Mult = 0.95
    },
    ["sgreload_finish_empty"] = {
        Source = "end_reload_empty",
        ShellEjectAt = 0.6,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1
    },
}

sound.Add( {
    name = "ArcCW_Horde.GSO.M870_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = ")arccw_go/sawedoff/sawedoff-1.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.M870_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m590_suppressed_fp.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.M870_Fire_Dist",
    channel = CHAN_WEAPON,
    volume = 0.25,
    level = 140,
    pitch = 100,
    sound = "arccw_go/sawedoff/sawedoff-1-distant.wav"

} )
