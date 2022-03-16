# [SCP] S-NAV Ultimate
Watch the [Trailer Video](https://youtu.be/x5OVr65VqAw)!

**You need [[SCP] Guthen's Addons Base](https://steamcommunity.com/sharedfiles/filedetails/?id=2139692777) to get this working, else you won't been able to spawn the entity and configure the script.**

## Steam Workshop
![Steam Views](https://img.shields.io/steam/views/2139521265?color=red&style=for-the-badge)
![Steam Downloads](https://img.shields.io/steam/downloads/2139521265?color=red&style=for-the-badge)
![Steam Favorites](https://img.shields.io/steam/favorites/2139521265?color=red&style=for-the-badge)

This addon is available on the Workshop [here](https://steamcommunity.com/sharedfiles/filedetails/?id=2139521265)!

## Features
+ Pickable **S-NAV Ultimate** Entity
    + Toggable with a key (default `M`)
    + Shows a **Minimap**
    + Shows **Surrounding SCPs players** with configurable distance
    + Droppable with a chat command `/dropsnav`
+ Configurable (`guthscpbase` in the console)

## Supported Maps
+ [gm_site19](https://steamcommunity.com/sharedfiles/filedetails/?id=290599102) ─ *23th June 2020*
+ [rp_site65](https://steamcommunity.com/sharedfiles/filedetails/?id=1788306202) ─ *23th June 2020*
+ [rp_site27_v1b](https://steamcommunity.com/sharedfiles/filedetails/?id=2413675625) ─ *1th April 2021*
+ [rp_site10](https://steamcommunity.com/sharedfiles/filedetails/?id=2163851948) ─ *7th May 2021*
+ [rp_zone_tsade_v1f_fr](https://steamcommunity.com/sharedfiles/filedetails/?id=2263738446) ─ *22th June 2021*
+ [rp_zone_tsade_v1f_us](https://steamcommunity.com/sharedfiles/filedetails/?id=2263738446) (with use of forcemap to 'rp_zone_tsade_v1f_fr')

## Convars
+ `guthscpsnav_forcemap <MAP_NAME>`: *Server*; Force a specific minimap to be use instead of current map's image (see the list above). Default: ""

## Known Issues
### "The addon doesn't work!"
Be sure to have installed [[SCP] Guthen's Addons Base](https://steamcommunity.com/sharedfiles/filedetails/?id=2139692777) on your server. Verify that you can open the configuration menu with `guthscpbase` in your game console.

### "Could not connect to map database!"
This message appears on the **S-NAV Ultimate** when the current map does not have an assigned minimap. 

If the map you are using is equivalent with one of the **Supported Maps**, then use the server convar `guthscpsnav_forcemap` (see above) to use a specific minimap.

Otherwise, there are two ways : either you create one yourself (with use of `guthscpsnav_generate` and a digital software) and put it in `materials/guth_scp/snav/MAP_NAME.png` or you ask me to make one. 

## Legal Terms
This addon is licensed under [Creative Commons Sharealike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) and is based on content of [SCP Foundation](http://scp-wiki.wikidot.com/) and [SCP:Containment Breach](https://www.scpcbgame.com/).

If you create something derived from this, please credit me (you can also tell me about what you've done).

***Enjoy !***
