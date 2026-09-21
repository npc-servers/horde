if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "items/hl2/weapon_shotgun.png" )
    SWEP.WepSelectIconMat = Material( "items/hl2/weapon_shotgun.png" )
    killicon.AddAlias( "arccw_horde_shotgun", "weapon_shotgun" )
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCw - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "M3 Tactical"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "Basic 20-gauge shotgun. Fairly powerful at close range, but pales in comparison to 12-gauge shotguns."
SWEP.Trivia_Manufacturer = "Benelli"
SWEP.Trivia_Calibre = "20 Gauge"
SWEP.Trivia_Mechanism = "Pump-Action"
SWEP.Trivia_Country = "Italy"
SWEP.Trivia_Year = 1989

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel = "models/weapons/w_shot_m3super90.mdl"
SWEP.ViewModelFOV = 60

SWEP.MirrorVMWM = false

SWEP.DefaultBodygroups = "000000000000"

SWEP.WorldModelOffset = {
    pos = Vector( 14, 1, 2 ),
    ang = Angle( 0, 0, 180 ),
}

SWEP.Damage = 15
SWEP.DamageMin = 7
SWEP.Num = 7
SWEP.Range = 20
SWEP.Penetration = 2
SWEP.DamageType = DMG_BUCKSHOT

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 6

SWEP.ShotgunReload = true

SWEP.ManualAction = true
SWEP.NoLastCycle = true

SWEP.Recoil = 1
SWEP.RecoilSide = 1
SWEP.RecoilPunch = 0

SWEP.Delay = 0.015
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "PUMP"
    },
    {
        Mode = 0,
    }
}

SWEP.AccuracyMOA = 50
SWEP.HipDispersion = 200
SWEP.MoveDispersion = 150

SWEP.Primary.Ammo = "Buckshot"

SWEP.ShootSound = "ArcCW_Horde.Shotgun_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.Shotgun_Fire_Sil"

SWEP.MuzzleEffect = "muzzleflash_shotgun"

SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellPitch = 100
SWEP.ShellSounds = ArcCW.ShotgunShellSoundsTable
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle( 0, 180, 0 )

SWEP.IronSightStruct = {
    Pos = Vector( -3, -1, 2 ),
    Ang = Angle( 0, 0, 0 ),
    Magnification = 1.5,
    CrosshairInSights = true
}

SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG

SWEP.GuaranteeLaser = true

SWEP.HolsterPos = Vector( 3, -3, -1 )
SWEP.HolsterAng = Angle( -7, 30, -10 )

SWEP.CustomizePos = Vector( 7, -5, 1 )
SWEP.CustomizeAng = Angle( 5, 30, 30 )

SWEP.RejectAttachments = { [ "go_fore_bipod" ] = true }

SWEP.Attachments = {
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle_shotgun",
        Bone = "v_weapon.M3_PARENT",
        Offset = {
            vpos = Vector( 0, -4.5, -24 ),
            vang = Angle( -90, 0, 90 ),
        },
        VMScale = Vector( 1.5, 1.5, 1.5 )
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.M3_PUMP",
        Offset = {
            vpos = Vector( 0, 1.5, -6.5 ),
            vang = Angle( -90, 0, -90 ),
        }
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.M3_PARENT",
        Offset = {
            vpos = Vector( 0, -3.5, -22 ),
            vang = Angle( -90, 0, 0 ),
        },
        VMScale = Vector( 1.5, 1.5, 1.5 )
    },
    {
        PrintName = "Ammo Type",
        DefaultAttName = "Buckshot Shells",
        Slot = "go_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.M3_PARENT",
        Offset = {
            vpos = Vector( -0.5, -4, -2.75 ),
            vang = Angle( -90, 0, -90 ),
        },
        VMScale = Vector( 0.8, 0.8, 0.8 )
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["draw"] = {
        Source = "draw",
    },
    ["fire"] = {
        Source = "shoot2",
        Time = 0.2,
        MinProgress = 0,
    },
    ["cycle"] = {
        Source = "after_reload",
        Time = 0.45,
        ShellEjectAt = 0.2,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
    },
    ["sgreload_start"] = {
        Source = "start_reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0,
    },
    ["sgreload_insert"] = {
        Source = "insert",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.2,
        SoundTable = {
            {s = {"Weapon_Shotgun.Reload"}, t = 0},
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
    },
    ["sgreload_finish"] = {
        Source = "after_reload",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.2,
    },
    ["sgreload_finish_empty"] = {
        Source = "after_reload",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.2,
    },
}

function SWEP:DrawWeaponSelection( x, y, w, h, a )
    surface.SetDrawColor( 255, 255, 255, a )
    surface.SetMaterial( self.WepSelectIconMat )

    surface.DrawTexturedRect( x, y, w, w / 2 )
end

sound.Add( {
    name = "ArcCW_Horde.Shotgun_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {99, 101},
    sound = ")weapons/xm1014/xm1014-1.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.Shotgun_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {100, 105},
    sound = ")arccw_go/m590_suppressed_fp.wav"
} )
