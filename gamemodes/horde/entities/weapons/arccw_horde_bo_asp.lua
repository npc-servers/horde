if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("items/hl2/weapon_pistol.png")
    SWEP.WepSelectIconMat = Material("items/hl2/weapon_pistol.png")
    killicon.AddAlias("arccw_horde_bo_asp", "weapon_pistol")
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 1

SWEP.PrintName = "ASP"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Low profile pistol.\nThis one is chambered in a special cartridge, designed for melee fighters."
SWEP.Trivia_Manufacturer = "ASP"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Recoil-Operated"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1975"

SWEP.ViewModel = "models/horde/weapons/bo/asp/viewmodel.mdl"
SWEP.WorldModel = "models/horde/weapons/bo/asp/worldmodel.mdl"

SWEP.Damage = 32
SWEP.DamageMin = 5
SWEP.Range = 25
SWEP.DamageType = DMG_SLASH
SWEP.Penetration = 2

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 7

SWEP.Recoil = 0.4
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 60 / 450
SWEP.Firemodes = {
	{
		Mode = 1,
	}
}

SWEP.NotForNPCS = true

SWEP.HipDispersion = 250
SWEP.MoveDispersion = 50
SWEP.JumpDispersion = 100

SWEP.ShootSound = {
	")horde/weapons/bo_asp/shot_00.wav",
	")horde/weapons/bo_asp/shot_01.wav",
	")horde/weapons/bo_asp/shot_02.wav",
	")horde/weapons/bo_asp/shot_03.wav",
	")horde/weapons/bo_asp/shot_04.wav"
}
SWEP.LowShootSound = "horde/weapons/bo_asp/lfe_00.wav"
SWEP.DistantShootSound = ")horde/weapons/bo_asp/ringoff_00.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol"

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.95

SWEP.IronSightStruct = {
    Pos = Vector(-2.7958, 0, 1.7364),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 0, 0)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.Attachments = {
    {
        PrintName = "Ammo Type",
        DefaultAttName = "Standard Ammo",
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
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(1.5, -0.15, -0.5),
            vang = Angle(0, 0, 0),
        },
        NoWM = true,
    },
}

SWEP.Animations = {
	["ready"] = {
		Source = "reg_draw_first",
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Pickup", t = 1 / 40 },
			{ s = "horde/weapons/bo_asp/reload/fly_asp_slide_back.wav", t = 5 / 40 },
			{ s = "horde/weapons/bo_asp/reload/fly_asp_slide_forward.wav", t = 11 / 40 },
		}
	},
	["draw"] = {
		Source = "reg_draw",
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Rattle", t = 1 / 60 },
		}
	},
	["draw_empty"] = {
		Source = "reg_draw_empty",
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Rattle", t = 1 / 60 },
		}
	},
	["holster"] = {
		Source = "reg_holster"
	},
	["holster_empty"] = {
		Source = "reg_holster_empty"
	},
	["reload"] = {
		Source = "reg_reload",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 1 / 40 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 21 / 40 },
			{ s = "horde/weapons/bo_asp/reload/fly_asp_mag_out.wav", t = 5 / 40 },
			{ s = "horde/weapons/bo_asp/reload/fly_asp_futz.wav", t = 17 / 40 },
			{ s = "horde/weapons/bo_asp/reload/fly_asp_mag_in.wav", t = 24 / 40 },
		},
	},
	["reload_empty"] = {
		Source = "reg_reload_empty",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 1 / 40 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 21 / 40 },
			{ s = "horde/weapons/bo_asp/reload/fly_asp_mag_out.wav", t = 5 / 40 },
			{ s = "horde/weapons/bo_asp/reload/fly_asp_futz.wav", t = 19 / 40 },
			{ s = "horde/weapons/bo_asp/reload/fly_asp_mag_in.wav", t = 24 / 40 },
			{ s = "horde/weapons/bo_asp/reload/fly_asp_slide_forward.wav", t = 37 / 40 },
		},
	},
	["fire"] = {
		Source = "reg_fire"
	},
	["fire_iron"] = {
		Source = "reg_ads_fire"
	},
	["fire_empty"] = {
		Source = "reg_fire_last"
	},
	["fire_iron_empty"] = {
		Source = "reg_ads_fire_last"
	},
	["idle"] = {
		Source = "reg_idle"
	},
	["idle_empty"] = {
		Source = "reg_idle_empty"
	},
	["idle_sprint"] = {
		Source = "reg_sprint"
	},
	["idle_sprint_empty"] = {
		Source = "reg_sprint_empty"
	},
	["enter_sprint"] = {
		Source = "reg_sprint_in"
	},
	["exit_sprint"] = {
		Source = "reg_sprint_out"
	}
}

function SWEP:DoShootSound( sndoverride, dsndoverride, voloverride, pitchoverride )
    local fsound = self.ShootSound
    local lsound = self.LowShootSound
    local dsound = self.DistantShootSound

    local suppressed = self:GetBuff_Override( "Silencer" )

    if suppressed then
        fsound = self.ShootSoundSilenced
        lsound = self.LowShootSoundSilenced
        dsound = nil
    end

    fsound = self:GetBuff_Hook( "Hook_GetShootSound", fsound )

    local volume = self.ShootVol
    local spv = self.ShootPitchVariation
    local pitch  = self.ShootPitch * math.Rand( 1 - spv, 1 + spv ) * self:GetBuff_Mult( "Mult_ShootPitch" )

    local v = GetConVar( "arccw_weakensounds" ):GetFloat()
    
    volume = volume - v
    volume = volume * self:GetBuff_Mult( "Mult_ShootVol" )

    volume = math.Clamp( volume, 60, 140 )
    pitch = math.Clamp( pitch, 0, 255 )

    if sndoverride then fsound = sndoverride end
    if voloverride then volume = voloverride end
    if pitchoverride then pitch = pitchoverride end

    if fsound then self:MyEmitSound( fsound, volume, pitch, 1, CHAN_STATIC ) end
    if lsound then self:MyEmitSound( lsound, 65, 100, 1, CHAN_BODY ) end
    if dsound then self:MyEmitSound( dsound, volume, pitch, 1, CHAN_WEAPON ) end

    local data = {
    	sound = fsound,
    	volume = volume,
    	pitch = pitch,
    }

    self:GetBuff_Hook( "Hook_AddShootSound", data )
end