if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m249para")
    killicon.Add("arccw_horde_m249", "arccw/weaponicons/arccw_go_m249para", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_m249para"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "M249 SAW"

SWEP.ViewModel = "models/weapons/arccw_go/v_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_mach_m249para.mdl"

SWEP.Primary.ClipSize = 100

SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.M249_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.M249_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.M249_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.Jamming = false
SWEP.HeatCapacity = false
SWEP.HeatDissipation = false
SWEP.HeatLockout = false
SWEP.HeatDelayTime = false

sound.Add( {
    name = "ArcCW_Horde.GSO.M249_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = ")arccw_go/m249/m249-1.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.M249_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m4a1/m4a1_silencer_01.wav"
} )