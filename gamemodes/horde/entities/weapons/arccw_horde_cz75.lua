if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_cz75")
    killicon.Add("arccw_horde_cz75", "arccw/weaponicons/arccw_go_cz75", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_cz75"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "CZ-75"

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_cz75.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_cz75.mdl"

SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.CZ75_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.CZ75_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.CZ75_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

SWEP.Attachments = {
    {},{},{},{},{},
    {
        Offset = {
            vpos = Vector(0, -1.25, 0),
            vang = Angle(90, 0, -90),
        }
    },
}

SWEP.Animations = {
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        Mult = 0.8
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        Mult = 0.8
    },
    ["reload_long"] = {
        Source = "reload_long",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        Mult = 0.8
    },
    ["reload_long_empty"] = {
        Source = "reload_long_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        Mult = 0.8
    },
}

sound.Add( {
    name = "ArcCW_Horde.GSO.CZ75_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/cz75a/cz75_01.wav",")arccw_go/cz75a/cz75_02.wav",")arccw_go/cz75a/cz75_03.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.CZ75_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = {")arccw_go/usp/usp_01.wav",")arccw_go/usp/usp_02.wav",")arccw_go/usp/usp_03.wav"}
} )