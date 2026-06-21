if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "arccw/weaponicons/arccw_horde_bo_1911" )
    killicon.Add( "arccw_horde_bo_1911_frag", "arccw/weaponicons/arccw_horde_bo_1911", Color( 0, 0, 0, 255 ) )
end

SWEP.Base = "arccw_horde_bo_1911"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 1

SWEP.PrintName = "M1911 FRAG"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Classic starter weapon for any zombie environment.\nThis one is etched with the name 'Sally'."
SWEP.Trivia_Manufacturer = "Colt"
SWEP.Trivia_Calibre = ".45 ACP"
SWEP.Trivia_Mechanism = "Recoil-Operated"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = "1911"

SWEP.ViewModel = "models/horde/weapons/bo/1911/viewmodel.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.Range = 100
SWEP.DamageType = DMG_BLAST