ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Sorcerer"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Category		= "Zombies"

if ( CLIENT ) then
    local Name = "Sorcerer"
    local LangName = "npc_vj_horde_sorcerer"
    language.Add( LangName, Name )
    killicon.Add( LangName, "HUD/killicons/default", Color( 255, 80, 0, 255 ) )
    language.Add( "#" .. LangName, Name )
    killicon.Add( "#" .. LangName, "HUD/killicons/default", Color( 255, 80, 0, 255 ) )
end
