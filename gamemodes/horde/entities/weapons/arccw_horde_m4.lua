if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m4")
    killicon.Add("arccw_horde_m4", "arccw/weaponicons/arccw_go_m4", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_m4"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "M4A1"

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_m4a1.mdl"

SWEP.Damage = 60
SWEP.DamageMin = 45

SWEP.Recoil = 0.3
SWEP.RecoilSide = 0.25
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 800

SWEP.FirstShootSound = "ArcCW_Horde.GSO.M4_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.M4_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.M4_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

sound.Add( {
    name = "ArcCW_Horde.GSO.M4_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/m4a1/m4a1_01.wav",")arccw_go/m4a1/m4a1_02.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.M4_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m4a1/m4a1_silencer_01.wav"
} )