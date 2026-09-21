if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ace")
    killicon.Add("arccw_horde_ace", "arccw/weaponicons/arccw_go_ace", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_ace"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "ACE 22"

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_ace.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_ace.mdl"

SWEP.Damage = 54
SWEP.DamageMin = 44
SWEP.Penetration = 20
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 800

SWEP.ShootVol = 75

SWEP.FirstShootSound = {
    ")horde/weapons/gso/galil/galil_01.wav",
    ")horde/weapons/gso/galil/galil_02.wav",
    ")horde/weapons/gso/galil/galil_03.wav",
    ")horde/weapons/gso/galil/galil_04.wav"
}
SWEP.ShootSound = {
    ")horde/weapons/gso/galil/galil_01.wav",
    ")horde/weapons/gso/galil/galil_02.wav",
    ")horde/weapons/gso/galil/galil_03.wav",
    ")horde/weapons/gso/galil/galil_04.wav"
}
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "^horde/weapons/gso/galil/galil_distant.wav"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)