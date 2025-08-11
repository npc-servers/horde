if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_aug")
    killicon.Add("arccw_horde_aug", "arccw/weaponicons/arccw_go_aug", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_aug"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "AUG A3"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_aug.mdl"

SWEP.Damage = 63
SWEP.DamageMin = 47 -- damage done at maximum range

SWEP.RecoilPunch = 0.45

SWEP.Delay = 60 / 700

SWEP.FirstShootSound = ")arccw_go/aug/aug_02.wav"
SWEP.ShootSound =  {")arccw_go/aug/aug_01.wav",")arccw_go/aug/aug_03.wav",")arccw_go/aug/aug_04.wav"}
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = ")arccw_go/aug/aug_distant.wav"

SWEP.RecoilSide = 0.1
