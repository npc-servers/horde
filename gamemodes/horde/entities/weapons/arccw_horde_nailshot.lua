SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Arccw - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Perforator"
SWEP.TrueName = "Vlad the Impaler"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "A nailgun heavily modified to shoot nails like an auto-shotgun. Nails have enough velocity to pierce, but suffers from high scatter."
SWEP.Trivia_Manufacturer = "DutyTool (modified by T.E.A.R)"
SWEP.Trivia_Calibre = "Nails"
SWEP.Trivia_Mechanism = "Locking Block"
SWEP.Trivia_Country = "UK"
SWEP.Trivia_Year = 2008

SWEP.Slot = 3

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
end

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_kf_vlad.mdl"
SWEP.WorldModel = "models/horde/weapons/w_kf_vlad.mdl"
SWEP.MirrorVMWM = false
SWEP.WorldModelOffset = {
    pos        =    Vector(4, 1, -2),
    ang        =    Angle(-6, -2.5, 180),
    bone    =    "ValveBiped.Bip01_R_Hand",
}
SWEP.ViewModelFOV = 70


SWEP.Damage = 30
SWEP.DamageMin = 15 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 13
SWEP.DamageType = DMG_SLASH
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1500 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 8
SWEP.ReducedClipSize = 4

SWEP.Recoil = 2
SWEP.RecoilSide = 1
SWEP.VisualRecoilMult = 1
SWEP.RecoilRise = 2

SWEP.Delay = 60 / 300 -- 60 / RPM.
SWEP.Num = 12 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
        PrintName = "Auto"
    },
    {
        Mode = 1,
        PrintName = "Semi"
    },
}

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 75

SWEP.AccuracyMOA = 95 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "XBowBolt" -- what ammo type the gun uses

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "weapons/kf_vlad/kf_nailshotgun_fire_s.wav"
SWEP.ShootSoundSilenced = "weapons/kf_vlad/kf_nailshotgun_fire_alt_s.wav"
SWEP.DistantShootSound = "arccw_go/ssg08/ssg08-1-distant.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SightTime = 0.175

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.8

SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(0, 2.2, -0.32),
    Ang = Angle(-0, 0, 0),
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(3.5, 2, -1.2)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(-2, -7.145, -11.561)
SWEP.HolsterAng = Angle(36.533, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(12, -8, -4.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)


SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Charms",
        Slot = "charm",
        Bone = "NailGun",
        Offset = {
            vpos = Vector(-2.5, -6.5, 3),
            vang = Angle(0, 90, 15),
            wpos = Vector(7, 2, -4.5),
            wang = Angle(-5, 1, 180)
        },
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
}

SWEP.Animations = {
    ["idle"] = {
    Source = "idle",
    Time = 10,
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.5,
        SoundTable = {
            {
            s = "weapons/arccw/draw_secondary.wav",
            t = 0
            }
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire"] = {
        Source = "Fire",
        Time = 1.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "Fire_Ads",
        Time = 1,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 2.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.2,
                SoundTable = {
            {s = "ArcCW_KF1.Vlad_Out", t = 0.25},
            {s = "ArcCW_KF1.Vlad_In", t = 1.5}
        },
    },
}
sound.Add( {
    name = "ArcCW_KF1.Vlad_Out",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")weapons/kf_vlad/vlad9000_mag_eject.wav"
} )
sound.Add( {
    name = "ArcCW_KF1.Vlad_In",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")weapons/kf_vlad/vlad9000_mag_insert.wav"
} )