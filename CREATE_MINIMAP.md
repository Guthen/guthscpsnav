# how to generate a minimap?
##  setup
you first need to have installed this addon in Garry's Mod either via [Github](https://github.com/Guthen/guthscpsnav/archive/refs/heads/master.zip) (in the `garrysmod/addons` folder) or with [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2139521265)

you'll then need an image editor such as [Aseprite](https://www.aseprite.org/), [Krita](https://krita.org/), [GIMP](https://www.gimp.org/), [Affinity Photo](https://affinity.serif.com/fr/photo/), [paint.NET](https://www.getpaint.net/)..
actually, I personally use Aseprite which is for pixel art (since we need to edit raw pixels, it's a nice choice) but I used to use GIMP and it worked well enough, so you can use any software you want. I'll assume you already have basic knowledge about how to use one of them.

##  generating
so.. how to make a minimap? we could draw it by hand but it would take sooo much time and the result may be bad, that's why I coded a simple command in order to make a base texture to work with, run Garry's Mod and follow these steps:
1. launch a singleplayer game by choosing the map you want
2. enter `guthscpsnav_generate` in your game's console
3. tweak the values in the panel to change the height region to capture
4. press the `save to data` button
5. find the generated texture file at `garrysmod/data/guthscp/snav/<map_name>.png`

![image](https://user-images.githubusercontent.com/33220603/203271755-e1dbea21-b6bd-40a6-9e6f-0a6c90672532.png)

##  image editing
this is the most boring part: editing the generated minimap to make it look like a S-NAV map

### setup
first, open the generated texture in your image editor, you'll see that the map void is black and all buildings are transparent (thanks to a bug in my minimap generator), which is quite nice, because we have less things to do (like removing all the colors..).

you should now follow these steps:
1. (possibly) fill with black all non-desired locations (like admins zones, 106 dimension..) 
2. shows only the map walls
	1. select all black pixels (disable 'Contiguous')
	2. shrink your selection by 1px (usually in 'Select' tool list)
	3. delete selected pixels
3. (possibly) reveal some hidden areas by creating an inside 'Outline' 
4. see the in-game result
	1. save the file in `garrysmod/materials/guthscpsnav/minimaps/<map_name>.png` or, if you're making an addon/map, at `garrysmod/addons/<addon_name>/materials/guthscpsnav/minimaps/<map_name>.png`
	2. restart the singleplayer game
	3. equip and activates the S-NAV
5. perfecting the image
	1. walk around in the map and compare the minimap with the world 
	2. remove incorrect or add needed pixels
	3. save your changes, this will automatically updates in the game
	4. see the in-game result
	5. *repeat*.. **again**.. and ***again..***
6. *already finish?* yeah, publish now!
