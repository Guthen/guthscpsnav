hook.Add( "guthscpbase:config", "guthscpsnav", function()

    GuthSCP.addConfig( "guthscpsnav", {
        label = "S-NAV Ultimate",
        icon = "icon16/map.png",
        elements = {
            {
                type = "Form",
                name = "Configuration",
                elements = {
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
                    {
                        type = "Button",
                        name = "Apply",
                        action = function( form, serialize_form )
                            GuthSCP.sendConfig( "guthscpsnav", serialize_form )
                        end,
                    }
                },
            },
        },
        receive = function( form )
            GuthSCP.applyConfig( "guthscpsnav", form, {
                network = true,
                save = true,
            } )
        end,
    } )

end )