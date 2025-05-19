include("shared.lua")
--debug stuff
if CLIENT then
    function ENT:Draw()
        if SERVER then return end
        self:DrawModel()
        local ply = LocalPlayer()
        if tobool(ply:GetInfoNum("developer", 0)) and ply:IsSuperAdmin() then

            local pos = self:GetPos() + self:OBBCenter()

            render.SetColorMaterial()
            local wideSteps = 16
            local tallSteps = 16

            --HasRangeAttack distance check, if within sphere, cannot range attack, if outside sphere, can range attack
            local hasrangeattackradius = 400
            render.DrawSphere( pos, hasrangeattackradius, wideSteps, tallSteps, Color( 200, 0, 0, 50) )
            render.DrawWireframeSphere( pos, hasrangeattackradius, wideSteps, tallSteps, Color( 255, 0, 0, 50), true )

            --melee attack radius
            local meleeattackradius = 75
            render.DrawSphere( pos, meleeattackradius, wideSteps, tallSteps, Color( 0, 13, 200, 50) )
            render.DrawWireframeSphere( pos, meleeattackradius, wideSteps, tallSteps, Color( 17, 0, 255, 50), true )

            --charge attack distance
            local chargeattackpos = self:GetPos() + self:OBBCenter() + self:GetForward() * 40
            local chargeattackradius = 60
            render.DrawSphere( chargeattackpos, chargeattackradius, wideSteps, tallSteps, Color( 0, 217, 255, 50) )
            render.DrawWireframeSphere( chargeattackpos, chargeattackradius, wideSteps, tallSteps, Color( 0, 217, 255, 50), true )
        else return end
    end
end