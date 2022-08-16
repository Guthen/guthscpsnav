local MODULE = {
	name = "S-NAV Ultimate",
	author = "Guthen",
	version = "2.0.0",
	description = "A portable mini-map capable of showing nearby SCPs & NPCs hostiles!",
	icon = "icon16/map.png",
	version_url = "https://raw.githubusercontent.com/Guthen/guthscpsnav/update-to-guthscpbase-remaster/lua/guthscp/modules/guthscpsnav/main.lua",
	dependencies = {
		base = "2.0.0",
	},
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
			type = "NumWang",
			name = "Blink Time",
			id = "blink_time",
			default = .33,
			desc = "Time between each S-NAV screen refresh and especially to refresh the hostiles and their positions",
			decimals = 2,
			min = 0,
		},
		{
			type = "NumWang",
			name = "Show Distance",
			id = "hostiles_dist",
			default = 724,
			desc = "Maximum distance where hostiles (SCPs & NPCs) will be shown on the S-NAV"
		},
		{
			type = "CheckBox",
			name = "Show Positions",
			id = "show_hostiles_pos",
			desc = "If checked, hostiles positions (SCPs & NPCs) will be revealed on the S-NAV"
		},
		{
			type = "CheckBox",
			name = "Constant Refresh",
			id = "hostile_constant_refresh",
			desc = "If checked, hostiles positions and distance will be constantly refreshed, otherwise it will refresh at a constant rate (every time the texts \"blinks\")"
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
			type = "Category",
			name = "NPCs",
		},
		{
			type = "CheckBox",
			name = "Enabled",
			id = "npcs_enabled",
			default = false,
			desc = "If checked, NPCs will be shown on the S-NAV",
		},
		{
			type = "CheckBox",
			name = "Hostiles Only",
			id = "npcs_hostile_only",
			default = true,
			desc = "If checked, only hostile NPCs will be shown. Since it use `IsEnemyEntityName` internally, this may omit custom NPCs",
		},
		guthscp.config.create_apply_button(),
	},
	receive = function( form )
		guthscp.config.apply( MODULE.id, form, {
			network = true,
			save = true,
		} )
	end,
}

guthscp.module.hot_reload( "guthscpsnav" )
return MODULE