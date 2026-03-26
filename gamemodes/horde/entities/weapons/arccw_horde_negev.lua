if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_negev")
    killicon.Add("arccw_horde_negev", "arccw/weaponicons/arccw_go_negev", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_negev"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "Negev"

SWEP.ViewModel = "models/horde/weapons/c_horde_mach_negev.mdl"
SWEP.WorldModel = "models/horde/weapons/c_horde_mach_negev.mdl"

SWEP.RecoilPunch = 0
SWEP.Damage = 56
SWEP.DamageMin = 46
SWEP.Delay = 60 / 700

SWEP.FirstShootSound = "ArcCW_Horde.GSO.Negev_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.Negev_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.Negev_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.Jamming = false
SWEP.HeatCapacity = false
SWEP.HeatDissipation = false
SWEP.HeatLockout = false
SWEP.HeatDelayTime = false

SWEP.AttachmentElements = {
    ["rs_none"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 8, bg = 1}},
    },
    ["fh_none"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
    },
    ["go_negev_belt_100"] = {
        VMBodygroups = {
            {ind = 0, bg = 1},
            {ind = 4, bg = 1},
            {ind = 3, bg = 1},
        },
    },
    ["horde_negev_hemo_belt"] = {
        VMBodygroups = {
            {ind = 4, bg = 2},
            {ind = 3, bg = 2},
        },
    },
    ["go_negev_barrel_short"] = {
        VMBodygroups = {
        {ind = 1, bg = 1},
        {ind = 2, bg = 1}},
        AttPosMods = {
            [5] = {vpos = Vector(0, -5.1, 19)},
        }
    },
    ["go_negev_barrel_long"] = {
        VMBodygroups = {
        {ind = 1, bg = 2},
        {ind = 2, bg = 2}},
        AttPosMods = {
            [5] = {vpos = Vector(0, -5.1, 29.5)},
        }
    },
    ["go_negev_stock_in"] = {
        VMBodygroups = {{ind = 7, bg = 1}},
    },
    ["go_stock_none"] = {
        VMBodygroups = {{ind = 7, bg = 2}},
    },
    ["go_stock"] = {
        VMBodygroups = {{ind = 7, bg = 2}},
    },
}

sound.Add( {
    name = "ArcCW_Horde.GSO.Negev_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/negev/negev_01.wav",")arccw_go/negev/negev_02.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.Negev_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m4a1/m4a1_silencer_01.wav"
} )