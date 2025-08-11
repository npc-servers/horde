SWEP.Base = "arccw_base"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "AR-15"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "A lightweight version of the M4. Created by Eugene Stoner and sold originally by Armalite, it has since become the basis for the most popular rifles in the world."
SWEP.Trivia_Manufacturer = "Colt"
SWEP.Trivia_Calibre = "5.56x45mm NATO"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1959

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000000"

SWEP.Damage = 42
SWEP.DamageMin = 32
SWEP.Range = 100
SWEP.Penetration = 9
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil
SWEP.MuzzleVelocity = 1050
-- IN M/S
SWEP.ChamberSize = 1
SWEP.Primary.ClipSize = 30

SWEP.PhysBulletMuzzleVelocity = 900

SWEP.Recoil = 0.4
SWEP.RecoilSide = 0.125
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 800
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 2,
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

SWEP.AccuracyMOA = 5
SWEP.HipDispersion = 400
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "smg1"
SWEP.MagID = "stanag"

SWEP.ShootVol = 75

SWEP.ShootSound = {")arccw_go/m4a1/m4a1_us_01.wav",")arccw_go/m4a1/m4a1_us_02.wav",")arccw_go/m4a1/m4a1_us_03.wav",")arccw_go/m4a1/m4a1_us_04.wav"} -- When using stereo .wav files, add ) to the beginning to make it directional. - func_brush
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = {")arccw_go/m4a1/m4a1_us_distant.wav",")arccw_go/m4a1/m4a1_us_distant_02.wav",")arccw_go/m4a1/m4a1_us_distant_03.wav"}

SWEP.MuzzleEffect = "muzzleflash_minimi"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1
SWEP.CaseEffectAttachment = 2

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.30

SWEP.IronSightStruct = {
    Pos = Vector(-5.275, -8.573, 0.2),
    Ang = Angle(1.35, -0.375, -1.951),
    Magnification = 1.1,
    SwitchToSound = "",
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, -3, 0)
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
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_m4_stock_m16"] = {
        VMBodygroups = {
            {ind = 3, bg = 2},
        },
    },
    ["go_m4_stock_ergo"] = {
        VMBodygroups = {
            {ind = 3, bg = 3},
        },
    },
    ["go_m4_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 3, bg = 4},
        },
    },
    ["go_ar15_barrel_med"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -5.15, 22),
            }
        }
    },
    ["go_ar15_barrel_long"] = {
        VMBodygroups = {
            {ind = 2, bg = 2},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -5.15, 25.5),
            }
        },
        Override_IronSightStruct = {
            Pos = Vector(-5.26, -8.573, 0.35),
            Ang = Angle(0.25, -0.33, -1.951),
            Magnification = 1.1,
            SwitchToSound = "",
            CrosshairInSights = false
        }
    },
    ["go_m4_mag_10_50"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
        },
    },
    ["go_m4_mag_20"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
        },
    },
    ["go_m4_mag_30_9mm"] = {
        NameChange = "R0635",
        VMBodygroups = {
            {ind = 1, bg = 3},
        },
    },
    ["go_m4_mag_21_9mm"] = {
        NameChange = "R0635",
        VMBodygroups = {
            {ind = 1, bg = 5},
        },
    },
    ["go_556_ammo_60round"] = {
        VMBodygroups = {
            {ind = 1, bg = 4},
        },
    }
}

SWEP.ExtraSightDist = 3
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-11, 6, -6),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic", "optic_lp"},
        Bone = "v_weapon.M4A1_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.04, -8.4, 3.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"rail"},
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl"},
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(0, -3.5, 10),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(1.6, -5.1, 13),
            vang = Angle(90, -1, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_ar15_barrel",
        DefaultAttName = "270mm CAR Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(0, -5.15, 19),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"fh_none"},
    },
    {
        PrintName = "Magazine",
        Slot = {"go_m4_mag", "go_ammo_556_60"},
        DefaultAttName = "30-Round 5.56mm Steel"
    },
    {
        PrintName = "Stock",
        Slot = {"go_m4_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(0, -5.15, -3),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(1.15, 1.15, 1.15)
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = {"go_perk", "go_homemade_auto"}
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(0.6, -3.25, 4),
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if self:GetBuff_Override("NoStock") then return "fire" end
    elseif anim == "fire_iron_empty" then
        if self:GetBuff_Override("NoStock") then return "fire_empty" end
    end
end

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
        -- Source = "idle",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
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
        LHIKOut = 0.7,
        LHIKEaseOut = 0.6
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
        LHIKEaseOut = 0.6
    },
    ["reload_smallmag"] = {
        Source = "reload_smallmag",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
        LHIKEaseOut = 0.6
    },
    ["reload_smallmag_empty"] = {
        Source = "reload_smallmag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
        LHIKEaseOut = 0.6
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_M4A1.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_M4A1.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_M4A1.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_M4A1.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_cliphit.wav"
})

sound.Add({
    name = "ARCCW_GO_M4A1.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_M4A1.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_boltback.wav"
})

--[[ OLD CODE

if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ar15")
    killicon.Add("arccw_horde_ar15", "arccw/weaponicons/arccw_go_ar15", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_ar15"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like

SWEP.AdminOnly = false
SWEP.PrintName = "AR-15"
SWEP.Slot = 2
SWEP.ViewModel = "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.Damage = 42
SWEP.DamageMin = 32 -- damage done at maximum range


SWEP.RecoilPunch = 0


SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.ShootVol = 75 -- volume of shoot sound

]]

function SWEP:DoShootSound(sndoverride, dsndoverride, voloverride, pitchoverride) -- For edited shooting sounds.
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

    if fsound then self:MyEmitSound(fsound, volume, pitch, 1, CHAN_STATIC) end -- Only use ONE instance of CHAN_STATIC for shooting sounds, any more will cause bugs. - func_brush

    local data = {
        sound   = fsound,
        volume  = volume,
        pitch   = pitch,
    }

    self:GetBuff_Hook("Hook_AddShootSound", data)
end