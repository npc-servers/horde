include("shared.lua")
--stuff below this line is dedicated to being a visual aid when debugging/tweaking certain behavior distances and attack radius's
--you'll have to manually punch the corresponding numbers in so its 1 to 1, or make your tweaks here and transfer them over
if CLIENT then
    function ENT:Draw()
        self:DrawModel()
        local ply = LocalPlayer()
        if tobool(ply:GetInfoNum("developer", 0)) and ply:IsSuperAdmin() then

            local pos = self:GetPos() + self:OBBCenter()

            render.SetColorMaterial()
            local wideSteps = 16
            local tallSteps = 16

            --HasRangeAttack distance check
            --if target is within this sphere, range attacking is disabled. if target is outside this sphere, npc is allowed to range attack
            local hasrangeattackradius = 400
            render.DrawSphere( pos, hasrangeattackradius, wideSteps, tallSteps, Color( 200, 0, 0, 50) )
            render.DrawWireframeSphere( pos, hasrangeattackradius, wideSteps, tallSteps, Color( 255, 0, 0, 50), true )

            --visual aid for the radius defined in ENT.MeleeAttackDistance
            --for some unholy reason the hunter is allowed to melee targets within this radius regardless of facing angle so keep this in mind when making tweaks
            local meleeattackradius = 70
            render.DrawSphere( pos, meleeattackradius, wideSteps, tallSteps, Color( 0, 13, 200, 50) )
            render.DrawWireframeSphere( pos, meleeattackradius, wideSteps, tallSteps, Color( 17, 0, 255, 50), true )

            --charge attack attack radius
            --this is a visual representation of the sphere the charge attack uses to deal damage/attack targets
            local chargeattackpos = self:GetPos() + self:OBBCenter() + self:GetForward() * 40
            local chargeattackradius = 60
            render.DrawSphere( chargeattackpos, chargeattackradius, wideSteps, tallSteps, Color( 0, 217, 255, 50) )
            render.DrawWireframeSphere( chargeattackpos, chargeattackradius, wideSteps, tallSteps, Color( 0, 217, 255, 50), true )
        else return end
    end
end