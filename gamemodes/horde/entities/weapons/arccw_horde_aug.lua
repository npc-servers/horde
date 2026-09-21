if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_aug")
    killicon.Add("arccw_horde_aug", "arccw/weaponicons/arccw_go_aug", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_aug"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "AUG A3"

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_aug.mdl"

SWEP.Damage = 62
SWEP.DamageMin = 46
SWEP.Penetration = 15
SWEP.Primary.ClipSize = 42

SWEP.Recoil = 0.4
SWEP.RecoilSide = 0.3
SWEP.RecoilPunch = 0

SWEP.ShootVol = 75

SWEP.FirstShootSound = {
    ")horde/weapons/gso/aug/aug_01.wav",
    ")horde/weapons/gso/aug/aug_02.wav",
    ")horde/weapons/gso/aug/aug_03.wav",
    ")horde/weapons/gso/aug/aug_04.wav"
}
SWEP.ShootSound = {
    ")horde/weapons/gso/aug/aug_01.wav",
    ")horde/weapons/gso/aug/aug_02.wav",
    ")horde/weapons/gso/aug/aug_03.wav",
    ")horde/weapons/gso/aug/aug_04.wav"
}
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "^horde/weapons/distshot.wav"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.Attachments = {
    {},{},{},{},{},
    {
        DefaultAttName = "42-Round 5.56mm Poly"
    },
}