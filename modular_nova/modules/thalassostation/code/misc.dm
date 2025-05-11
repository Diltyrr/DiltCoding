/obj/structure/drain/heavy_duty
	name = "heavy duty drain"
	desc = "Drainage inlet embedded in the floor to prevent flooding. This one seems very large."
	icon_state = "bigdrain"
	drain_percent = 0.5
	drain_flat = 30

/obj/item/clothing/suit/hazardvest/lifejacket
	name = "life jacket"
	desc = "A snug, buoyant vest packed with enough foam to keep even the most stubborn non-swimmer afloat—mandatory fashion for anyone who prefers not drowning in style."

/obj/effect/overlay/spotlight/sunrays
	icon = 'icons/effects/light_overlays/light_64.dmi'
	icon_state = "spotlight" //placeholder
	pixel_x = -16
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	appearance_flags = RESET_TRANSFORM | LONG_GLIDE | PIXEL_SCALE | TILE_BOUND
	alpha = 240
	light_range = 1
	light_power = 0.7
	light_color = "#88c9e4"
	color = "#88c9e4"
