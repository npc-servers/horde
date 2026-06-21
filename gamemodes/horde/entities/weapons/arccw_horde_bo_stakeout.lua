if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "arccw/weaponicons/arccw_horde_bo_stakeout" )
    killicon.Add( "arccw_horde_bo_stakeout", "arccw/weaponicons/arccw_horde_bo_stakeout", Color( 0, 0, 0, 255 ) )
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 3

SWEP.PrintName = "Stakeout"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "Modified version of the Ithaca 37 shotgun."
SWEP.Trivia_Manufacturer = "Ithaca"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Pump-Action"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1933"

SWEP.ViewModel = "models/horde/weapons/bo/stakeout/viewmodel.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

SWEP.Damage = 20
SWEP.DamageMin = 5
SWEP.Range = 25
SWEP.Penetration = 4

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 6

SWEP.ShotgunReload = true

SWEP.ManualAction = true

SWEP.IsShotgun = true

SWEP.Recoil = 3.5
SWEP.RecoilSide = 1.5
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.ShotgunSpreadDispersion = true

SWEP.Delay = 60 / 300
SWEP.Num = 7
SWEP.Firemodes = {
    {
        Mode = 1,
    }
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 40
SWEP.HipDispersion = 350
SWEP.MoveDispersion = 150

SWEP.ShootVol = 80

SWEP.ShootSound = ")horde/weapons/bo_stakeout/shot_00.wav"
SWEP.LowShootSound = ")horde/weapons/bo_stakeout/lfe_00.wav"
SWEP.ShootSoundSilenced = ")horde/weapons/bo_shared/silenced/spas_silenced_00.wav"
SWEP.LowShootSoundSilenced = ")horde/weapons/bo_shared/shotgun_lfe_00.wav"
SWEP.DistantShootSound = ")horde/weapons/bo_shared/spas_ringoff_00.wav"
-- SWEP.DistantShootSoundSilenced = ")horde/weapons/bo_shared/silenced/spas_sweet_00.wav"

SWEP.MuzzleEffect = "muzzleflash_shotgun"

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.9

SWEP.IronSightStruct = {
    Pos = Vector( -1.9861, 2.0956, 1.2298 ),
    Ang = Angle( 0.2241, 0.0441, 0 ),
    Magnification = 1.1,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.ActivePos = Vector( 0, 2, 1 )
SWEP.ActiveAng = Angle( 0, 0, 0 )

SWEP.SprintPos = Vector( 0, 2, 1 )
SWEP.SprintAng = Angle( 0, 0, 0 )

SWEP.AttachmentElements = {
    ["silencer"] = {
        VMElements = {
            {
                Model = "models/weapons/arccw/fesiugmw2/atts/supp_mw2.mdl",
                Bone = "tag_weapon",
                Offset = {
                    pos = Vector( 15.6, 0, 0.8 ),
                    ang = Angle( 0, 0, 0 ),
                },
                Scale = Vector( 0.6, 0.45, 0.45 ),
            }
        },
    },
    ["grip"] = {
        VMBodygroups = {
            { ind = 1, bg = 1 },
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
        PrintName = "Underbarrel",
        Slot = "foregrip_mw2exclusive"
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
            vpos = Vector( -0.4, -0.5, 0.2 ),
            vang = Angle( 0, 0, 0 ),
        },
        NoWM = true,
    },
}

SWEP.Animations = {
    ["ready"] = {
        Source = "reg_draw_first",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Pickup", t = 1 / 40 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_pull.wav", t = 15 / 40 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_push.wav", t = 20 / 40 },
        }
    },
    ["draw"] = {
        Source = "reg_draw",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Rattle", t = 1 / 40 },
        }
    },
    ["holster"] = {
        Source = "reg_holster"
    },
    ["sgreload_start"] = {
        Source = "reg_reload_start",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Reload", t = 1 / 30 },
            { s = "ArcCW_Horde_BO_Stakeout.Load", t = 10 / 30 },
        },
        RestoreAmmo = 1
    },
    ["sgreload_insert"] = {
        Source = "reg_reload_loop",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Reload", t = 1 / 30 },
            { s = "ArcCW_Horde_BO_Stakeout.Load", t = 2 / 30 },
        },
        TPAnimStartTime = 0.3
    },
    ["sgreload_finish"] = {
        Source = "reg_reload_end",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Reload", t = 5 / 25 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_pull.wav", t = 5 / 25 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_push.wav", t = 10 / 25 },
        }
    },
    ["fire"] = {
        Source = "reg_fire",
        MinProgress = 10 / 30
    },
    ["fire_iron"] = {
        Source = "reg_ads_fire",
        MinProgress = 10 / 30
    },
    ["cycle"] = {
        Source = "reg_rechamber",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Reload", t = 1 / 40 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_pull.wav", t = 5 / 40 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_push.wav", t = 10 / 40 },
        }
    },
    ["cycle_iron"] = {
        Source = "reg_rechamber_ads",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Reload", t = 1 / 30 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_pull.wav", t = 5 / 30 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_push.wav", t = 10 / 30 },
        }
    },
    ["idle"] = {
        Source = "reg_idle"
    },
    ["idle_sprint"] = {
        Source = "reg_sprint"
    },
    ["enter_sprint"] = {
        Source = "reg_sprint_in"
    },
    ["exit_sprint"] = {
        Source = "reg_sprint_out"
    },

    -- Foregrip
    ["ready_grip"] = {
        Source = "grip_draw",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Pickup", t = 1 / 40 },
        }
    },
    ["draw_grip"] = {
        Source = "grip_draw",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Rattle", t = 1 / 40 },
        }
    },
    ["holster_grip"] = {
        Source = "grip_holster"
    },
    ["sgreload_start_grip"] = {
        Source = "grip_reload_start",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Reload", t = 1 / 30 },
            { s = "ArcCW_Horde_BO_Stakeout.Load", t = 10 / 30 },
        },
        RestoreAmmo = 1
    },
    ["sgreload_insert_grip"] = {
        Source = "grip_reload_loop",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Reload", t = 1 / 30 },
            { s = "ArcCW_Horde_BO_Stakeout.Load", t = 2 / 30 },
        },
        TPAnimStartTime = 0.3
    },
    ["sgreload_finish_grip"] = {
        Source = "grip_reload_end",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Reload", t = 5 / 25 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_pull.wav", t = 5 / 25 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_push.wav", t = 10 / 25 },
        }
    },
    ["fire_grip"] = {
        Source = "grip_fire",
        MinProgress = 10 / 30
    },
    ["fire_iron_grip"] = {
        Source = "grip_ads_fire",
        MinProgress = 10 / 30
    },
    ["cycle_grip"] = {
        Source = "grip_rechamber",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Reload", t = 1 / 40 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_pull.wav", t = 5 / 40 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_push.wav", t = 10 / 40 },
        }
    },
    ["cycle_iron_grip"] = {
        Source = "grip_rechamber_ads",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Stakeout.Reload", t = 1 / 30 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_pull.wav", t = 5 / 30 },
            { s = "horde/weapons/bo_shared/reload/fly_rem870_push.wav", t = 10 / 30 },
        }
    },
    ["idle_grip"] = {
        Source = "grip_idle"
    },
    ["idle_sprint_grip"] = {
        Source = "grip_sprint"
    },
    ["enter_sprint_grip"] = {
        Source = "grip_sprint_in"
    },
    ["exit_sprint_grip"] = {
        Source = "grip_sprint_out"
    }
}

