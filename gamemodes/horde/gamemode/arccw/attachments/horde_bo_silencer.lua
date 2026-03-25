if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "Silencer"
att.Icon = Material( "arccw/hud/atts/default.png", "mips smooth" )
att.Description = "Reduces muzzleflash and sound profile."
att.Desc_Pros = {}
att.Desc_Cons = {}
att.Slot = "horde_bo_muzzle"
att.AutoStats = true

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"

att.Mult_AccuracyMOA = 1.1
att.Mult_SightTime = 1.05

att.ActivateElements = { "silencer" }

ArcCW.LoadAttachmentType( att, "horde_bo_silencer" )