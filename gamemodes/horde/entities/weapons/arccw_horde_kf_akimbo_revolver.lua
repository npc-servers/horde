if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "arccw/weaponicons/arccw_go_r8" )
    killicon.Add( "arccw_horde_kf_akimbo_revolver", "arccw/weaponicons/arccw_go_r8", Color( 0, 0, 0, 255 ) )
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 1

SWEP.PrintName = "Akimbo Revolvers"
SWEP.Trivia_Class = "Revolver"
SWEP.Trivia_Desc = "Pair of standard revolvers wielded akimbo style. A classic gunfigher's combo!"
SWEP.Trivia_Manufacturer = "Tripwire Interactive"
SWEP.Trivia_Calibre = ".357 Magnum"
SWEP.Trivia_Mechanism = "DA/SA"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "2009"

SWEP.ViewModel = "models/horde/weapons/kf/c_akimbo_revolver.mdl"
SWEP.WorldModel = "models/weapons/w_pist_elite.mdl"

SWEP.NoHideLeftHandInCustomization = true

SWEP.Damage = 110
SWEP.DamageMin = 65
SWEP.Range = 75
SWEP.Penetration = 6

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 12

SWEP.ReloadInSights = true

SWEP.Recoil = 2.2
SWEP.RecoilSide = 0.8
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 60 / 200
SWEP.Firemodes = {
    {
        Mode = 1,
    }
}

SWEP.Primary.Ammo = "357"

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 5
SWEP.HipDispersion = 400
SWEP.MoveDispersion = 100

SWEP.ShootSound = ")horde/weapons/kf_revolver/wep_revolver_fire_s.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol_deagle"

SWEP.IronSightStruct = {
    Pos = Vector( 0, 2.5, 0 ),
    Ang = Angle( 0, 0, 0 ),
    Magnification = 1.1,
    CrosshairInSights = true,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "duel"
SWEP.HoldtypeSights = "duel"
SWEP.HoldtypeCustomize = "duel"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL

SWEP.ActivePos = Vector( 0, 1.5, 0 )
SWEP.ActiveAng = Angle( 0, 0, 0 )

SWEP.HolsterPos = Vector( 0, 4, -0.5 )
SWEP.HolsterAng = Angle( -12, 0, 0 )

SWEP.CustomizePos = Vector( 0, 4, -5 )
SWEP.CustomizeAng = Angle( 15, 0, 0 )

SWEP.Attachments = {
    {
        PrintName = "Ammo Type",
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
        Bone = "Revolver",
        Offset = {
            vpos = Vector( 3.3, -0.25, 0.4 ),
            vang = Angle( 0, 0, 0 ),
        },
        NoWM = true,
    },
}

SWEP.Animations = {
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            { s = ")horde/weapons/kf_revolver/wep_revolver_foley_select.wav", t = 1 / 30 },
        }
    },
    ["holster"] = {
        Source = "holster"
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_DUEL,
        SoundTable = {
            { s = ")horde/weapons/kf_revolver/wep_revolver_foley_open.wav", t = 1 / 40 },
            { s = ")horde/weapons/kf_revolver/wep_revolver_foley_eject.wav", t = 16 / 40 },
            { s = ")horde/weapons/kf_revolver/wep_revolver_foley_insert.wav", t = 62 / 40 },
            { s = ")horde/weapons/kf_revolver/wep_revolver_foley_close.wav", t = 78 / 40 },
            { s = ")horde/weapons/kf_revolver/wep_revolver_foley_open.wav", t = 104 / 40 },
            { s = ")horde/weapons/kf_revolver/wep_revolver_foley_eject.wav", t = 122 / 40 },
            { s = ")horde/weapons/kf_revolver/wep_revolver_foley_insert.wav", t = 148 / 40 },
            { s = ")horde/weapons/kf_revolver/wep_revolver_foley_close.wav", t = 165 / 40 },
        }
    },
    ["fire"] = {
        Source = "fire_r"
    },
    ["fire2"] = {
        Source = "fire_l"
    },
    ["idle"] = {
        Source = "idle"
    },
}

SWEP.Hook_SelectFireAnimation = function( wep, data )
    if wep:GetNthShot() % 2 == 0 then return "fire2" else return "fire" end
end

SWEP.O_Hook_Override_MuzzleEffectAttachment = function( wep, data )
    if wep:GetNthShot() % 2 == 0 then return { current = 2 } else return { current = 1 } end
end
