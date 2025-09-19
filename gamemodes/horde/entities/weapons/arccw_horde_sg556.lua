if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_sg556")
    killicon.Add("arccw_horde_sg556", "arccw/weaponicons/arccw_go_sg556", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_sg556"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "SIG SG556"

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_sg556.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_sg556.mdl"

SWEP.Damage = 64
SWEP.DamageMin = 48

SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 650

SWEP.FirstShootSound = "ArcCW_Horde.GSO.SG556_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.SG556_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.SG556_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

sound.Add( {
    name = "ArcCW_Horde.GSO.SG556_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/sg556/sg556_01.wav",")arccw_go/sg556/sg556_02.wav",")arccw_go/sg556/sg556_03.wav",")arccw_go/sg556/sg556_04.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.SG556_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m4a1/m4a1_silencer_01.wav"
} )