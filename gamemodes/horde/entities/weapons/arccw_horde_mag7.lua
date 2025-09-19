if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mag7")
    killicon.Add("arccw_horde_mag7", "arccw/weaponicons/arccw_go_mag7", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_mag7"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "MAG-7"

SWEP.ViewModel = "models/weapons/arccw_go/v_shot_mag7.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shot_mag7.mdl"

SWEP.Damage = 16
SWEP.DamageMin = 6
SWEP.Penetration = 10

SWEP.NoLastCycle = true

SWEP.Recoil = 2
SWEP.RecoilSide = 1.5
SWEP.RecoilPunch = 0

SWEP.ShootSound = "ArcCW_Horde.GSO.MAG7_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.MAG7_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if not self.Attachments[7].Installed then return "fire" end
    end
end

SWEP.Animations = {
    ["fire"] = {
        Source = "shoot",
        Time = 0.3,
        MinProgress = 0.3
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.3,
        MinProgress = 0.3
    },
    ["cycle"] = {
        Source = "cycle",
        ShellEjectAt = 0.1,
        Time = 0.5,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        ShellEjectAt = 1.8,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1,
        LHIKEaseOut = 0.35
    },
    ["reload_longmag_empty"] = {
        Source = "reload_longmag_empty",
        ShellEjectAt = 1.8,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1,
        LHIKEaseOut = 0.35
    },
}

sound.Add( {
    name = "ArcCW_Horde.GSO.MAG7_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/mag7/mag7_01.wav",")arccw_go/mag7/mag7_02.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.MAG7_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m590_suppressed_fp.wav"
} )