if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "Reinforced Stock"
att.Icon = Material("entities/usas_stock_reinforced.png", "mips smooth")
att.Description = "Strengthened polymer stock that improves control."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eap_usas_stock"



att.ActivateElements = {"stock_reinforced"}

att.Mult_RecoilSide = 0.75
att.Mult_SightTime = 1.1
att.Mult_HipDispersion = 0.9
att.Mult_DrawTime = 1.1

ArcCW.LoadAttachmentType(att, "eap_usas_stock_reinforced")