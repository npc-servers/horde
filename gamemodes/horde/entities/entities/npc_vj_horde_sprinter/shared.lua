ENT.Base = "npc_vj_creature_base"
ENT.Type = "ai"
ENT.PrintName = "Sprinter"
ENT.Author = "DrVrej"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose = "Spawn it and fight with it!"
ENT.Instructions = "Click on the spawnicon to spawn it."
ENT.Category = "Zombies"

if (CLIENT) then
	local Name = "Sprinter"
	local LangName = "npc_vj_horde_sprinter"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end

VJ.AddNPC("Sprinter","npc_vj_horde_sprinter","Zombies")