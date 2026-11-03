PERK.PrintName = "Judgement"
PERK.Icon = "materials/perks/paladin/judgement.png"
PERK.Description = [[
Healing players gives "Judgement" buff for 10 seconds.
25% of Buffed player's damage dealt buildups Shock debuff on enemies.]]
PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnPlayerHeal = function( ply, healinfo )
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk( "paladin_judgement" ) then
        ply:Horde_AddJudgement( 10 )
    end
end