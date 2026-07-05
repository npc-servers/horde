if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_famas")
    killicon.Add("arccw_horde_famas", "arccw/weaponicons/arccw_go_famas", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_famas"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "FAMAS G1"

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_famas.mdl"

SWEP.Damage = 50
SWEP.DamageMin = 40
SWEP.Penetration = 15
SWEP.RecoilRise = 0.4
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 1200
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = -3,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.ShootVol = 75

SWEP.FirstShootSound = {
    ")horde/weapons/gso/famas/famas_01.wav",
    ")horde/weapons/gso/famas/famas_02.wav",
    ")horde/weapons/gso/famas/famas_03.wav"
}
SWEP.ShootSound = {
    ")horde/weapons/gso/famas/famas_01.wav",
    ")horde/weapons/gso/famas/famas_02.wav",
    ")horde/weapons/gso/famas/famas_03.wav"
}
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "^horde/weapons/gso/famas/famas_distant.wav"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)