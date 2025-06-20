if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_m14")
    killicon.Add("arccw_horde_m14", "arccw/weaponicons/arccw_m14", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_abase"
SWEP.Slot = 2
SWEP.ViewModelFOV = 75

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "M14"
SWEP.Trivia_Class = "Rifle"
SWEP.Trivia_Desc = "Multi-purpose United States military rifle."
SWEP.Trivia_Calibre = "5.56x45mm NATO"

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/v_bo1_m14.mdl"
SWEP.WorldModel = "models/weapons/w_annabelle.mdl"

SWEP.MirrorVMWM = true

SWEP.WorldModelOffset = {
    pos = Vector(-5, 5, -3.5),
    ang = Angle(-10, 0, 180)
}

SWEP.Damage = 55
SWEP.DamageMin = 30
SWEP.Range = 1250 * 0.025
SWEP.Penetration = 5
SWEP.DamageType = DMG_BULLET

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 20

SWEP.Recoil = 0.5
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.4

SWEP.Delay = 60/600
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1,
    }
}

SWEP.AccuracyMOA = 0
SWEP.HipDispersion = 150
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "smg1"

SWEP.ShootPitch = 115

SWEP.ShootSound = {")weapons/arccw/bo1_m14/bo1/shot_00.wav",")weapons/arccw/bo1_m14/bo1/shot_01.wav",")weapons/arccw/bo1_m14/bo1/shot_02.wav",")weapons/arccw/bo1_m14/bo1/shot_03.wav",")weapons/arccw/bo1_m14/bo1/shot_04.wav"}
SWEP.ShootMechSound = nil
SWEP.ShootSoundExt = {")weapons/arccw/bo1_m14/bo1/dist_00.wav",")weapons/arccw/bo1_m14/bo1/dist_01.wav",")weapons/arccw/bo1_m14/bo1/dist_02.wav",")weapons/arccw/bo1_m14/bo1/dist_03.wav",")weapons/arccw/bo1_m14/bo1/dist_04.wav"}
SWEP.ShootSoundExtExt = {"weapons/arccw/bo1_m14/bo1/lfe_00.wav"}
SWEP.ShootSoundSilenced = {")weapons/fesiugmw2/fire/sniper_sil.wav"}

SWEP.MuzzleEffect = "muzzleflash_3"

SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1
SWEP.CaseEffectAttachment = 2
SWEP.CamAttachment = 3

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.6

SWEP.IronSightStruct = {
    Pos = Vector(-3.40, -4.11, 1.067),
    Ang = Angle(-0.38, 0.018, 0),
    Magnification = 1.2,
    SwitchToSound = "",
    ViewModelFOV = 75,
    CrosshairInSights = false
}

SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.SprintPos = Vector(0, 0, 0)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.BarrelLength = 32

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"optic"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(10, 0, 1.4),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1, 1, 1),
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"muzzle"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(25.5, 0, 0.74),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1, 1, 1),
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "20-Round 5.56mm",
        Slot = {"ammo_m14"},
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(10, 0, -0.5),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1, 1, 1),
    },
    {
        PrintName = "Tactical",
        Slot = {"tac"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(15, 0, -0.25),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(0.8, 0.8, 0.8),
    },
    {
        PrintName = "Ammo Type",
        Slot = {"go_ammo"},
        DefaultAttName = "Standard Ammo",
    },
    {
        PrintName = "Perk",
        Slot = {"go_perk"},
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(5.4, -0.85, 0.72),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(0.5, 0.5, 0.5),
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "reg_idle",
    },
    ["enter_sprint"] = {
        Source = "reg_sprint_in",
    },
    ["idle_sprint"] = {
        Source = "reg_sprint",
    },
    ["exit_sprint"] = {
        Source = "reg_sprint_out",
    },
    ["ready"] = {
        Source = "reg_draw_first",
        SoundTable = {{s = "ArcCw_Horde_M14.Equip", t = 0, c = CHAN_ITEM}},
    },
    ["draw"] = {
        Source = "reg_draw",
        SoundTable = {{s = "ArcCw_Horde_M14.Foley2", t = 0, c = CHAN_ITEM}},
    },
    ["holster"] = {
        Source = "reg_holster",
        SoundTable = {{s = "ArcCw_Horde_M14.Foley2", t = 0, c = CHAN_ITEM}},
    },
    ["fire"] = {
        Source = "reg_fire",
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "reg_ads_fire",
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reg_reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    },
    ["reload_empty"] = {
        Source = "reg_reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1.8,
    },
}

