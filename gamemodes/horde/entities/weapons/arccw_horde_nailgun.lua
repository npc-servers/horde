AddCSLuaFile()

SWEP.Base = "arccw_base"

SWEP.Slot = 2

SWEP.Spawnable = true
SWEP.Category = "ArcCW: Horde"
SWEP.NeverPhysBullet = true
SWEP.PrintName = "Nailgun"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "Power tool modified to fire nails without attaching it to a surface. Nails have no damage dropoff, at the cost of low velocity."
SWEP.Trivia_Manufacturer = "DutyTool"
SWEP.Trivia_Calibre = "Steel Nail"
SWEP.SubCategory = "Sub-Machine Guns"

SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models//horde/weapons/c_nailgun.mdl"
SWEP.WorldModel = "models/horde/weapons/w_nailgun.mdl"
SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 70
SWEP.MirrorVMWM = false

SWEP.Primary.Ammo = "XbowBolt"
SWEP.NoHideLeftHandInCustomization = false

SWEP.Firemodes = {
    { Mode = 2 },
    { Mode = 0 },
}

SWEP.CustomizePos = Vector( 9.824, 0, -4.897 )
SWEP.CustomizeAng = Angle( 12.149, 30.547, 0 )

SWEP.HolsterPos = Vector( 0.5, 3, 1.2 )
SWEP.HolsterAng = Angle( -8.5, 8, -10 )

SWEP.ActivePos = Vector( -1.651, 0.5, 0.5 )
SWEP.ActiveAng = Angle( 0, 0, 0 )

SWEP.SprintPos = Vector( -1.651, 0.5, 0.5 )
SWEP.SprintAng = Angle( -18, 0, 0 )

SWEP.IronSightStruct = {
        Pos = Vector( -3.8, 0, -0.6 ),
        Ang = Angle( 5.63, 0, 2 ),
    Midpoint = {
        Pos = Vector( 0, 15, -4 ),
        Ang = Angle( 0, 0, -45 ),
    },
    Magnification = 1,
}

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.85
SWEP.ShootSpeedMult = 1

SWEP.SightTime = 0.1

SWEP.AccuracyMOA = 25
SWEP.HipDispersion = 200
SWEP.MoveDispersion = 250
SWEP.SightsDispersion = 1
SWEP.JumpDispersion = 300

SWEP.Damage = 0
SWEP.DamageMin = 0
SWEP.DamageType = DMG_SLASH
SWEP.Range = 75
SWEP.ShootEntity = "projectile_horde_nail"
SWEP.MuzzleVelocity = 3000
SWEP.Recoil = 0.55
SWEP.RecoilSide = 0.35
SWEP.RecoilRise = 0.45
SWEP.MaxRecoilBlowback = -1
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0.5
SWEP.RecoilPunchBackMax = 1
SWEP.RecoilPunchBackMaxSights = nil
SWEP.RecoilVMShake = 0.2
SWEP.Sway = 0.2
SWEP.Delay = 55 / 508

SWEP.TracerNum = 1
SWEP.TracerFinalMag = 0
SWEP.Tracer = "arccw_tracer"
SWEP.TracerCol = Color( 255, 255, 255 )
SWEP.MuzzleEffect = "muzzleflash_suppressed"
SWEP.NoShellEject = true
SWEP.ShootSound = ")weapons/sm_nailgun/nailgun_fire.wav"

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 45

SWEP.MuzzleEffectAttachment = 1
SWEP.CaseEffectAttachment = 0
SWEP.CamAttachment = 3

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"
SWEP.HoldtypeCustomize = "slam"

SWEP.Animations = {
    ["idle"] = { Source = "idle" },
    ["idle_empty"] = { Source = "idle_empty" },
    ["holster"] = { Source = "holster" },
    ["draw"] = { Source = "draw" },
    ["holster_empty"] = { Source = "holster_empty" },
    ["draw_empty"] = { Source = "draw_empty" },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
        SoundTable = {
            {
                s = "ArcCW_Horde.Nailgun_Out",
                t = 0.227
            },
            {
                s = "ArcCW_Horde.Nailgun_In",
                t = 1.5
            }
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.45,
        LHIKOut = 0.25,
        SoundTable = {
            {
                s = "ArcCW_Horde.Nailgun_Out",
                t = 0.227
            },
            {
                s = "ArcCW_Horde.Nailgun_In",
                t = 1.5
            }
        },
    },
}

SWEP.Attachments = {
    {
        PrintName = "Perks",
        Slot =
        {
            "go_perk",
            "go_perk_smg",
        },
        DefaultAttName = "None"
    },
    {
        PrintName = "Charms",
        Slot = "charm",
        Bone = "tag_barrel_attach",
        Offset = {
            vpos = Vector( -6, -1.2, 0 ),
            vang = Angle( 0, -15, 0 ),
            wpos = Vector( 7, 2, -4.5 ),
            wang = Angle( -5, 1, 180 )
        },
    },
}

sound.Add( {
    name = "ArcCW_Horde.Nailgun_Out",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    sound = ")weapons/sm_nailgun/fly_nail_mag_out.wav"
} )

sound.Add( {
    name = "ArcCW_Horde.Nailgun_In",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    sound = ")weapons/sm_nailgun/fly_nail_mag_in.wav"
} )
