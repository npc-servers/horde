SWEP.Base = "arccw_base"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "FAMAS G1"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "French bullpup assault rifle with three-round burst fire group. Considered by many to be a lousy gun, but it has won the French many a 'la victoire'."
SWEP.Trivia_Manufacturer = "GIAT Industries"
SWEP.Trivia_Calibre = "5.56x45mm NATO"
SWEP.Trivia_Mechanism = "Delayed Blowback"
SWEP.Trivia_Country = "France"
SWEP.Trivia_Year = 1994

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_famas.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 50
SWEP.DamageMin = 40
SWEP.Range = 150
SWEP.Penetration = 12
SWEP.MuzzleVelocity = 1050

SWEP.ChamberSize = 1
SWEP.Primary.ClipSize = 30

SWEP.Recoil = 0.5
SWEP.RecoilSide = 0.05
SWEP.RecoilRise = 0.4
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 1000
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = -3,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 3
SWEP.HipDispersion = 500
SWEP.MoveDispersion = 130

SWEP.Primary.Ammo = "smg1"

SWEP.ShootVol = 75

SWEP.ShootSound = {")arccw_go/famas/famas_01.wav",")arccw_go/famas/famas_02.wav",")arccw_go/famas/famas_03.wav",")arccw_go/famas/famas_04.wav"}
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = ")arccw_go/famas/famas_distant_01.wav"

SWEP.MuzzleEffect = "muzzleflash_famas"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1
SWEP.CaseEffectAttachment = 2

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.36

SWEP.IronSightStruct = {
    Pos = Vector(-6.26, -7, 1.2),
    Ang = Angle(0, -0.1, -2),
    Magnification = 1.1,
    SwitchToSound = "",
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, -4, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
    ["rail"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 4, bg = 1}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
        WMBodygroups = {{ind = 5, bg = 1}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
        WMBodygroups = {{ind = 6, bg = 1}},
    },
    ["fh_none"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
        WMBodygroups = {{ind = 2, bg = 3}},
    },
    ["go_famas_barrel_short"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 3},
        },
        WMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 3},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -2.85, 13.4),
            }
        }
    },
    ["go_famas_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 3},
        },
        WMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 3},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -2.85, 20.5),
            }
        }
    },
    ["go_famas_mag_25"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        WMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_556_ammo_60round"] = {
        VMBodygroups = {
            {ind = 3, bg = 2},
        },
        WMBodygroups = {
            {ind = 3, bg = 2},
        },
    }
}

SWEP.ExtraSightDist = 3
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-15, 7, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.famas_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -7.25, 4),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"rail"},
        CorrectiveAng = Angle(0.25, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl"},
        Bone = "v_weapon.famas_Parent",
        Offset = {
            vpos = Vector(0, -0.9, 12),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.famas_Parent",
        Offset = {
            vpos = Vector(0.9, -6.7, 4.5),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_famas_barrel",
        DefaultAttName = "490mm Standard Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.famas_Parent",
        Offset = {
            vpos = Vector(0, -2.9, 16.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"fh_none"},
    },
    {
        PrintName = "Magazine",
        Slot = {"go_famas_mag", "go_ammo_556_60"},
        DefaultAttName = "30-Round 5.56mm FR"
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.famas_Parent",
        Offset = {
            vpos = Vector(0.5, -6.2, -2),
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = {"shoot1", "shoot2", "shoot3"},
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot_iron",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.5,
        LHIKEaseOut = 0.4
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.15,
        LHIKEaseOut = 0.15
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_FAMAS.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_FAMAS.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_boltback.wav"
})

sound.Add({
    name = "ARCCW_GO_FAMAS.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_FAMAS.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_FAMAS.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_FAMAS.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_cliphit.wav"
})

function SWEP:DoShootSound(sndoverride, dsndoverride, voloverride, pitchoverride)
    local fsound = self.ShootSound
    local suppressed = self:GetBuff_Override("Silencer")

    if suppressed then
        fsound = self.ShootSoundSilenced
    end

    local firstsound = self.FirstShootSound

    if self:GetBurstCount() == 1 and firstsound then
        fsound = firstsound

        local firstsil = self.FirstShootSoundSilenced

        if suppressed then
            fsound = firstsil and firstsil or self.ShootSoundSilenced
        end
    end

    local lastsound = self.LastShootSound

    local clip = self:Clip1()

    if clip == 1 and lastsound then
        fsound = lastsound

        local lastsil = self.LastShootSoundSilenced

        if suppressed then
            fsound = lastsil and lastsil or self.ShootSoundSilenced
        end
    end

    fsound = self:GetBuff_Hook("Hook_GetShootSound", fsound)

    local distancesound = self.DistantShootSound

    if suppressed then
        distancesound = self.DistantShootSoundSilenced
    end

    distancesound = self:GetBuff_Hook("Hook_GetDistantShootSound", distancesound)

    local spv = self.ShootPitchVariation
    local volume = self.ShootVol
    local pitch  = self.ShootPitch * math.Rand(1 - spv, 1 + spv) * self:GetBuff_Mult("Mult_ShootPitch")

    local v = ArcCW.ConVars["weakensounds"]:GetFloat()

    volume = volume - v

    volume = volume * self:GetBuff_Mult("Mult_ShootVol")

    volume = math.Clamp(volume, 50, 140)
    pitch  = math.Clamp(pitch, 0, 255)

    if    sndoverride        then    fsound    = sndoverride end
    if    dsndoverride    then    distancesound = dsndoverride end
    if    voloverride        then    volume    = voloverride end
    if    pitchoverride    then    pitch    = pitchoverride end

    if distancesound then self:MyEmitSound(distancesound, 140, pitch, 0.5, CHAN_WEAPON) end

    if fsound then self:MyEmitSound(fsound, volume, pitch, 1, CHAN_STATIC) end

    local data = {
        sound   = fsound,
        volume  = volume,
        pitch   = pitch,
    }

    self:GetBuff_Hook("Hook_AddShootSound", data)
end