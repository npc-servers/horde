ENT.Type = "anim"

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "CircleRadius" )
    self:NetworkVar( "Int", 1, "IsDisplayingCircleRadius" )
end