if not guthscp then
	error( "guthscpsnav - fatal error! https://github.com/Guthen/guthscpbase must be installed on the server!" )
	return
end

AddCSLuaFile()

ENT.Base = "guthscp_base"

ENT.PrintName = "S-Nav Ultimate"
ENT.Category = "GuthSCP"
ENT.Spawnable = true

ENT.Model = "models/props/scp/snav/snav.mdl"

function ENT:Use( ply )
	if ply:GetNWBool( "guthscpsnav:has_snav", false ) then return end

	ply:SetNWBool( "guthscpsnav:has_snav", true )
	self:Pick()
end

if CLIENT and guthscp then
	guthscp.spawnmenu.add_entity( ENT, "General" )
end