if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "arccw/weaponicons/arccw_go_usp" )
    killicon.Add( "arccw_horde_kf_akimbo_mk23", "arccw/weaponicons/arccw_go_usp", Color( 0, 0, 0, 255 ) )
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 1

SWEP.PrintName = "Akimbo MK23s"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Pair of MK23s wielded akimbo style. Action hero approved!"
SWEP.Trivia_Manufacturer = "Tripwire Interactive"
SWEP.Trivia_Calibre = ".45 ACP"
SWEP.Trivia_Mechanism = "Recoil-Operated"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "2009"

SWEP.ViewModel = "models/horde/weapons/kf/c_akimbo_mk23.mdl"
SWEP.WorldModel = "models/weapons/w_pist_elite.mdl"

SWEP.NoHideLeftHandInCustomization = true

SWEP.Damage = 55
SWEP.DamageMin = 32
SWEP.Range = 50

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 30

SWEP.ReloadInSights = true

SWEP.Recoil = 1.1
SWEP.RecoilSide = 0.4
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 60 / 500
SWEP.Firemodes = {
	{
		Mode = 1,
	}
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 10
SWEP.HipDispersion = 250
SWEP.MoveDispersion = 50

SWEP.ShootSound = ")horde/weapons/kf_mk23/mk23_fire_s.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol"

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
        Bone = "MK23",
        Offset = {
            vpos = Vector( -0.2, -3.6, 1.3 ),
            vang = Angle( 0, 90, 0 ),
        },
        NoWM = true,
    },
}

SWEP.Animations = {
	["draw"] = {
		Source = "draw",
		SoundTable = {
			{ s = "horde/weapons/kf_mk23/mk23_select.wav", t = 1 / 30 },
		}
	},
	["holster"] = {
		Source = "holster"
	},
	["reload"] = {
		Source = "reload",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_DUEL,
		SoundTable = {
			{ s = "horde/weapons/kf_mk23/mk23_chamberback.wav", t = 1 / 40 },
			{ s = "horde/weapons/kf_mk23/mk23_cliprelease.wav", t = 6 / 40 },
			{ s = "horde/weapons/kf_mk23/mk23_clipinsert.wav", t = 34 / 40 },
			{ s = "horde/weapons/kf_mk23/mk23_chamberback.wav", t = 52 / 40 },
			{ s = "horde/weapons/kf_mk23/mk23_chamberforward.wav", t = 64 / 40 },
			{ s = "horde/weapons/kf_mk23/mk23_clipinsert.wav", t = 80 / 40 },
			{ s = "horde/weapons/kf_mk23/mk23_chamberhit.wav", t = 110 / 40 },
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
