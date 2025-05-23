if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "6-Round Magazine"
att.Icon = Material("entities/usas_mag_6.png", "smooth")
att.Description = "Shorter mag that handles better but reduces capacity."
att.Desc_Pros = {}
att.Desc_Cons = {
    "con.magcap"
}
att.Slot = "eap_usas_mag"
att.AutoStats = true

att.SortOrder = 6


att.Override_ClipSize = 6


att.Mult_SpeedMult = 1.1
att.Mult_SightTime = 0.8
att.Mult_ReloadTime = 0.9



att.Hook_TranslateAnimation = function(wep, anim)
     if anim == "reload" then
        return "reload_6"
    elseif anim == "reload_empty" then
        return "reload_empty_6"
    end
end

ArcCW.LoadAttachmentType(att, "eap_usas_mag_6")