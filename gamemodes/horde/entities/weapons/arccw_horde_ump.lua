if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ump")
    killicon.Add("arccw_horde_ump", "arccw/weaponicons/arccw_go_ump", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_ump"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "UMP-45"

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_ump45.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_ump45.mdl"

SWEP.Damage = 53
SWEP.DamageMin = 43
SWEP.Penetration = 15

SWEP.SpeedMult = 1.03
SWEP.SightedSpeedMult = 0.85

SWEP.RecoilPunch = 0

SWEP.ShootVol = 75

SWEP.FirstShootSound = ")arccw_go/ump45/ump45_02.wav"
SWEP.ShootSound = ")arccw_go/ump45/ump45_02.wav"
SWEP.ShootSoundSilenced = ")arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "^horde/weapons/distant/smg_distant.wav"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)


function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if self:GetBuff_Override("NoStock") then return "fire" end
    elseif anim == "fire_iron_empty" then
        if self:GetBuff_Override("NoStock") then return "fire_empty" end
    end
end

local reloadMult = 0.82
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
        Time = 0.25,
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
        Checkpoints = { 16, 30 },
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        LHIKEaseOut = 0.3,
        Mult = reloadMult,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = { 16, 30, 55 },
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        LHIKEaseOut = 0.3,
        Mult = reloadMult,
    },
}