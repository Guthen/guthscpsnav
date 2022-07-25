--  loading fonts
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

local font_height = draw.GetFontHeight( font )

--  setup
local snav_show = true
local snav_map_texture = Material( "guth_scp/snav/" .. game.GetMap() .. ".png" )
local snav_map_w, snav_map_h = snav_map_texture:Width(), snav_map_texture:Height()
local snav_texture = Material( "guth_scp/snav/navigator.png" )
local snav_w, snav_h = snav_texture:Width(), snav_texture:Height()
local snav_x, snav_y = ScrW() - snav_w * .95, ScrH() - snav_h * .95
local snav_screen_coords = {
    start = {
        x = 83,
        y = 76,
    },
    endpos = {
        x = 348,
        y = 296,
    }
}

--  screen bounds
local screen_x, screen_y = snav_x + snav_screen_coords.start.x, snav_y + snav_screen_coords.start.y
local screen_w, screen_h = snav_screen_coords.endpos.x - snav_screen_coords.start.x, snav_screen_coords.endpos.y - snav_screen_coords.start.y

--  render info
local scps_infos = {}
local color_black, color_scp_ring = Color( 0, 0, 0 ), Color( 115, 31, 28 )
local ply_next_blink, ply_is_blinking = CurTime() + .5, false
local scp_next_blink, scp_is_blinking = ply_next_blink, ply_is_blinking
local ply_pos
local relative_x, relative_y = 0, 0
local center_x, center_y = screen_x + screen_w / 2, screen_y + screen_h / 2

--  map bounds
local map_start, map_end
local map_width, map_height
local function get_map_bounds()
    if game.GetWorld() == NULL then return end
    map_start, map_end = game.GetWorld():GetModelBounds()
    map_width, map_height = map_end.x - map_start.x, map_end.y - map_start.y
end
get_map_bounds()
hook.Add( "InitPostEntity", "guthscpsnav:get_map_bounds", get_map_bounds )

--  convert world to screen
local function world_to_relative_pos( pos )
    return math.Remap( pos.y, map_end.y, map_start.y, 0, snav_map_h ), 
    math.Remap( pos.x, map_end.x, map_start.x, 0, snav_map_w )
end

local function world_to_screen_angle( angle )
    return 180 - angle + 90
end

local function world_to_screen_pos( pos, relative_x, relative_y )
    local x, y = world_to_relative_pos( pos )
    return screen_x + x - relative_x + screen_w / 2,
           screen_y + y - relative_y + screen_h / 2
end

--  draw funcs
local function draw_triangle( x, y, ang, scale )
    local ang, ang_dif = math.rad( ang ), math.rad( 150 )
    local triangle = {
        --  spike point
        { x = x + math.cos( ang ) * scale , y = y + math.sin( ang ) * scale },
        --  segment points
        { x = x + math.cos( ang + ang_dif ) * scale , y = y + math.sin( ang + ang_dif ) * scale },
        { x = x + math.cos( ang - ang_dif ) * scale , y = y + math.sin( ang - ang_dif ) * scale }
    }

    --  draw lines
    local last_x, last_y = triangle[1].x, triangle[1].y
    for i = 2, #triangle do
        local v = triangle[i]
        surface.DrawLine( last_x, last_y, v.x, v.y )
        
        last_x = v.x
        last_y = v.y
    end
    surface.DrawLine( last_x, last_y, triangle[1].x, triangle[1].y )
end

local function draw_hostile( ent, text, text_n, relative_x, relative_y )
    local pos = ent:GetPos()

    --  draw text
    draw.SimpleText( text, font, screen_x + 4, screen_y + 3 + text_n * ( font_height + 2 ), color_scp_ring )
    
    --  store data if not exist (due to refresh rate)
    local x, y = world_to_screen_pos( pos, relative_x, relative_y )
    local dist = math.Distance( x, y, center_x, center_y )
    scps_infos[ent] = scps_infos[ent] or {
        x = x,
        y = y,
        dist = dist,
    }
    
    --  draw dist ring
    surface.SetDrawColor( color_scp_ring )
    surface.DrawCircle( center_x, center_y, scps_infos[ent].dist, color_scp_ring )

    --  draw pos
    if guthscp.configs.guthscpsnav.show_hostiles_pos then
        draw_triangle( x, y, world_to_screen_angle( ent:EyeAngles().y ), 6 )
    end
end

