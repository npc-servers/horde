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

SWEP.ShootSound = "ArcCW_Horde.Striker_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.Striker_Fire_Sil"

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(4.4, 0, 2.2),
            vang = Angle(0, 0, 0),
        },
        InstalledEles = {"sight"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle_shotgun",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(15, 0, 1),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1.25, 1.25, 1.25),
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(10, 0, 0.34),
            vang = Angle(0, 0, 0),
        },
        InstalledEles = {"grip"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(10, 0.5, 1),
            vang = Angle(0, 0, -90),
        },
        SlideAmount = {
            vmin = Vector(7.5, 0.5, 1),
            vmax = Vector(10, 0.5, 1),
        },
    },
    {
        PrintName = "Fire Group",
        Slot = "fcg",
        DefaultAttName = "Standard FCG"
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Buckshot Shells"
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
            vpos = Vector(1, -0.5, 0.8),
            vang = Angle(0, 0, 0),
        },
    },
}

sound.Add({
    name = "ArcCW_Horde.Striker_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {95, 110},
    sound = ")weapons/fesiugmw2/fire/shot_stryker.wav"
})

sound.Add({
    name = "ArcCW_Horde.Striker_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {95, 110},
    sound = ")weapons/fesiugmw2/fire/shot_sil.wav"
})