sound.Add( {
    name = "ArcCW_Horde_BO_Stakeout.Load",
    volume = 1.0,
    sound = {
        "horde/weapons/bo_shared/reload/load_00.wav",
        "horde/weapons/bo_shared/reload/load_01.wav",
        "horde/weapons/bo_shared/reload/load_02.wav",
        "horde/weapons/bo_shared/reload/load_03.wav",
        "horde/weapons/bo_shared/reload/load_04.wav",
        "horde/weapons/bo_shared/reload/load_05.wav"
    }
} )

sound.Add( {
    name = "ArcCW_Horde_BO_Stakeout.Reload",
    volume = 1.0,
    sound = {
        "horde/weapons/bo_shared/foley/fly_gear_reload_plr_00.wav",
        "horde/weapons/bo_shared/foley/fly_gear_reload_plr_01.wav",
        "horde/weapons/bo_shared/foley/fly_gear_reload_plr_02.wav",
        "horde/weapons/bo_shared/foley/fly_gear_reload_plr_03.wav"
    }
} )

sound.Add( {
    name = "ArcCW_Horde_BO_Stakeout.Pickup",
    volume = 1.0,
    sound = {
        ")horde/weapons/bo_shared/foley/pickup_00.wav",
        ")horde/weapons/bo_shared/foley/pickup_01.wav",
        ")horde/weapons/bo_shared/foley/pickup_02.wav"
    }
} )

sound.Add( {
    name = "ArcCW_Horde_BO_Stakeout.Rattle",
    volume = 1.0,
    sound = {
        ")horde/weapons/bo_shared/foley/rattle_00.wav",
        ")horde/weapons/bo_shared/foley/rattle_01.wav",
        ")horde/weapons/bo_shared/foley/rattle_02.wav",
        ")horde/weapons/bo_shared/foley/rattle_03.wav",
        ")horde/weapons/bo_shared/foley/rattle_04.wav"
    }
} )

SWEP.Hook_TranslateAnimation = function( wep, anim )
    local attached = wep.Attachments[2].Installed

    if attached then
        return anim .. "_grip"
    end
end

function SWEP:DoShootSound( sndoverride, _, voloverride, pitchoverride )
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
    if lsound then self:MyEmitSound( lsound, 75, 100, 0.5, CHAN_BODY ) end
    if dsound then self:MyEmitSound( dsound, volume, pitch, 1, CHAN_WEAPON ) end

    local data = {
        sound = fsound,
        volume = volume,
        pitch = pitch,
    }

    self:GetBuff_Hook( "Hook_AddShootSound", data )
end