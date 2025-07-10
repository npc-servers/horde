AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()

    self:SetColor(Color(0, 0, 255))
    self:SetModel("models/items/boxmrounds.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetModelScale(1.5)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)

    self.Removing = false
    self:PhysWake()
	
	timer.Simple(30, function ()
        if self:IsValid() then
            self:Remove()
        end
    end)
end

function ENT:StartTouch(entity)
    if not self.Removing and entity:IsPlayer() and entity:Alive() and not entity:IsBot() then
	
	local given_ammo = false
        local ply = entity
        for _, wpn in pairs(entity:GetWeapons()) do
            if wpn.Primary and wpn.Primary.MaxAmmo and wpn.Primary.MaxAmmo <= ply:GetAmmoCount(wpn:GetPrimaryAmmoType()) then
                goto cont
            end
            local given = HORDE:GiveAmmo(entity, wpn, 1)
            given_ammo = given_ammo or given
            ::cont::
        end
		
		if entity:GetActiveWeapon():GetMaxClip1() > 0 then
		entity:GetActiveWeapon():SetClip1(entity:GetActiveWeapon():GetMaxClip1())
		end
		
		if entity:GetActiveWeapon():GetMaxClip2() > 0 then
		entity:GetActiveWeapon():SetClip2(entity:GetActiveWeapon():GetMaxClip2())
		end

        if given_ammo then
            self.Removing = true
            self:Remove()
        end
	
end
end
