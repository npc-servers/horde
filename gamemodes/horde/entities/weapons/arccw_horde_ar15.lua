if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ar15")
    killicon.Add("arccw_horde_ar15", "arccw/weaponicons/arccw_go_ar15", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_ar15"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like

SWEP.AdminOnly = false
SWEP.PrintName = "AR-15"
SWEP.Slot = 2
SWEP.ViewModel = "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.Damage = 42
SWEP.DamageMin = 32 -- damage done at maximum range


SWEP.RecoilPunch = 0.8


SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    }
}

SWEP.FirstShootSound = {")arccw_go/m4a1/m4a1_us_04.wav"}
SWEP.ShootSound =  {")arccw_go/m4a1/m4a1_us_01.wav",")arccw_go/m4a1/m4a1_us_02.wav",")arccw_go/m4a1/m4a1_us_03.wav"}
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = {")arccw_go/m4a1/m4a1_us_distant.wav",")arccw_go/m4a1/m4a1_us_distant_02.wav",")arccw_go/m4a1/m4a1_us_distant_03.wav"}

SWEP.Delay = 60 / 675

SWEP.RecoilSide = 0.1