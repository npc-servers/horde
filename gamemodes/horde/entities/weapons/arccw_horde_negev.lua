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

SWEP.ViewModel = "models/weapons/arccw_go/v_mach_negev.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_mach_negev.mdl"

SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 700

SWEP.FirstShootSound = "ArcCW_Horde.GSO.Negev_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.Negev_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.Negev_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.Jamming = false
SWEP.HeatCapacity = false
SWEP.HeatDissipation = false
SWEP.HeatLockout = false
SWEP.HeatDelayTime = false

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