--  draw snav
hook.Add( "HUDPaint", "guthscpsnav:draw_snav", function()
    if not snav_show then return end
    if not map_end then get_map_bounds() end

    local ply = LocalPlayer()
    if not ply:GetNWBool( "guthscpsnav:has_snav", false ) then return end

    ply_pos = ply:GetPos()
    relative_x, relative_y = world_to_relative_pos( ply_pos )

    --  draw snav texture
    surface.SetMaterial( snav_texture )
    surface.SetDrawColor( color_white )
    surface.DrawTexturedRect( snav_x, snav_y, snav_w, snav_h )

    --  draw screen outline
    surface.SetDrawColor( color_black )
    surface.DrawOutlinedRect( screen_x, screen_y, screen_w, screen_h )
    
    --  draw snav screen
    render.SetScissorRect( screen_x, screen_y, screen_x + screen_w, screen_y + screen_h, true )
        --  draw map
        if not snav_map_texture:IsError() then
            surface.SetMaterial( snav_map_texture )
            surface.SetDrawColor( color_white )
            surface.DrawTexturedRect( screen_x - relative_x + screen_w / 2, screen_y - relative_y + screen_h / 2, snav_map_w, snav_map_h )
        --  draw error
        elseif not scp_is_blinking then
            local offset = 5
            draw.SimpleText( "COULD NOT CONNECT", font .. ":info", screen_x + screen_w / 2, screen_y + screen_h - draw.GetFontHeight( font ) - offset, color_scp_ring, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
            draw.SimpleText( "TO MAP DATABASE", font .. ":info", screen_x + screen_w / 2, screen_y + screen_h - offset, color_scp_ring, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
        end

        --  draw player pos
        if not ply_is_blinking then
            surface.SetDrawColor( color_black )
            draw_triangle( center_x, center_y, world_to_screen_angle( ply:EyeAngles().y ), 6 )
        end

        --  blink animation
        if ply_next_blink < CurTime() then 
            ply_next_blink = ply_is_blinking and CurTime() + 1 or CurTime() + .35
            ply_is_blinking = not ply_is_blinking
        end

        if not scp_is_blinking then
            local text_n = 0
            
            --  draw scps
            if guthscp.configs.guthscpsnav.scps_enabled then
                for i, v in ipairs( guthscp.get_scps() ) do
                    if v == ply then continue end
                    if not v:Alive() then continue end
                    if v:GetPos():DistToSqr( ply_pos ) > guthscp.configs.guthscpsnav.hostiles_dist ^ 2 then continue end

                    draw_hostile( v, team.GetName( v:Team() ), text_n, relative_x, relative_y )
                    text_n = text_n + 1
                end
            end

            --  draw npcs
			if guthscp.configs.guthscpsnav.npcs_enabled then
				for i, v in ipairs( guthscp.get_npcs() ) do
					local class = v:GetClass()
					if v:Health() <= 0 then continue end
					if guthscp.configs.guthscpsnav.npcs_hostile_only and not IsEnemyEntityName( class ) then continue end
					if v:GetPos():DistToSqr( ply_pos ) > guthscp.configs.guthscpsnav.hostiles_dist ^ 2 then continue end
					
					--  get npc name
					local name = v:GetClass()
					local data = list.Get( "NPC" )[name]
					if data then
						name = data.Name
					end

					draw_hostile( v, name, text_n, relative_x, relative_y )
					text_n = text_n + 1
				end
			end

            --  continuous refreshing 
            if guthscp.configs.guthscpsnav.hostile_constant_refresh then 
                scps_infos = {}
            end
        end

        --  scp blinking animation
        if scp_next_blink < CurTime() then
            scp_next_blink = CurTime() + .35
            scp_is_blinking = not scp_is_blinking
            scps_infos = {}
        end
    render.SetScissorRect( 0, 0, 0, 0, false )
end )

hook.Add( "PlayerButtonDown", "guthscpsnav:toggle_snav", function( ply, button )
    if not IsFirstTimePredicted() then return end
    if not ply:GetNWBool( "guthscpsnav:has_snav", false ) then return end

    if button == _G["KEY_" .. guthscp.configs.guthscpsnav.key] then
        snav_show = not snav_show
        surface.PlaySound( "guthen_scp/interact/PickItem2.ogg" )
    end
end )

--  forcemap
hook.Add( "InitPostEntity", "guthscpsnav:retrieve_forcemap", function()
    net.Start( "guthscpsnav:forcemap" )
    net.SendToServer()
end )

net.Receive( "guthscpsnav:forcemap", function()
    local map = net.ReadString()
    if map == "" then map = game.GetMap() end
    snav_map_texture = Material( "guth_scp/snav/" .. map .. ".png" )
    snav_map_w, snav_map_h = snav_map_texture:Width(), snav_map_texture:Height()
end )


--  snav generation
concommand.Add( "guthscpsnav_generate", function()
    hook.Add( "HUDPaint", "guthscpsnav:generate", function()
        --  generate
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

        --  write
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