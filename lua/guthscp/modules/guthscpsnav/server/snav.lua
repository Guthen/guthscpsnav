--  resources
resource.AddSingleFile( "resource/fonts/ds-digital.ttf" )

local path = "materials/guth_scp/snav/"
for i, v in ipairs( file.Find( path .. "*.png", "GAME" ) ) do
    resource.AddSingleFile( path .. v )
end

--  hooks
hook.Add( "PlayerSpawn", "guthscpsnav:reset_data", function( ply )
    ply:SetNWBool( "guthscpsnav:has_snav", false )
end )

hook.Add( "PlayerSay", "guthscpsnav:drop_snav", function( ply, txt ) 
    if not ply:GetNWBool( "guthscpsnav:has_snav", false ) then return end
    if not txt:StartWith( "/dropsnav" ) then return end

    --  get spawn pos
    local tr = ply:GetEyeTrace()
    local hit_pos, max_pos = tr.HitPos, tr.StartPos + tr.Normal * 64
    local pos = hit_pos:DistToSqr( ply:GetPos() ) > max_pos:DistToSqr( ply:GetPos() ) and max_pos or hit_pos

    --  create entity
    local ent = ents.Create( "guthscp_snav" )
    ent:SetPos( pos )
    ent:SetAngles( ply:GetAngles() )
    ent:Spawn()

    --  remove from data
    ply:SetNWBool( "guthscpsnav:has_snav", false )
    return ""
end )

--  network
util.AddNetworkString( "guthscpsnav:forcemap" )

forcemap = CreateConVar( "guthscpsnav_forcemap", "", FCVAR_ARCHIVE, "Force a minimap image to be use instead of current map's image. Default: \"\"" )
local function network_forcemap( ply, minimap )
    net.Start( "guthscpsnav:forcemap" )
        net.WriteString( minimap or forcemap:GetString() )
    net.Send( ply )
end

net.Receive( "guthscpsnav:forcemap", function( len, ply )
    network_forcemap( ply )
end )

cvars.AddChangeCallback( "guthscpsnav_forcemap", function( convar, old, new ) 
    if new == "\"\"" then return forcemap:SetString( "" ) end
    network_forcemap( player.GetHumans(), new )
end, "guthscpsnav" )