SWEP.Base = "arccw_base"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "SIG SG556"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "Swiss rifle created for the civilian market. Designed primarily for export to the USA. Good at range. Modified to have a military fire group."
SWEP.Trivia_Manufacturer = "SIG Sauer"
SWEP.Trivia_Calibre = "5.56x45mm NATO"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1993

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_sg556.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_sg556.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 64
SWEP.DamageMin = 48
SWEP.Range = 150
SWEP.Penetration = 11
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil
SWEP.MuzzleVelocity = 1050 
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 900

SWEP.Recoil = 0.295
SWEP.RecoilSide = 0.18
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 700 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
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

SWEP.AccuracyMOA = 2 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 650 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "stanag" -- the magazine pool this gun draws from

SWEP.ShootVol = 75

SWEP.FirstShootSound = ")arccw_go/sg556/sg556_02.wav"
SWEP.ShootSound = {")arccw_go/sg556/sg556_01.wav",")arccw_go/sg556/sg556_03.wav",")arccw_go/sg556/sg556_04.wav"} -- When using stereo .wav files, add ) to the beginning to make it directional. - func_brush
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = ")arccw_go/sg556/sg556_distant.wav"

SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.30

SWEP.IronSightStruct = {
    Pos = Vector(-5.14, -8.573, 1.05),
    Ang = Angle(-0.75, 0.15, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, -3, 1)
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
    ["no_fh"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
        WMBodygroups = {{ind = 2, bg = 3}},
    },
    ["rs_none"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
        WMBodygroups = {{ind = 6, bg = 1}},
    },
    ["fs_down"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
        WMBodygroups = {{ind = 5, bg = 1}},
    },
    ["go_sg_stock_basilisk"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 4, bg = 1}},
    },
    ["go_stock_none"] = {
        VMBodygroups = {{ind = 4, bg = 2}},
        WMBodygroups = {{ind = 4, bg = 2}},
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 4, bg = 2},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube.mdl",
                Bone = "v_weapon.sg556_Parent",
                Offset = {
                    pos = Vector(-0.05, -3.06, -2.1),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
    ["go_sg_barrel_short"] = {
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
                vpos = Vector(-0.05, -3.15, 20),
            }
        }
    },
    ["go_sg_barrel_long"] = {
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
                vpos = Vector(-0.05, -3.15, 30.5),
            }
        }
    },
    ["go_sg_mag_20"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 3, bg = 1}},
    },
    ["go_556_ammo_60round"] = {
        VMBodygroups = {{ind = 3, bg = 2}},
        WMBodygroups = {{ind = 3, bg = 2}},
    },
}

SWEP.ExtraSightDist = 3
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12, 5.5, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic", "optic_lp"},
        Bone = "v_weapon.sg556_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.05, -4.8, 4),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        VMScale = Vector(1, 1, 1),
        InstalledEles = {"rs_none", "fs_down"},
        CorrectiveAng = Angle(1.5, 0, 0),
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.sg556_Parent",
        Offset = {
            vpos = Vector(0, -1.6, 15),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.sg556_Parent",
        Offset = {
            vpos = Vector(0.7, -3.5, 18),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
    },
    {
        PrintName = "Barrel",
        Slot = "go_sg_barrel",
        DefaultAttName = "420mm Standard Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.sg556_Parent",
        Offset = {
            vpos = Vector(-0.05, -3.15, 25),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"no_fh"},
    },
    {
        PrintName = "Magazine",
        Slot = {"go_sg_mag", "go_ammo_556_60"},
        DefaultAttName = "30-Round 5.56mm SIG"
    },
    {
        PrintName = "Stock",
        Slot = {"go_sg_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.sg556_Parent",
        Offset = {
            vpos = Vector(-0.05, -3.06, -2.1),
            vang = Angle(90, 0, -90),
        },
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
        Bone = "v_weapon.sg556_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.5, -3.25, 6.5), -- offset that the attachment will be relative to the bone
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
        Source = "shoot",
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
        LHIKEaseIn = 0.6,
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
        LHIKOut = 1.5,
        LHIKEaseOut = 0.5
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_SG556.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/sg556/sg556_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_SG556.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/sg556/sg556_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_SG556.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/sg556/sg556_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_SG556.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/sg556/sg556_cliphit.wav"
})

sound.Add({
    name = "ARCCW_GO_SG556.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/sg556/sg556_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_SG556.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/sg556/sg556_boltback.wav"
})

--[[ OLD CODE

if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_sg556")
    killicon.Add("arccw_horde_sg556", "arccw/weaponicons/arccw_go_sg556", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_sg556"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "SIG SG556"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_sg556.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_sg556.mdl"

SWEP.Damage = 64
SWEP.DamageMin = 48  -- damage done at maximum range
SWEP.RecoilPunch = 0
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