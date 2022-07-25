--  > Font
local font = "guthscpsnav:scp"
surface.CreateFont( font, {
    font = "DS-Digital",
    size = math.Round( ScreenScale( 7.5 ) ),
    weight = 600,
} )
surface.CreateFont( font .. ":info", {
    font = "DS-Digital",
    size = math.Round( ScreenScale( 7.5 ) ),
} )

--  > S-NAV
local snav_show = true
local snav_map_texture = Material( "guth_scp/snav/" .. game.GetMap() .. ".png" )
local snav_map_w, snav_map_h = snav_map_texture:Width(), snav_map_texture:Height()
local snav_texture = Material( "guth_scp/snav/navigator.png" )
local snav_w, snav_h = snav_texture:Width(), snav_texture:Height()
local snav_x, snav_y = ScrW() - snav_w * .95, ScrH() - snav_h * .95
local snav_screen_coords = {
    start = {
        --x = 73,
        --y = 42,
        x = 83,
        y = 76,
    },
    endpos = {
        --x = 361,
        --y = 306 - 13,
        x = 348,
        y = 296,
    }
}

--  > Screen bounds
local screen_x, screen_y = snav_x + snav_screen_coords.start.x, snav_y + snav_screen_coords.start.y
local screen_w, screen_h = snav_screen_coords.endpos.x - snav_screen_coords.start.x, snav_screen_coords.endpos.y - snav_screen_coords.start.y

--  > Map bounds
local map_start, map_end
local map_width, map_height
local function get_map_bounds()
    if game.GetWorld() == NULL then return end
    map_start, map_end = game.GetWorld():GetModelBounds()
    map_width, map_height = map_end.x - map_start.x, map_end.y - map_start.y
end
get_map_bounds()
hook.Add( "InitPostEntity", "guthscpsnav", get_map_bounds )

--  > Draw an outline triangle
local function draw_triangle( x, y, ang, scale )
    local ang, ang_dif = math.rad( ang ), math.rad( 150 )
    local triangle = {
        --  > Spike point
        { x = x + math.cos( ang ) * scale , y = y + math.sin( ang ) * scale },
        --  > Segment points
        { x = x + math.cos( ang + ang_dif ) * scale , y = y + math.sin( ang + ang_dif ) * scale },
        { x = x + math.cos( ang - ang_dif ) * scale , y = y + math.sin( ang - ang_dif ) * scale }
    }

    --  > Draw lines
    local last_x, last_y = triangle[1].x, triangle[1].y
    for i = 2, #triangle do
        local v = triangle[i]
        surface.DrawLine( last_x, last_y, v.x, v.y )
        
        last_x = v.x
        last_y = v.y
    end
    surface.DrawLine( last_x, last_y, triangle[1].x, triangle[1].y )
end

