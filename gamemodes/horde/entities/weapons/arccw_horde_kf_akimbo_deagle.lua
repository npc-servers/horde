if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "arccw/weaponicons/arccw_go_deagle" )
    killicon.Add( "arccw_horde_kf_akimbo_deagle", "arccw/weaponicons/arccw_go_deagle", Color( 0, 0, 0, 255 ) )
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 1

SWEP.PrintName = "Akimbo Desert Eagles"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Pair of Desert Eagles wielded akimbo style. Warm up those wrists!"
SWEP.Trivia_Manufacturer = "Tripwire Interactive"
SWEP.Trivia_Calibre = ".50 AE"
SWEP.Trivia_Mechanism = "Recoil-Operated"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "2009"

SWEP.ViewModel = "models/horde/weapons/kf/c_akimbo_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_elite.mdl"

SWEP.NoHideLeftHandInCustomization = true

SWEP.Damage = 185
SWEP.DamageMin = 100
SWEP.Range = 50
SWEP.Penetration = 9

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 14

SWEP.ReloadInSights = true

SWEP.Recoil = 3
SWEP.RecoilSide = 1
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 60 / 300
SWEP.Firemodes = {
	{
		Mode = 1,
	}
}

SWEP.NotForNPCS = true

SWEP.Primary.Ammo = "357"

SWEP.ShootSound = {
	")horde/weapons/kf_deagle/50aest_firest1.wav",
	")horde/weapons/kf_deagle/50aest_firest2.wav",
	")horde/weapons/kf_deagle/50aest_firest3.wav",
	")horde/weapons/kf_deagle/50aest_firest4.wav"
}

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

SWEP.ActivePos = Vector(0, 1.5, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(0, 4, -0.5)
SWEP.HolsterAng = Angle(-12, 0, 0)

SWEP.CustomizePos = Vector(0, 4, -5)
SWEP.CustomizeAng = Angle(15, 0, 0)

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
        Bone = "Gun",
        Offset = {
            vpos = Vector(3, -0.4, 1.3),
            vang = Angle(0, 0, 0),
            wpos = Vector(8.625, 2, -2),
            wang = Angle(0, 0, 180)
        },
        NoWM = true,
    },
}

SWEP.Animations = {
	[ "draw" ] = {
		Source = "draw",
		SoundTable = {
			{ s = "horde/weapons/kf_deagle/50ae_select.wav", t = 1 / 30 },
		}
	},
	[ "holster" ] = {
		Source = "holster"
	},
	[ "reload" ] = {
		Source = "reload",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_DUEL,
		SoundTable = {
			{ s = "horde/weapons/kf_deagle/50ae_reload_000.wav", t = 1 / 35 },
			{ s = "horde/weapons/kf_deagle/50ae_reload_011.wav", t = 8 / 35 },
			{ s = "horde/weapons/kf_deagle/50ae_reload_043.wav", t = 40 / 35 },
			{ s = "horde/weapons/kf_deagle/50ae_reload_043.wav", t = 78 / 35 },
			{ s = "horde/weapons/kf_deagle/50ae_reload_055.wav", t = 88 / 35 },
			{ s = "horde/weapons/kf_deagle/50ae_reload_055.wav", t = 92 / 35 },
		}
	},
	[ "fire" ] = {
		Source = "fire_r"
	},
	[ "fire2" ] = {
		Source = "fire_l"
	},
	[ "idle" ] = {
		Source = "idle"
	},
}

SWEP.Hook_SelectFireAnimation = function( wep, data )
    if wep:GetNthShot() % 2 == 0 then return "fire2" else return "fire" end
end

SWEP.O_Hook_Override_MuzzleEffectAttachment = function( wep, data )
	if wep:GetNthShot() % 2 == 0 then return { current = 2 } else return { current = 1 } end
end