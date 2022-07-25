local MODULE = {
    id = "guthscpsnav",
    name = "S-NAV Ultimate",
    version = "2.0.0",
    icon = "icon16/map.png",
    version_url = "https://raw.githubusercontent.com/Guthen/guthscpsnav/master/lua/guthscp/modules/guthsnav/main.lua",
	requires = {
		["server/"] = guthscp.REALMS.SERVER,
		["client/"] = guthscp.REALMS.CLIENT,
	},
}

MODULE.config = {
    form = {
        {
            type = "Category",
            name = "General",
        },
        {
            type = "TextEntry",
            name = "Key",
            id = "key",
            default = "M",
            desc = "Key to press to hide and show the S-NAV when it's equipped",
        },
        {
            type = "Category",
            name = "SCPs",
        },
        {
            type = "CheckBox",
            name = "Enabled",
            id = "scps_enabled",
            default = true,
            desc = "If checked, SCPs will be shown on the S-NAV Ultimate",
        },
        {
            type = "NumWang",
            name = "Show Distance",
            id = "show_scps_dist",
            default = 724,
            desc = "Maximum distance where SCPs will be shown on the S-NAV"
        },
        {
            type = "CheckBox",
            name = "Show Positions",
            id = "show_scps_pos",
            desc = "If checked, SCPs positions will be revealed on the S-NAV"
        },
        {
            type = "CheckBox",
            name = "Constant Refresh",
            id = "scp_constant_refresh",
            desc = "If checked, SCPs positions and distance will be constantly refreshed, else it will refresh at a constant rate (every time the texts \"blinks\")"
        },
        guthscp.config.create_apply_button( MODULE.id )
    },
    receive = function( form )
        guthscp.config.apply( MODULE.id, form, {
            network = true,
            save = true,
        } )
    end,
}

guthscp.module.hot_reload( MODULE )
return MODULE