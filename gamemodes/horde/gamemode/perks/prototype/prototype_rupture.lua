PERK.PrintName = "Rupture"
PERK.Icon = "materials/perks/kamikaze.png"
PERK.Description = [[
Enemies killed have a 50% chance to explode upon death.
Explosions deal 25% of an enemies max health.]]

PERK.Hooks = {}
PERK.Hooks.Horde_OnEnemyKilled = function( victim, killer, inflictor )
    if not killer:Horde_GetPerk( "prototype_rupture" ) then return end
    if not IsValid( inflictor ) or inflictor:IsNPC() then return end

    local p = math.random()
    if p > 0.5 then return end

	local npcPos = victim:GetPos()

	local effect = EffectData()
	effect:SetOrigin( npcPos )
	util.Effect( "horde_hemo_explosion", effect )

	victim:EmitSound( victim:Horde_IsElite() and "horde/player/prototype/Explosion 2.wav" or "horde/player/prototype/Explosion 1.wav", 140, math.random( 95, 105 ), 1, CHAN_STATIC )

	local dmg = DamageInfo()
	dmg:SetAttacker( killer )
	dmg:SetInflictor( victim )
	dmg:SetDamageType( DMG_BLAST )
	dmg:SetDamage( victim:GetMaxHealth() * 0.25 )
	dmg:SetDamageCustom( HORDE.DMG_PLAYER_FRIENDLY )

	util.BlastDamageInfo( dmg, npcPos, 300 )
end
