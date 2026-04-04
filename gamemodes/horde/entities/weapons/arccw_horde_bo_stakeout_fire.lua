if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "arccw/weaponicons/arccw_horde_bo_stakeout" )
    killicon.Add( "arccw_horde_bo_stakeout_fire", "arccw/weaponicons/arccw_horde_bo_stakeout", Color( 0, 0, 0, 255 ) )
end

SWEP.Base = "arccw_horde_bo_stakeout"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 3

SWEP.PrintName = "Stakeout Incendiary"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "Modified version of the Ithaca 37 shotgun loaded with Dragon's Breath rounds.\nA novelty for committing war crimes against the NVA."
SWEP.Trivia_Manufacturer = "Ithaca"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Pump-Action"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1933"

SWEP.ViewModel = "models/ma85_bo/stakeout/viewmodel.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

SWEP.Range = 50
SWEP.Penetration = 2
SWEP.DamageType = DMG_BURN

SWEP.DistantShootSound = ")horde/weapons/bo_shared/spas_flame_00.wav"