local scps_infos = {}
local color_black, color_scp_ring = Color( 0, 0, 0 ), Color( 115, 31, 28 )
local ply_next_blink, ply_is_blinking = CurTime() + .5, false
local scp_next_blink, scp_is_blinking = ply_next_blink, ply_is_blinking
hook.Add( "HUDPaint", "guthscpsnav", function()
    if not snav_show then return end
    if not map_end then get_map_bounds() end

    local ply = LocalPlayer()
    if not ply:GetNWBool( "guthscp:snav", false ) then return end

    --  > S-NAV Texture
    surface.SetMaterial( snav_texture )
    surface.SetDrawColor( color_white )
    surface.DrawTexturedRect( snav_x, snav_y, snav_w, snav_h )

    --  > S-NAV Screen
    local ply_pos = ply:GetPos()
    local relative_x, relative_y = math.Remap( ply_pos.y, map_end.y, map_start.y, 0, snav_map_h ), math.Remap( ply_pos.x, map_end.x, map_start.x, 0, snav_map_w )
    local center_x, center_y = screen_x + screen_w / 2, screen_y + screen_h / 2

    surface.SetDrawColor( color_black )
    surface.DrawOutlinedRect( screen_x, screen_y, screen_w, screen_h )
    render.SetScissorRect( screen_x, screen_y, screen_x + screen_w, screen_y + screen_h, true )
        --  > Map
        if not snav_map_texture:IsError() then
            surface.SetMaterial( snav_map_texture )
            surface.SetDrawColor( color_white )
            surface.DrawTexturedRect( screen_x - relative_x + screen_w / 2, screen_y - relative_y + screen_h / 2, snav_map_w, snav_map_h )
        elseif not scp_is_blinking then
            local offset = 5
            draw.SimpleText( "COULD NOT CONNECT", font .. ":info", screen_x + screen_w / 2, screen_y + screen_h - draw.GetFontHeight( font ) - offset, color_scp_ring, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
            draw.SimpleText( "TO MAP DATABASE", font .. ":info", screen_x + screen_w / 2, screen_y + screen_h - offset, color_scp_ring, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )    
        end

        --  > Player
        if not ply_is_blinking then
            surface.SetDrawColor( color_black )
            draw_triangle( center_x, center_y, 180 - ply:GetAngles().y + 90, 6 )
        end

        if ply_next_blink < CurTime() then 
            ply_next_blink = ply_is_blinking and CurTime() + 1 or CurTime() + .35
            ply_is_blinking = not ply_is_blinking
        end

        --  > SCPs
        if guthscp and guthscp.get_scps then
            if not scp_is_blinking then
                local drawn = 0

                for i, v in ipairs( guthscp.get_scps() ) do
                    if v == ply then continue end
                    if v:GetPos():DistToSqr( ply_pos ) > ( guthscp and guthscp.configs.guthscpsnav.show_scps_dist or 724 ) ^ 2 then continue end

                    draw.SimpleText( team.GetName( v:Team() ), font, screen_x + 4, screen_y + 3 + drawn * ( draw.GetFontHeight( font ) + 2 ), color_scp_ring )
                    surface.SetDrawColor( color_scp_ring )

                    local x = screen_x + math.Remap( v:GetPos().y, map_end.y, map_start.y, 0, snav_map_h ) - relative_x + screen_w / 2
                    local y = screen_y + math.Remap( v:GetPos().x, map_end.x, map_start.x, 0, snav_map_w ) - relative_y + screen_h / 2
                    local dist = math.Distance( x, y, center_x, center_y )
                    scps_infos[v] = scps_infos[v] or {
                        x = x,
                        y = y,
                        dist = dist,
                    }

                    surface.DrawCircle( center_x, center_y, scps_infos[v].dist, color_scp_ring )

                    if guthscp and guthscp.configs.guthscpsnav.show_scps_pos then
                        draw_triangle( x, y, 180 - v:EyeAngles().y + 90, 6 )
                    end


                    drawn = drawn + 1
                end

                if guthscp.configs.guthscpsnav.scp_constant_refresh then 
                    scps_infos = {}
                end
            end
        end

        if scp_next_blink < CurTime() then
            scp_next_blink = CurTime() + .35
            scp_is_blinking = not scp_is_blinking
            scps_infos = {}
        end
    render.SetScissorRect( 0, 0, 0, 0, false )
end )

hook.Add( "PlayerButtonDown", "guthscpsnav", function( ply, button )
    if not ply:GetNWBool( "guthscp:snav", false ) then return end

    if IsFirstTimePredicted() and button == ( guthscp and _G["KEY_" .. ( guthscp.configs.guthscpsnav.key or "M" )] or KEY_M ) then
        snav_show = not snav_show
        --if snav_show then
            surface.PlaySound( "guthen_scp/interact/PickItem2.ogg" )
        --end
    end
end )

--  forcemap
hook.Add( "InitPostEntity", "guthscpsnav", function()
    net.Start( "guthscpsnav:forcemap" )
    net.SendToServer()
end )

net.Receive( "guthscpsnav:forcemap", function()
    local map = net.ReadString()
    if map == "" then map = game.GetMap() end
    snav_map_texture = Material( "guth_scp/snav/" .. map .. ".png" )
    snav_map_w, snav_map_h = snav_map_texture:Width(), snav_map_texture:Height()
end )


--  > nav generation
concommand.Add( "guthscpsnav_generate", function()
    hook.Add( "HUDPaint", "guthscpsnav:generate", function()
        --  > generate
        local generate_screen_size = ScrH()
        local middle_pos = LerpVector( .5, map_start, map_end )
        render.RenderView( {
            origin = middle_pos + Vector( 0, 0, 2500 ),
            angles = Angle( 90, 90, 90 ),
            ortho = {
                left = -map_height / 2,
                right = map_height / 2,
                top = -map_width / 2,
                bottom = map_width / 2,
            },
            znear = 4000,
            zfar = 8000,
            x = 0,
            y = 0,
            w = generate_screen_size,
            h = generate_screen_size,
        } )

        --[[ local pos = LocalPlayer():GetPos()
        surface.SetDrawColor( color_scp_ring )
        draw_triangle( math.Remap( pos.y, map_end.y, map_start.y, 0, generate_screen_size ), math.Remap( pos.x, map_end.x, map_start.x, 0, generate_screen_size ), 180 - LocalPlayer():GetAngles().y + 90, 15 ) ]]

        --  > write
        if input.IsMouseDown( MOUSE_MIDDLE ) then
            file.CreateDir( "guth_scp/snav" )
            file.Write( "guth_scp/snav/" .. game.GetMap() .. ".png", render.Capture( {
                format = "png",
                x = 0,
                y = 0,
                w = generate_screen_size,
                h = generate_screen_size,
            } ) )

            hook.Remove( "HUDPaint", "guthscpsnav:generate" )
        end
    end )
end )