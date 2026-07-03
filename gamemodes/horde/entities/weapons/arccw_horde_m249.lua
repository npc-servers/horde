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
SWEP.Damage = 51
SWEP.DamageMin = 41
SWEP.Primary.ClipSize = 150
SWEP.Delay = 60 / 900
SWEP.RecoilPunch = 0
SWEP.ShootSpeedMult = 0.85

SWEP.ShootVol = 75

SWEP.FirstShootSound = {
    ")horde/weapons/gso/m249/m249_01.wav",
    ")horde/weapons/gso/m249/m249_02.wav",
    ")horde/weapons/gso/m249/m249_03.wav"
}
SWEP.ShootSound = {
    ")horde/weapons/gso/m249/m249_01.wav",
    ")horde/weapons/gso/m249/m249_02.wav",
    ")horde/weapons/gso/m249/m249_03.wav"
}
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = ")horde/weapons/gso/m249/m249_distant.wav"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.Jamming = false
SWEP.HeatCapacity = false
SWEP.HeatDissipation = false
SWEP.HeatLockout = false
SWEP.HeatDelayTime = false