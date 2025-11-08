if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_horde_striker")
    killicon.Add("arccw_horde_striker", "arccw/weaponicons/arccw_horde_striker", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_striker"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "Striker"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_striker_1.mdl"
SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"

SWEP.Damage = 43
SWEP.DamageMin = 25
SWEP.Range = 25
SWEP.Penetration = 12

SWEP.AccuracyMOA = 75

SWEP.ShootSound = "ArcCW_Horde.MW2.Striker_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.Striker_Fire_Sil"

SWEP.GuaranteeLaser = true

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

SWEP.Attachments = {
    {},{},{},
    {
        Offset = {
            vpos = Vector(10, 0.7, 1),
            vang = Angle(0, 0, -90),
        },
        SlideAmount = false,
    },{},
    {
        Slot = "go_ammo"
    },
    {
        Slot = "go_perk"
    },{},
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(0.5, -0.4, 0.8),
            vang = Angle(0, 0, 0),
        },
    },
}

local reloadMult = 0.6

SWEP.Animations = {
    ["sgreload_start"] = {
        Source = "reload_start",
        Time = 43/40,
        MinProgress = 0.85,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_striker_reload_lift_v1.wav", t = 0},
            {s = "weapons/fesiugmw2/foley/wpfoly_striker_reload_shell_v1.wav", t = 20/40 * reloadMult},
            {s = "weapons/fesiugmw2/foley/wpfoly_striker_reload_button_v1.wav", t = 36/40 * reloadMult},
        },
        RestoreAmmo = 1,
        Mult = reloadMult,
    },
    ["sgreload_insert"] = {
        Source = "reload_loop",
        Time = 26/40,
        MinProgress = 0.3,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_striker_reload_shell_v1.wav", t = 3/40 * reloadMult},
            {s = "weapons/fesiugmw2/foley/wpfoly_striker_reload_button_v1.wav", t = 19/40 * reloadMult},
        },
        TPAnimStartTime = 0.3,
        Mult = reloadMult,
    },
    ["sgreload_finish"] = {
        Source = "reload_finish",
        Time = 13/30,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_striker_reload_end_v1.wav", t = 0},
        },
        Mult = reloadMult,
    },
    ["sgreload_finish_empty"] = {
        Source = "reload_finish",
        Time = 13/30,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_striker_reload_end_v1.wav", t = 0},
        },
        Mult = reloadMult,
    },
}

sound.Add( {
    name = "ArcCW_Horde.MW2.Striker_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/shot_stryker.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.Striker_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")weapons/fesiugmw2/fire/shot_sil.wav"
} )