sound.Add({
    name = "ArcCw_Horde_M14.BoltBack",
    sound = "weapons/arccw/bo1_m14/fly_m14_bolt_back.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.BoltRelease",
    sound = "weapons/arccw/bo1_m14/fly_m14_bolt_release.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.Foley",
    sound = {"weapons/arccw/bo1_shared/fly_gear_reload_plr_00.wav","weapons/arccw/bo1_shared/fly_gear_reload_plr_01.wav","weapons/arccw/bo1_shared/fly_gear_reload_plr_02.wav","weapons/arccw/bo1_shared/fly_gear_reload_plr_03.wav"},
    channel = CHAN_ITEM,
    volume = 0.45
})
sound.Add({
    name = "ArcCw_Horde_M14.Foley2",
    sound = {")weapons/arccw/bo1_shared/rattle_00.wav",")weapons/arccw/bo1_shared/rattle_01.wav",")weapons/arccw/bo1_shared/rattle_02.wav",")weapons/arccw/bo1_shared/rattle_03.wav",")weapons/arccw/bo1_shared/rattle_04.wav"},
    channel = CHAN_ITEM,
    volume = 0.45
})
sound.Add({
    name = "ArcCw_Horde_M14.Equip",
    sound = {")weapons/arccw/bo1_shared/pickup_00.wav",")weapons/arccw/bo1_shared/pickup_01.wav",")weapons/arccw/bo1_shared/pickup_02.wav"},
    channel = CHAN_ITEM
})
sound.Add({
    name = "ArcCw_Horde_M14.MagIn1",
    sound = "weapons/arccw/bo1_m14/fly_m14_mag_in.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.MagIn2",
    sound = "weapons/arccw/bo1_m14/fly_m14_tap.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.MagOut",
    sound = "weapons/arccw/bo1_m14/fly_m14_mag_out.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.MagRattle",
    sound = "weapons/arccw/bo1_m14/fly_m14_futz.wav"
})

function SWEP:DoShootSound(sndoverride, dsndoverride, voloverride, pitchoverride)
    local fsound = self.ShootSound
    local msound = self.ShootMechSound

    local extsound = self.ShootSoundExt
    local extextsound = self.ShootSoundExtExt

    fsound = self:GetBuff_Hook("Hook_GetShootSound", fsound)
    msound = self:GetBuff_Hook("Hook_GetShootMechSound", msound)

    -- Ringoff & LFE
    extsound = self:GetBuff_Hook("Hook_GetShootSoundExt", extsound)
    extextsound = self:GetBuff_Hook("Hook_GetShootSoundExtExt", extextsound)

    local suppressed = self:GetBuff_Override("Silencer")
    if suppressed then
        fsound = self.ShootSoundSilenced
        pitch = 100
        msound = nil
        extsound = nil
        extextsound = nil
    end

    local spv    = self.ShootPitchVariation
    local volume = self.ShootVol
    local pitch  = self.ShootPitch * math.Rand(1 - spv, 1 + spv) * self:GetBuff_Mult("Mult_ShootPitch")

    local v = GetConVar("arccw_weakensounds"):GetFloat()
    volume = volume - v

    volume = volume * self:GetBuff_Mult("Mult_ShootVol")

    volume = math.Clamp(volume, 51, 149)
    pitch  = math.Clamp(pitch, 0, 255)

    if sndoverride then fsound = sndoverride end
    if voloverride then volume = voloverride end
    if pitchoverride then pitch = pitchoverride end

    if fsound then self:MyEmitSound(fsound, volume, pitch, 1, CHAN_WEAPON) end

    -- Ringoff & LFE
    if extsound then self:MyEmitSound(extsound, volume, pitch, 1, CHAN_WEAPON + 1) end
    if extextsound then self:MyEmitSound(extextsound, 45, pitch, 1, CHAN_AUTO) end

    if msound then self:MyEmitSound(msound, 45, math.Rand(95, 105), .45, CHAN_AUTO) end

    local data = {
        sound   = fsound,
        volume  = volume,
        pitch   = pitch,
    }

    self:GetBuff_Hook("Hook_AddShootSound", data)
end
