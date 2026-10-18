AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
    self:SetModel( "models/props_junk/gascan001a.mdl" )
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_PLAYER_MOVEMENT)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(true)
    end

    timer.Simple( 2, function ()
        if self:IsValid() then
            self:SetTrigger( true )
            self:UseTriggerBounds( true, 150 )

            local expLight = ents.Create( "light_dynamic" )
            expLight:SetKeyValue( "brightness", "1" )
            expLight:SetKeyValue( "distance", "200" )
            expLight:SetLocalPos( self:GetPos() )
            expLight:SetLocalAngles( self:GetAngles() )
            expLight:Fire( "Color", "255 0 0" )
            expLight:SetParent( self )
            expLight:Spawn()
            expLight:Activate()
            expLight:Fire( "TurnOn", "", 0 )
            self:DeleteOnRemove( expLight )

            self:EmitSound( "weapons/slam/mine_mode.wav", 100 )
        end
    end )

    self.Removing = false
    self:PhysWake()
end
function ENT:OnTakeDamage( dmginfo )
    if dmginfo:GetAttacker() == self.Horde_Owner then
        self:Detonate()
    end
-- DO NOT TRY TO GIVE THIS UNHOLY DEVICE HEALTH, CAUSES CRASHES, WHY? NO CLUE!
end
local snd = Sound( "npc/roller/mine/rmine_predetonate.wav" )
function ENT:StartTouch( ent )
    if self.Removing then return end
    if ent:IsNPC() and ( not ent:GetNWEntity( "HordeOwner" ):IsValid() ) then
        self.Removing = true
        self:EmitSound( snd, 100 )

        timer.Simple( 1, function ()
            if not self:IsValid() then return end
            self:Detonate()
        end )
    end
end
function ENT:PhysicsCollide( data, phys )
    if ( data.Speed > 50 ) then self:EmitSound( Sound("Grenade.ImpactSoft") ) end
    if (data.HitEntity:GetClass() == "projectile_horde_flaregun_flare") and data.HitEntity:GetOwner() == self.Horde_Owner then
            if not self:IsValid() then return end
            self:Detonate()
    end

end
function ENT:Use(ply)
    if ( self:IsPlayerHolding() ) then return end
    if ply ~= self.Horde_Owner then return end
    ply:PickupObject( self )
end
function ENT:Detonate()
    if self.Detonated then return end
    self.Detonated = true
    self.Removing = true
    local pos = self:GetPos()
    local eff = EffectData()
    eff:SetStart( pos )
    eff:SetOrigin( pos )
    util.Effect( "Explosion", eff )
    util.BlastDamage( self, self.Horde_Owner, pos, 100, 200 )

    for _, e in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
        if e:IsNPC() and ( not e:GetNWEntity( "HordeOwner" ):IsValid() ) then
            local dmg = DamageInfo()
            dmg:SetDamage( 375 )
            dmg:SetDamageType( DMG_BURN )
            dmg:SetAttacker( self.Horde_Owner )
            dmg:SetInflictor( self )
            dmg:SetDamagePosition( e:GetPos() )
            e:TakeDamageInfo( dmg )
        end
    end

    local ply = self.Horde_Owner
        local cloud = ents.Create("arccw_horde_butane_fire")

    if not IsValid(cloud) then return end

    local vel = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * 1500

    cloud:SetPos(self:GetPos() - (self:GetVelocity() * FrameTime()))
    cloud:SetAbsVelocity(vel + self:GetVelocity())
    cloud:SetOwner(ply)
    cloud:Spawn()
    self:Remove()
end
function ENT:OnRemove()
    local ply = self.Horde_Owner
 timer.Simple( 7, function ()
        if not ply:IsValid() then return end
        if ply:Horde_GetGadget() ~= "gadget_butane_can" then return end
        if ply:Horde_GetGadgetCharges() >= 3 then
            ply:Horde_SetGadgetCharges( 3 )
        else
            ply:Horde_SetGadgetCharges( ply:Horde_GetGadgetCharges() + 1 )
        end
    end )
end