if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_spas12")
    killicon.Add("arccw_horde_spas12", "arccw/weaponicons/arccw_mw2_spas12", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_spas12"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "SPAS-12"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_spas12.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

SWEP.AccuracyMOA = 55

SWEP.ShootSound = "ArcCW_Horde.MW2.Spas_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.Spas_Fire_Sil"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG

SWEP.GuaranteeLaser = true

SWEP.RejectAttachments = {["go_fore_bipod"] = true}

SWEP.Attachments = {
    {},{},
    {
        Offset = {
            vpos = Vector(-2, 0, -0.8),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = false
    },
    {
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(19.5, -0.32, 1.5),
            vang = Angle(0, 0, 90),
        },
    },
    {
        Slot = "go_ammo"
    },
    {
        Slot = "go_perk"
    },{},
    {
        Offset = {
            vpos = Vector(2, -0.4, 0.9),
            vang = Angle(0, 0, 0),
        },
    },
}

local reloadMult = 0.6

SWEP.Animations = {
    ["cycle"] = {
        Source = "rechamber",
        Time = 28/30,
        MinProgress = 0.469,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav",    t = 4/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav",   t = 10/30},
        },
        ShellEjectAt = 2/30,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
    },
    ["cycle_iron"] = {
        Source = "rechamber_ads",
        Time = 28/30,
        MinProgress = 0.469,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav",    t = 1/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav",   t = 8/30},
        },
        ShellEjectAt = 2/30,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
    },
    ["sgreload_start"] = {
        Source = "reload_start",
        Time = 40/30,
        MinProgress = 0.6,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        RestoreAmmo = 1,
        SoundTable = {
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_lift_v1.wav", t = 0 },
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_loop_v1.wav", t = 24/30 * reloadMult },
        },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        Mult = reloadMult,
    },
    ["sgreload_insert"] = {
        Source = "reload_loop",
        Time = 26/40,
        MinProgress = 1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = { { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_loop_v1.wav", t = 3/30 * reloadMult } },
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
        Mult = reloadMult,
    },
    ["sgreload_finish"] = {
        Source = "reload_finish",
        Time = 30/30,
        SoundTable = {
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", t = 6/30 * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", t = 12/30 * reloadMult },
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.8,
        Mult = reloadMult,
    },
    ["sgreload_finish_empty"] = {
        Source = "reload_finish",
        Time = 30/30,
        SoundTable = {
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", t = 6/30 * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", t = 12/30 * reloadMult },
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.8,
        Mult = reloadMult,
    },
    ["cycle_fgrip"] = {
        Source = "rechamber_fgrip",
        Time = 28/30,
        MinProgress = 0.469,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav",    t = 4/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav",   t = 10/30},
        },
        ShellEjectAt = 2/30,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
    },
    ["cycle_iron_fgrip"] = {
        Source = "rechamber_ads_fgrip",
        Time = 28/30,
        MinProgress = 0.469,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav",    t = 1/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav",   t = 8/30},
        },
        ShellEjectAt = 2/30,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
    },
    ["sgreload_start_fgrip"] = {
        Source = "reload_start_fgrip",
        Time = 40/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        RestoreAmmo = 1,
        SoundTable = {
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_lift_v1.wav", t = 0 },
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_loop_v1.wav", t = 24/30 * reloadMult },
        },
        Mult = reloadMult,
    },
    ["sgreload_insert_fgrip"] = {
        Source = "reload_loop_fgrip",
        Time = 26/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = { { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_loop_v1.wav", t = 3/30 * reloadMult } },
        TPAnimStartTime = 0.3,
        Mult = reloadMult,
    },
    ["sgreload_finish_fgrip"] = {
        Source = "reload_finish_fgrip",
        Time = 30/30,
        SoundTable = {
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", t = 6/30 * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", t = 12/30 * reloadMult },
        },
        Mult = reloadMult,
    },
    ["sgreload_finish_empty_fgrip"] = {
        Source = "reload_finish_fgrip",
        Time = 30/30,
        SoundTable = {
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", t = 6/30 * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", t = 12/30 * reloadMult },
        },
        Mult = reloadMult,
    },
}

sound.Add( {
    name = "ArcCW_Horde.MW2.Spas_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/shot_ranger.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.Spas_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")weapons/fesiugmw2/fire/shot_sil.wav"
} )