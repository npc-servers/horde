AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
    *** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/combine_soldier_prisonguard.mdl"
ENT.StartHealth = 200
ENT.AllowMovementJumping = false

ENT.VJ_NPC_Class = { "CLASS_COMBINE", "CLASS_PLAYER_ALLY" }

ENT.BloodColor = "Red"
ENT.MoveOrHideOnDamageByEnemy = false
ENT.DropWeaponOnDeath = false

ENT.CanCrouchOnWeaponAttack = false
ENT.WeaponReload_FindCover = false
ENT.MoveRandomlyWhenShooting = false
ENT.WaitForEnemyToComeOut = false

ENT.HasMeleeAttack = false

ENT.HasGrenadeAttack = false

ENT.FootStepTimeRun = 0.4
ENT.FootStepTimeWalk = 1

ENT.HasItemDropsOnDeath = false

ENT.Horde_Immune_Status_All = true
ENT.Immune_AcidPoisonRadiation = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
    "npc/combine_soldier/gear1.wav",
    "npc/combine_soldier/gear2.wav",
    "npc/combine_soldier/gear3.wav",
    "npc/combine_soldier/gear4.wav",
    "npc/combine_soldier/gear5.wav",
    "npc/combine_soldier/gear6.wav"
}

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )

    self:Give( "weapon_vj_horde_projection_shotgun" )

    if self.Is_Reinforcements then
        self:SetMaxHealth( self.StartHealth * 0.5 )
        self:SetHealth( self:GetMaxHealth() )
    end

    local ply = self:GetOwner()
    if ply:Horde_GetGadget() == "gadget_shotgun_surgeon" then
        self:SetSkin( 1 )
    end

    self:Horde_AddOverlordPresence()

    timer.Simple( 15, function()
        if not self:IsValid() then return end
        self:NextThink( CurTime() + 2 )
        self:DankRemove()
    end )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DankRemove()
    self:NextThink( CurTime() + 2 )
    timer.Simple( 1, function()
        if not self:IsValid() then return end
        self:Remove()
    end )
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "Projection", "npc_vj_horde_overlord_projection", "Zombies" )