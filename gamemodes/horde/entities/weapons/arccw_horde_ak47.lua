if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ak47")
    killicon.Add("arccw_horde_ak47", "arccw/weaponicons/arccw_go_ak47", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_ak47"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "AKM"

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

SWEP.Damage = 68
SWEP.DamageMin = 50

SWEP.Recoil = 0.45
SWEP.RecoilSide = 0.35
SWEP.RecoilPunch = 0

SWEP.ShootSound = "ArcCW_Horde.GSO.AK47_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.AK47_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

sound.Add( {
    name = "ArcCW_Horde.GSO.AK47_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = ")arccw_go/ak47/ak47_01.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.AK47_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m4a1/m4a1_silencer_01.wav"
} )