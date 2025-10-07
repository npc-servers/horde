AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

ENT.Model = "models/horde/gonarch/headcrab_baby.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }
ENT.TurningSpeed = 60 -- How fast it can turn
ENT.EntitiesToNoCollide = { "npc_vj_horde_xen_host_unit" } -- Entities to not collide with when HasEntitiesToNoCollide is set to true
ENT.StartHealth = 1
ENT.LeapDistance = 100 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.NoChaseAfterCertainRange_FarDistance = 150 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 150 -- How much upward force should it apply?
ENT.NextLeapAttackTime = 5 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 1 -- How much time until it can use any attack again? | Counted in Seconds
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = false
ENT.MeleeAttackDamage = 1
ENT.HasLeapAttack = true
ENT.LeapAttackDamage = 1

ENT.GeneralSoundPitch1 = 120
ENT.GeneralSoundPitch2 = 120

-- Custom
ENT.BabH_Mother = NULL
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self:SetCollisionBounds( Vector( 5, 5, 10 ), Vector( -5, -5, 0 ) )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
    -- Override the regular headcrab because we don't want it to play an alert animation
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled()
    if IsValid( self.BabH_Mother ) then
        self.BabH_Mother:Gonarch_BabyDeath()
    end
end

function ENT:BecomeFriendlyToPlayers()
    self.VJ_NPC_Class = { "CLASS_PLAYER_ALLY" }
    if HORDE.items["npc_manhack"] then
        self:AddRelationship( "npc_manhack D_LI 99" )
    end
end

VJ.AddNPC( "Headcrab Baby", "npc_vj_horde_headcrab_baby", "Horde" )

ENT.EntitiesToNoCollide = {
    "npc_vj_alpha_gonome", 
    "npc_vj_ezt_manhackbie", 
    "npc_vj_ezt_shotbie", 
    "npc_vj_ezt_weapbie", 
    "npc_vj_horde_blight", 
    "npc_vj_horde_breen", 
    "npc_vj_horde_charred_zombine", 
    "npc_vj_horde_crawler", 
    "npc_vj_horde_exploder", 
    "npc_vj_horde_fast_zombie",
    "npc_vj_horde_gamma_gonome",
    "npc_vj_horde_headcrab_baby",
    "npc_vj_horde_hellknight",
    "npc_vj_horde_hulk",
    "npc_vj_horde_lesion",
    "npc_vj_horde_plague_elite",
    "npc_vj_horde_plague_platoon",
    "npc_vj_horde_plague_soldier",
    "npc_vj_horde_platoon_berserker",
    "npc_vj_horde_platoon_demolitionist",
    "npc_vj_horde_platoon_heavy",
    "npc_vj_horde_poison_zombie",
    "npc_vj_horde_scorcher",
    "npc_vj_horde_screecher",
    "npc_vj_horde_sprinter",
    "npc_vj_horde_vomitter",
    "npc_vj_horde_walker",
    "npc_vj_horde_weeper",
    "npc_vj_horde_xen_destroyer_unit",
    "npc_vj_horde_xen_host_unit",
    "npc_vj_horde_xen_necromancer_unit",
    "npc_vj_horde_xen_psychic_unit",
    "npc_vj_horde_yeti",
    "npc_vj_horde_zombie_torso",
    "npc_vj_horde_zombine",
    "npc_vj_mutated_hulk"
}