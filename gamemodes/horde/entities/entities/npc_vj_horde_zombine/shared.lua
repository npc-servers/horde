ENT.Base = "npc_vj_creature_base"
ENT.Type = "ai"
ENT.PrintName = "Zombine"
ENT.Author = "DrVrej"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose = "Spawn it and fight with it!"
ENT.Instructions = "Click on the spawnicon to spawn it."
ENT.Category = "Zombies"

if (CLIENT) then
	local Name = "Zombine"
	local LangName = "npc_vj_horde_zombine"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end

VJ.AddNPC("Zombine","npc_vj_horde_zombine","Zombies")