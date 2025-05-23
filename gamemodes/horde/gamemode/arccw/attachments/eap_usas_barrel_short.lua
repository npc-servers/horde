if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "Sawn-off Barrel"
att.Icon = Material("entities/usas_shorty.png", "smooth")
att.Description = "Fairly shorter barrel. Not that precise, but great for CQB."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eap_usas_barrel"

att.Mult_AccuracyMOA = 1.25
att.Mult_SightTime = 0.9
att.Mult_MoveSpeed = 1.03

att.Override_MuzzleEffectAttachment = 3

ArcCW.LoadAttachmentType(att, "eap_usas_barrel_short")