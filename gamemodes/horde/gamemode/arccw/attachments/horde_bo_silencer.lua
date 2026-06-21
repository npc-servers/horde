if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "Silencer"
att.Icon = Material( "entities/acwatt_go_supp_rotor43.png", "mips smooth" )
att.Description = "Standard sound suppressor."
att.Desc_Pros = {}
att.Desc_Cons = {}
att.Slot = "horde_bo_muzzle"
att.AutoStats = true

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"

att.Mult_AccuracyMOA = 1.1
att.Mult_SightTime = 1.05

att.Mult_Range = 1.05

att.ActivateElements = { "silencer" }

ArcCW.LoadAttachmentType( att, "horde_bo_silencer" )
