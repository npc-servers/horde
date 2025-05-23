if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "Light Stock"
att.Icon = Material("entities/usas_stock_light.png", "smooth")
att.Description = "Lightweight under-folding stock that improves mobility, but dampens recoil less."
att.SortOrder = 1000
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eap_usas_stock"

att.Mult_Recoil = 1.15
att.Mult_SightTime = 1.2
att.Mult_SpeedMult = 1.15

ArcCW.LoadAttachmentType(att, "eap_usas_stock_light")