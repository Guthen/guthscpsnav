if not guthscp then
	error( "guthscpsnav - fatal error! https://github.com/Guthen/guthscpbase must be installed on the server!" )
	return
end

AddCSLuaFile()

ENT.Base = "guthscpbase"

ENT.PrintName = "S-Nav Ultimate"
ENT.Category = "Guthen's SENTs"
ENT.Spawnable = true

ENT.Model = "models/props/scp/snav/snav.mdl"

function ENT:Use( ply )
    if ply:GetNWBool( "guthscp:snav", false ) then return end

    ply:SetNWBool( "guthscp:snav", true )
    self:Pick()
end