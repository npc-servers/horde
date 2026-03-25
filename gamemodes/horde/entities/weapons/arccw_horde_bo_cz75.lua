if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("items/hl2/weapon_pistol.png")
    SWEP.WepSelectIconMat = Material("items/hl2/weapon_pistol.png")
    killicon.AddAlias("arccw_horde_bo_cz75", "weapon_pistol")
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 1

SWEP.PrintName = "CZ-75"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Fully automatic pistol."
SWEP.Trivia_Manufacturer = "CZUB"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Recoil-Operated"
SWEP.Trivia_Country = "Czech Republic"
SWEP.Trivia_Year = "1975"

SWEP.ViewModel = "models/horde/weapons/bo/cz75/viewmodel.mdl"
SWEP.WorldModel = "models/horde/weapons/bo/cz75/worldmodel.mdl"

SWEP.DefaultBodygroups = "00001000"

SWEP.Damage = 27
SWEP.DamageMin = 12
SWEP.Range = 50

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 12
SWEP.ExtendedClipSize = 20

SWEP.Recoil = 0.6
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 60 / 600
SWEP.Firemodes = {
	{
		Mode = 2,
	}
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 10
SWEP.HipDispersion = 350
SWEP.MoveDispersion = 50

SWEP.ShootSound = {
	")horde/weapons/bo_cz75/shot_00.wav",
	")horde/weapons/bo_cz75/shot_01.wav",
	")horde/weapons/bo_cz75/shot_02.wav",
	")horde/weapons/bo_cz75/shot_03.wav",
	")horde/weapons/bo_cz75/shot_04.wav"
}
SWEP.LowShootSound = "horde/weapons/bo_cz75/lfe_00.wav"
SWEP.ShootSoundSilenced = {
	")horde/weapons/bo_m16/silenced/silenced_00.wav",
	")horde/weapons/bo_m16/silenced/silenced_01.wav",
	")horde/weapons/bo_m16/silenced/silenced_02.wav",
	")horde/weapons/bo_m16/silenced/silenced_03.wav"
}
SWEP.LowShootSoundSilenced = "horde/weapons/bo_shared/wpn_lfe_sweet_02.wav"
SWEP.DistantShootSound = ")horde/weapons/bo_cz75/ringoff_00.wav"
SWEP.DistantShootSoundSilenced = ")horde/weapons/bo_aug/silenced/sweet_00.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol"

SWEP.IronSightStruct = {
    Pos = Vector(-2.0004, 0.582, 1.796),
    Ang = Vector(-1.2971, -0.0308, 0),
    Magnification = 1.1,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 0, 0)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.AttachmentElements = {
    ["silencer"] = {
        VMElements = {
            {
                Model = "models/horde/weapons/bo/cz75/atts/attachment_silencer.mdl",
                Bone = "tag_weapon",
                Offset = {
                    pos = Vector( 0, 0, 0 ),
                    ang = Angle( 0, -90, 0 ),
                },
                Scale = Vector( 0.875, 0.875, 0.875 ),
            }
        },
    },
    ["ext_mag"] = {
        VMBodygroups = {
            { ind = 3, bg = 1 },
        },
    },
}

SWEP.Attachments = {
	{
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "horde_bo_muzzle"
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard Magazine",
        Slot = "horde_bo_ammo"
    },
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
            vpos = Vector(1.9, -0.3, 0),
            vang = Angle(0, 0, 0),
        },
        NoWM = true,
    },
}

SWEP.Animations = {
	["ready"] = {
		Source = "reg_draw_first",
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Pickup", t = 1 / 35 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_slide_back.wav", t = 9 / 35 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_slide_forward.wav", t = 17 / 35 },
		}
	},
	["draw"] = {
		Source = "reg_draw",
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Rattle", t = 1 / 40 },
		}
	},
	["draw_empty"] = {
		Source = "reg_draw_empty",
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Rattle", t = 1 / 40 },
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
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 1 / 25 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 17 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_mag_out.wav", t = 6 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_futz.wav", t = 21 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_mag_in.wav", t = 25 / 25 },
		}
	},
	["reload_ext"] = {
		Source = "reg_reload_ext",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 1 / 25 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 17 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_mag_out.wav", t = 6 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_futz.wav", t = 21 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_mag_in.wav", t = 25 / 25 },
		}
	},
	["reload_empty"] = {
		Source = "reg_reload_empty",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 1 / 25 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 17 / 25 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 32 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_mag_out.wav", t = 6 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_futz.wav", t = 18 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_mag_in.wav", t = 25 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_slide_back.wav", t = 35 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_slide_forward.wav", t = 38 / 25 },
		}
	},
	["reload_ext_empty"] = {
		Source = "reg_reload_empty_ext",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 1 / 25 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 17 / 25 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 32 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_mag_out.wav", t = 6 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_futz.wav", t = 18 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_mag_in.wav", t = 25 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_slide_back.wav", t = 35 / 25 },
			{ s = "horde/weapons/bo_cz75/reload/fly_cz75_slide_forward.wav", t = 38 / 25 },
		}
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
        dsound = self.DistantShootSoundSilenced
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