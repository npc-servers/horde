if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_bizon")
    killicon.Add("arccw_horde_bizon", "arccw/weaponicons/arccw_go_bizon", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_bizon"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "PP-19 Bizon-2"

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_bizon.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_bizon.mdl"

SWEP.Damage = 46
SWEP.DamageMin = 33

SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 750

SWEP.FirstShootSound = "ArcCW_Horde.GSO.Bizon_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.Bizon_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.Bizon_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip"] = true, ["go_foregrip_angled"] = true, ["go_foregrip_ergo"] = true, ["go_foregrip_snatch"] = true, ["go_foregrip_stubby"] = true}

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
        Source = "shoot_iron",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        Time = 2.15,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.4,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        Time = 2.5,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.4,
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add( {
    name = "ArcCW_Horde.GSO.Bizon_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/bizon/bizon_01.wav",")arccw_go/bizon/bizon_02.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.Bizon_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/mp5/mp5_01.wav"
} )