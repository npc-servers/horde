if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ump")
    killicon.Add("arccw_horde_ump", "arccw/weaponicons/arccw_go_ump", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_ump"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "UMP-45"

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_ump45.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_ump45.mdl"

SWEP.Damage = 53
SWEP.DamageMin = 43
SWEP.Penetration = 15

SWEP.RecoilPunch = 0

SWEP.ShootVol = 80
SWEP.FirstShootSound = ")arccw_go/ump45/ump45_02.wav"
SWEP.ShootSound = ")arccw_go/ump45/ump45_02.wav"
SWEP.ShootSoundSilenced = ")arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "^horde/weapons/distshot.wav"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)