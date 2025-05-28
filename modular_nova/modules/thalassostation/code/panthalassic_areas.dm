/area/panthalassic
	name = "Beach"
	base_lighting_alpha = 255
	static_lighting = FALSE
	outdoors = TRUE
	requires_power = TRUE
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = TRUE
	allow_shuttle_docking = TRUE

/obj/effect/fakelight/panthalassic_sun
	name = "sunlight"
	desc = "It's bright."
	icon = 'icons/effects/light_overlays/light_32.dmi'
	icon_state = "light"
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = EFFECTS_LAYER
	plane = LIGHTING_PLANE
	light_range = 6
	light_power = 1
	light_color = "#ffffff"
	alpha = 0

/area/panthalassic/surface
	name = "Surface"
	base_lighting_color = COLOR_STARLIGHT
	area_flags = FLORA_ALLOWED | MOB_SPAWN_ALLOWED

/obj/effect/fakelight/panthalassic_sun/underwater
	name = "underwater sunlight"
	desc = "It's less bright."
	light_power = 0.8
	light_color = "#A0C8FF"

/obj/effect/fakelight/panthalassic_sun/underwater_deep
	name = "deep underwater sunlight"
	desc = "It's trying okay?"
	light_range = 6
	light_power = 0.6
	light_color = "#406080"

/turf/open/ocean_surface/thalassostation/Initialize()
	. = ..()
	for(var/obj/effect/fakelight/panthalassic_sun/S in src.vis_contents)
		return // Already present, do nothing

	new /obj/effect/fakelight/panthalassic_sun

/turf/open/misc/thalassostation_submerged/Initialize()
	. = ..()
	for(var/obj/effect/fakelight/panthalassic_sun/underwater/S in src.vis_contents)
		return // Already present, do nothing

	new /obj/effect/fakelight/panthalassic_sun/underwater

/turf/open/openspace/thalassostation/Initialize()
	. = ..()
	for(var/obj/effect/fakelight/panthalassic_sun/underwater/S in src.vis_contents)
		return // Already present, do nothing

	new /obj/effect/fakelight/panthalassic_sun/underwater

/turf/open/misc/thalassostation_submerged/Initialize()
	. = ..()
	for(var/obj/effect/fakelight/panthalassic_sun/underwater_deep/S in src.vis_contents)
		return // Already present, do nothing

	new /obj/effect/fakelight/panthalassic_sun/underwater_deep

/area/panthalassic/middle
	name = "Ocean"
	area_flags = CAVES_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/panthalassic_mid_generator
	cap_turf = /turf/open/misc/thalassostation_submerged

/area/panthalassic/floor
	name = "Ocean_Floor"
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/panthalassic_oceanfloor_generator

/area/panthalassic/bathypelagic
	name = "Bathypelagic zone"
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/panthalassic_bathypelagic_generator
