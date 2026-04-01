ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "I Like Yha Cut G"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Category		= "Zombies"

if ( CLIENT ) then
    local Name = "I Like Yha Cut G"
    local LangName = "npc_vj_april1_horde_cutg"
    language.Add( LangName, Name )
    killicon.Add( LangName, "HUD/killicons/default", Color( 255, 80, 0, 255 ) )
    language.Add( "#" .. LangName, Name )
    killicon.Add( "#" .. LangName, "HUD/killicons/default", Color( 255, 80, 0, 255 ) )
end