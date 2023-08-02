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
		["server.lua"] = guthscp.REALMS.SERVER,
		["client.lua"] = guthscp.REALMS.CLIENT,
	},
}

MODULE.menu = {
	--  config
	config = {
		form = {
			--  general
			"General",
			{
				type = "InputKey",
				name = "Key",
				id = "key",
				default = KEY_M,
				desc = "Key to press to hide and show the S-NAV when it's equipped",
			},
			{
				type = "Number",
				name = "Blink Time",
				id = "blink_time",
				default = .33,
				desc = "Time between each S-NAV screen refresh and especially to refresh the hostiles and their positions",
				decimals = 2,
				min = 0,
			},
			{
				type = "Number",
				name = "Show Distance",
				id = "hostiles_dist",
				default = 724,
				desc = "Maximum distance where hostiles (SCPs & NPCs) will be shown on the S-NAV"
			},
			{
				type = "Bool",
				name = "Show Positions",
				id = "show_hostiles_pos",
				default = false,
				desc = "If checked, hostiles positions (SCPs & NPCs) will be revealed on the S-NAV"
			},
			{
				type = "Bool",
				name = "Constant Refresh",
				id = "hostile_constant_refresh",
				default = false,
				desc = "If checked, hostiles positions and distance will be constantly refreshed, otherwise it will refresh at a constant rate (every time the texts \"blinks\")"
			},
			--  scps
			"SCPs",
			{
				type = "Bool",
				name = "Enabled",
				id = "scps_enabled",
				default = true,
				desc = "If checked, SCPs will be shown on the S-NAV Ultimate",
			},
			--  npcs
			"NPCs",
			{
				type = "Bool",
				name = "Enabled",
				id = "npcs_enabled",
				default = false,
				desc = "If checked, NPCs will be shown on the S-NAV",
			},
			{
				type = "Bool",
				name = "Hostiles Only",
				id = "npcs_hostile_only",
				default = true,
				desc = "If checked, only hostile NPCs will be shown. Since it use `IsEnemyEntityName` internally, this may omit custom NPCs",
			},
			guthscp.config.create_apply_button(),
			guthscp.config.create_reset_button(),
		},
	},
	--  details
	details = {
		{
			text = "CC-BY-SA",
			icon = "icon16/page_white_key.png",
		},
		"Wiki",
		{
			text = "Read Me",
			icon = "icon16/information.png",
			url = "https://github.com/Guthen/guthscpsnav/blob/master/README.md"
		},
		{
			text = "How to create minimaps?",
			icon = "icon16/map_add.png",
			url = "https://github.com/Guthen/guthscpsnav/blob/update-to-guthscpbase-remaster/CREATE_MINIMAP.md",
		},
		"Social",
		{
			text = "Github",
			icon = "guthscp/icons/github.png",
			url = "https://github.com/Guthen/guthscpsnav",
		},
		{
			text = "Steam",
			icon = "guthscp/icons/steam.png",
			url = "https://steamcommunity.com/sharedfiles/filedetails/?id=2139521265"
		},
		{
			text = "Discord",
			icon = "guthscp/icons/discord.png",
			url = "https://discord.gg/Yh5TWvPwhx",
		},
		{
			text = "Ko-fi",
			icon = "guthscp/icons/kofi.png",
			url = "https://ko-fi.com/vyrkx",
		},
	},
}

function MODULE:init()
	--  porting old config file
	self:port_old_config_file( "guthscpbase/guthscpsnav.json" )
end

guthscp.module.hot_reload( "guthscpsnav" )
return MODULE