/obj/effect/fakelight/benthic_glow
	name = "Filtered Sunlight"
	desc = "Dim rays of light filtered through the ocean surface."
	icon = 'icons/effects/light_overlays/light_32.dmi'
	icon_state = "light"
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = EFFECTS_LAYER
	plane = LIGHTING_PLANE
	light_range = 6
	light_power = 1
	light_color = "#87ceeb"   // soft aqua-blue
	alpha = 128					// semi-transparent glow
