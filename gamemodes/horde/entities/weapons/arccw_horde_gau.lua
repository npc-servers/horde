if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_gau")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_gau", "vgui/hud/arccw_horde_gau", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false
SWEP.PrintName = "Minigun"
SWEP.TrueName = "M134D"
SWEP.Trivia_Class = "Rotary Machine Gun"
SWEP.Trivia_Desc = "A rotary machine gun derived from the Vulcan weapons platform, this modern Minigun uses special materials in its construction to reduce weight without sacrificing durability."
SWEP.Trivia_Manufacturer = "Daniel Ammon"
SWEP.Trivia_Calibre = "7.62x51mm NATO"
SWEP.Trivia_Mechanism = "Electronic Trigger"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 2003

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
    SWEP.Trivia_Manufacturer = "Dillon Aero"
end

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/arccw/c_minigun.mdl"
SWEP.WorldModel = "models/weapons/arccw/w_minigun.mdl"
SWEP.ViewModelFOV = 62
SWEP.DefaultBodygroups = "0000000"

SWEP.Damage = 37
SWEP.DamageMin = 33 -- damage done at maximum range
SWEP.Range = 1500 * 0.025 -- in METRES
SWEP.Penetration = 7
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1800 -- projectile or phys bullet muzzle velocity
-- IN M/S


SWEP.ChamberSize = 0 -- how many rounds can be chambered.

SWEP.Primary.ClipSize = 300 -- DefaultClip is automatically set.

SWEP.Recoil = 0.4
SWEP.RecoilSide = 0.2
SWEP.Delay = 60 / 1300 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Malfunction = false
SWEP.TriggerDelay = true






SWEP.BobMult = 2

SWEP.Firemodes = {
    {
        Mode = 2,
        PrintName = "Full Auto"
    },
    {
        Mode = 0
    }
}
SWEP.Jamming = false
SWEP.HeatCapacity = 300
SWEP.HeatDissipation = 70
SWEP.HeatLockout = true
SWEP.HeatDelayTime = 1


SWEP.NPCWeaponType = {"weapon_ar2", "weapon_shotgun"}
SWEP.NPCWeight = 1

SWEP.AccuracyMOA = 1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "AlyxGun" -- what ammo type the gun uses
SWEP.MagID = "minigun" -- the magazine pool this gun draws from
SWEP.ShootVol = 75 -- volume of shoot sound
SWEP.ShootPitch = 105 -- pitch of shoot sound
SWEP.ShootSound = "weapons/arccw/minigun/minigun_fire.ogg"
SWEP.DistantShootSound = "weapons/arccw/minigun/negev-1-distant.ogg"

SWEP.MuzzleEffect = "muzzleflash_minimi"

SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 90
SWEP.ShellScale = 2.5

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on
SWEP.SpeedMult = 0.875
SWEP.SightedSpeedMult = 0.35
SWEP.SightTime = 0.25

SWEP.IronSightStruct = {
    Pos = Vector(0, -5, -2),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
    CrosshairInSights = true
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "crossbow"
SWEP.HoldtypeSights = "crossbow"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 0, -4)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(12, -3, -4)
SWEP.CustomizeAng = Angle(15, 40, 0)

SWEP.HolsterPos = Vector(3, -6, -16)
SWEP.HolsterAng = Angle(40, 0, 0)

SWEP.BarrelOffsetSighted = Vector(5, 0, -10)
SWEP.BarrelOffsetHip = Vector(4, 0, -6)

SWEP.BarrelLength = 22
SWEP.AttachmentElements = {
    ["extendedmag"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["reducedmag"] = {
        VMBodygroups = {{ind = 1, bg = 2}},
        WMBodygroups = {{ind = 1, bg = 2}},
    },
    ["nors"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
            {ind = 3, bg = 1},
        },
    },
    ["nobrake"] = {
        VMBodygroups = {
            {ind = 6, bg = 1},
        },
    },
    
}

SWEP.ShellRotateAngle = Angle(0, -90, 0)

SWEP.ExtraSightDist = 8

SWEP.Attachments = {
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
	    {
        PrintName = "Fire Group",
        Slot = "fcg",
        DefaultAttName = "Standard FCG"
    },
	{
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.minigun_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0.5, -4.5, -4), -- offset that the attachment will be relative to the bone
            vang = Angle(-90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        }
}
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "weapons/arccw/minigun/m249_draw.ogg",
                t = 0
            }
        },
        Time = 1.5
    },
    ["fire"] = {
        Source = {"fire_1"},
        Time = 0.2,
        ShellEjectAt = 0
    },
	    ["trigger"] = {
         Source = "idle",
		 SoundTable = {
            {
                s = "weapons/arccw/minigun/minigun_spinup.ogg",
                t = 0
            }
        },
         MinProgress = 0.5,
     },
        ["untrigger"] = {
         Source = "idle",
     },
    ["reload"] = {
        Source = "reload",
        Time = 4,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {20, 60, 80, 145, 170},
        FrameRate = 30,
        LastClip1OutTime = 3,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5
    },
}

sound.Add({
    name = "Weapon_M60.Boxout",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arccw/minigun/minigun_boxout.ogg"
})

sound.Add({
    name = "Weapon_M60.Boxin",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arccw/minigun/minigun_boxin.ogg"
})

sound.Add({
    name = "minigun_spinup",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arccw/minigun/minigun_spinup.ogg"
})