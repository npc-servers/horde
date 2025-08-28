if not ArcCWInstalled then return end

SWEP.Base = "arccw_mw2_intervention"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "Intervention"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_intervention.mdl"
SWEP.WorldModel = "models/weapons/w_snip_awp.mdl"

SWEP.Damage = 725
SWEP.DamageMin = 725

SWEP.ShootSound = "ArcCW_Horde.Intervention_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.Intervention_Fire_Sil"

SWEP.MuzzleEffect = "muzzleflash_5"

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"optic_sniper","optic"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(4.2, 0, 3),
            vang = Angle(0, 0, 0),
        },
        Installed = "optic_cheytacscope"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(39, 0, 1.6),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1.75, 1.75, 1.75)
    },
    {
        PrintName = "Tactical",
        Slot = {"tac","mw2_hidelaser"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(16.5, -0.15, 2.5),
            vang = Angle(0, 0, 180),
        },
        InstalledEles = {"nolaser"},
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Camouflage",
        DefaultAttName = "None",
        Slot = "mw2_wepcamo",
        FreeSlot = true,
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(2.7, -0.4, -0.95),
            vang = Angle(0, 0, 0),
        },
    },
}

sound.Add({
    name = "ArcCW_Horde.Intervention_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {95, 110},
    sound = ")weapons/fesiugmw2/fire/cheytac_mp.wav"
})

sound.Add({
    name = "ArcCW_Horde.Intervention_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {95, 110},
    sound = ")weapons/fesiugmw2/fire/sniper_sil.wav"
})