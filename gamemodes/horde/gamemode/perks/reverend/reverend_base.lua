PERK.PrintName = "Reverend Base"
PERK.Description = [[
The Reverend subclass is a hybrid subclass that can provide basic support for teammates or utilize high damage skills.
Complexity: EASY

{1} less debuff buildup. ({2} base, {3} per level, up to {4})

Kills will heal yourself and nearby players for {5} of their max health. ]]

-- These are used to fill out the {1}, {2}, {3}, {4} above.
-- Mainly useful for translation, it is optional.
PERK.Params = {
    [1] = { percent = true, base = 0.25, level = 0.01, max = 0.5, classname = "Reverend" },
    [2] = { value = 0.25, percent = true },
    [3] = { value = 0.01, percent = true },
    [4] = { value = 0.5, percent = true },
    [5] = { value = 0.05, percent = true },
    [6] = { percent = true, base = 0, level = 0.04, max = 1, classname = "Reverend" },
    [7] = { value = 0.04, percent = true },
    [8] = { value = 1, percent = true },
}

PERK.Hooks = {}

-- This is a required function if you are planning to use bonuses based on levels.
PERK.Hooks.Horde_PrecomputePerkLevelBonus = function( ply )
    if SERVER then
        ply:Horde_SetPerkLevelBonus( "reverend_base", math.min( 0.25, 0.01 * ply:Horde_GetLevel( "Reverend" ) ) )
    end
end

-- Apply the passive ability.
PERK.Hooks.Horde_OnEnemyKilled = function( _, killer )
    if not killer:Horde_GetPerk( "reverend_base" ) then return end
    for _, ent in pairs( ents.FindInSphere( killer:GetPos(), 250 ) ) do
        if ent:IsValid() and ent:IsPlayer() and ent:Alive() then
            local healinfo = HealInfo:New( { amount = ent:GetMaxHealth() * 0.05, healer = killer } )
            HORDE:OnPlayerHeal( ent, healinfo )
        end
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function( ply, _, bonus )
    if not ply:Horde_GetPerk( "reverend_base" ) then return end
    bonus.less = bonus.less * ( 0.75 - ply:Horde_GetPerkLevelBonus( "reverend_base" ) )
end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if SERVER and perk == "reverend_base" then
        ply:Horde_AddReverendAura()
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if SERVER and perk == "reverend_base" then
        ply:Horde_RemoveReverendAura()
    end
end

local entmeta = FindMetaTable( "Entity" )
local plymeta = FindMetaTable( "Player" )

function entmeta:Horde_AddReverendAura()
    self:Horde_RemoveReverendAura()
    local ent = ents.Create( "horde_reverend_aura" )
    ent:SetPos( self:GetPos() )
    ent:SetParent( self )
    ent:Spawn()
    self.Horde_ReverendAura = ent
end

function entmeta:Horde_RemoveReverendAura()
    if not self:IsValid() then return end
    if self.Horde_ReverendAura and self.Horde_ReverendAura:IsValid() then
        self.Horde_ReverendAura:OnRemove()
        self.Horde_ReverendAura:Remove()
        self.Horde_ReverendAura = nil
    end
end

function plymeta:Horde_SetReverendAuraRadius( radius )
    self.Horde_ReverendAuraRadius = radius
end

function plymeta:Horde_GetReverendAuraRadius()
    return self.Horde_ReverendAuraRadius or 250
end

hook.Add( "DoPlayerDeath", "Horde_ReverendAuraDoPlayerDeath", function( victim )
    victim:Horde_RemoveReverendAura()
end )
