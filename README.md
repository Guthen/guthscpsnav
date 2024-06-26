# [SCP] S-NAV Ultimate
Watch the [Trailer Video](https://youtu.be/x5OVr65VqAw)!

**You need [[GuthSCP] Base](https://steamcommunity.com/workshop/filedetails/?id=3034737316) to get this working, else you won't been able to spawn the entity and configure the script.**

## Steam Workshop
![Steam Views](https://img.shields.io/steam/views/3034741785?color=red&style=for-the-badge)
![Steam Downloads](https://img.shields.io/steam/downloads/3034741785?color=red&style=for-the-badge)
![Steam Favorites](https://img.shields.io/steam/favorites/3034741785?color=red&style=for-the-badge)

This addon is available on the Workshop [here](https://steamcommunity.com/sharedfiles/filedetails/?id=3034741785)!

## Features
+ **Pickable** S-NAV Ultimate Entity
+ **Toggable** with a **key** (default `M`)
+ Shows a **minimap** and the **surrounding SCPs and NPCs**
+ Droppable with a chat command `/dropsnav`
+ Configurable in-game with [[GuthSCP] Base](https://steamcommunity.com/sharedfiles/filedetails/?id=3034737316) (`guthscp_menu` in your console)
    + **Input Key** to show and hide S-NAV
    + **Markers** of SCPs and NPCs
    + *and more..*
+ **Not gamemode dependent**

## Supported Maps
+ [gm_site19](https://steamcommunity.com/sharedfiles/filedetails/?id=290599102) ─ *23th June 2020*
+ [rp_site65](https://steamcommunity.com/sharedfiles/filedetails/?id=1788306202) ─ *23th June 2020*
+ [rp_site27_v1b](https://steamcommunity.com/sharedfiles/filedetails/?id=2413675625) ─ *1th April 2021*
+ [rp_site10](https://steamcommunity.com/sharedfiles/filedetails/?id=2163851948) ─ *7th May 2021*
+ [rp_zone_tsade_v1f_fr](https://steamcommunity.com/sharedfiles/filedetails/?id=2263738446) ─ *22th June 2021*
+ [rp_zone_tsade_v1f_us](https://steamcommunity.com/sharedfiles/filedetails/?id=2263738446) (with use of forcemap to `rp_zone_tsade_v1f_fr`)
+ [rp_site48_v2](https://steamcommunity.com/sharedfiles/filedetails/?id=2583189910) ─ *13th August 2022* (yeye my birthday)

## Convars
+ `guthscpsnav_forcemap <MAP_NAME>` (server): Force a specific minimap to be use instead of current map's image (see the list above). Default: ""

## Known Issues
### "The addon doesn't work!" or "I can't spawn the S-NAV!"
Be sure to have installed [[GuthSCP] Base](https://steamcommunity.com/sharedfiles/filedetails/?id=3034737316) on your server. Verify that you can open the configuration menu with `guthscp_menu` in your game console.

### "The model is shown as an error!" or "The S-NAV entity is bugged or can't be interacted!"
The default model comes from the [SCP Assets](https://steamcommunity.com/workshop/filedetails/?id=964160040) addon, ensure it is installed both in your client (=game) and the server.

If the problem remains and you are on a beta version (like `x86-64` or `chromium`), try reinstalling it by switching the beta version back and forth. 

### "Could not connect to map database!"
This message appears on the **S-NAV Ultimate** when the current map isn't supported, refer to **Supported Maps** above.

If the map you are using is equivalent with one of the **Supported Maps**, then use the server convar `guthscpsnav_forcemap` (see above) to use a specific minimap.

### "How can I create my own minimap?"
Read this [guide](https://github.com/Guthen/guthscpsnav/blob/master/CREATE_MINIMAP.md).

## Legal Terms
This addon is licensed under [Creative Commons Sharealike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) and is based on content of [SCP Foundation](http://scp-wiki.wikidot.com/) and [SCP:Containment Breach](https://www.scpcbgame.com/).

If you create something derived from this, please credit me (you can also tell me about what you've done).

***Enjoy !***
