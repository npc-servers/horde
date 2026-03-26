if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mac10")
    killicon.Add("arccw_horde_mac10", "arccw/weaponicons/arccw_go_mac10", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_mac10"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "MAC-10"

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mac10.mdl"

SWEP.Damage = 32
SWEP.DamageMin = 20

SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.MAC10_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.MAC10_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.MAC10_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.mac10_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0.15, -5.25, -4),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"sidemount"},
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.mac10_parent",
        DefaultAttName = "Standard Foregrip",
        Offset = {
            vpos = Vector(0, -1.25, 8),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.mac10_parent",
        Offset = {
            vpos = Vector(1, -3.5, 3.5),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_mac10_barrel",
        DefaultAttName = "150mm MAC Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.mac10_parent",
        Offset = {
            vpos = Vector(0.025, -3, 7.5),
            vang = Angle(90, 0, -90),
        },
        ExcludeFlags = {"go_mac10_barrel_stub"}
    },
    {
        PrintName = "Magazine",
        Slot = "go_mac10_mag",
        DefaultAttName = "32-Round .45 Ingram"
    },
    {
        PrintName = "Stock",
        Slot = {"go_mac10_stock", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.mac10_parent",
        Offset = {
            vpos = Vector(0, -2.75, -3.75),
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
        Slot = {"go_perk", "go_perk_smg"}
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.mac10_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(1, -2.5, 2), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}
sound.Add( {
    name = "ArcCW_Horde.GSO.MAC10_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/mac10/mac10_01.wav",")arccw_go/mac10/mac10_02.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.MAC10_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/mp5/mp5_01.wav"
} )