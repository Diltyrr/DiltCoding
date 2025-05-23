/turf/open/openspace/ocean
	name = "ocean"
	planetary_atmos = TRUE
	baseturfs = /turf/open/openspace/ocean
	var/replacement_turf = /turf/open/misc/ocean

/turf/open/openspace/ocean/Initialize(mapload)
	. = ..()

	for(var/obj/structure/flora/plant in contents)
		qdel(plant)
	var/turf/T = GET_TURF_BELOW(src)
	//I wonder if I should error here
	if(!T)
		return
	if(T.turf_flags & NO_RUINS)
		var/turf/newturf = ChangeTurf(replacement_turf, null, CHANGETURF_IGNORE_AIR)
		if(!isopenspaceturf(newturf)) // only openspace turfs should be returning INITIALIZE_HINT_LATELOAD
			return INITIALIZE_HINT_NORMAL
		return
	if(!ismineralturf(T))
		return
	var/turf/closed/mineral/M = T
	M.mineralAmt = 0
	M.gets_drilled()
	baseturfs = /turf/open/openspace/ocean //This is to ensure that IF random turf generation produces a openturf, there won't be other turfs assigned other than openspace.

/turf/open/openspace/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean)
	new_immmutable.add_turf(src)

/turf/open/misc/ironsand/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/ocean

/turf/open/misc/ironsand/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)


/turf/open/misc/ocean/rock
	name = "rock"
	desc = "Polished over centuries of undersea weather conditions and a distinct lack of light."
	baseturfs = /turf/open/misc/ocean/rock
	icon = 'modular_nova/modules/liquids/icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	base_icon_state = "seafloor"
	rand_variants = 0

/turf/open/misc/ocean/rock/warm
	liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean/warm

/turf/open/misc/ocean/rock/warm/fissure
	name = "fissure"
	desc = "A comfortable, warm tempature eminates from these - followed immediately after by toxic chemicals in liquid or gaseous forms; but warmth all the same!"
	icon = 'modular_nova/modules/liquids/icons/turf/fissure.dmi'
	icon_state = "fissure-0"
	base_icon_state = "fissure"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_FISSURE
	canSmoothWith = SMOOTH_GROUP_FISSURE
	light_range = 3
	light_color = LIGHT_COLOR_LAVA

/turf/open/misc/ocean/rock/medium
	icon_state = "seafloor_med"
	base_icon_state = "seafloor_med"
	baseturfs = /turf/open/misc/ocean/rock/medium

/turf/open/misc/ocean/rock/heavy
	icon_state = "seafloor_heavy"
	base_icon_state = "seafloor_heavy"
	baseturfs = /turf/open/misc/ocean/rock/heavy

/turf/open/misc/ocean
	gender = PLURAL
	name = "ocean sand"
	desc = "If you can't escape sandstorms underwater, is anywhere safe?"
	baseturfs = /turf/open/misc/ocean
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	planetary_atmos = TRUE
	var/rand_variants = 12
	var/rand_chance = 30
	var/liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean

/turf/open/misc/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(liquid_type, src)
	new_immmutable.add_turf(src)

	if(rand_variants && prob(rand_chance))
		var/random = rand(1,rand_variants)
		icon_state = "[icon_state][random]"
		base_icon_state = "[icon_state][random]"

/turf/open/floor/plating/ocean_plating
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/ocean

/turf/open/floor/plating/ocean_plating/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/iron/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/iron/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/iron/solarpanel/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/iron/solarpanel/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/engine/hull/reinforced/ocean
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	temperature = T20C
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/ocean

/turf/open/floor/engine/hull/reinforced/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/glass/reinforced/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/glass/reinforced/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/glass/plasma/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/glass/plasma/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/glass/reinforced/plasma/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/glass/reinforced/plasma/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/closed/mineral/random/ocean
	baseturfs = /turf/open/misc/ocean/rock/heavy
	turf_type = /turf/open/misc/ocean/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/high_chance/ocean
	baseturfs = /turf/open/misc/ocean/rock/heavy
	turf_type = /turf/open/misc/ocean/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/low_chance/ocean
	baseturfs = /turf/open/misc/ocean/rock/heavy
	turf_type = /turf/open/misc/ocean/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/stationside/ocean
	baseturfs = /turf/open/misc/ocean/rock/heavy
	turf_type = /turf/open/misc/ocean/rock/heavy
	color = "#58606b"

/obj/effect/abstract/liquid_turf/immutable/canal
	starting_mixture = list(/datum/reagent/water = 100)

/turf/open/misc/canal
	gender = PLURAL
	name = "canal"
	desc = "A section of the earth given way to form a natural aqueduct."
	baseturfs = /turf/open/misc/canal
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	liquid_height = -30
	turf_height = -30

/turf/open/misc/canal/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/canal, src)
	new_immmutable.add_turf(src)

/turf/open/misc/canal_mutable
	gender = PLURAL
	name = "canal"
	desc = "A section of the earth given way to form a natural aqueduct."
	baseturfs = /turf/open/misc/canal_mutable
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	liquid_height = -30
	turf_height = -30

/turf/open/floor/iron/submarine
	name = "submarine floor"
	icon = 'modular_nova/modules/liquids/icons/turf/submarine.dmi'
	base_icon_state = "submarine_floor"
	icon_state = "submarine_floor"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/iron/submarine/rust_heretic_act()
	return

/turf/open/floor/iron/submarine_vents
	name = "submarine floor"
	icon = 'modular_nova/modules/liquids/icons/turf/submarine.dmi'
	base_icon_state = "submarine_vents"
	icon_state = "submarine_vents"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/iron/submarine_vents/rust_heretic_act()
	return

/turf/open/floor/iron/submarine_perf
	name = "submarine floor"
	icon = 'modular_nova/modules/liquids/icons/turf/submarine.dmi'
	base_icon_state = "submarine_perf"
	icon_state = "submarine_perf"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/iron/submarine_perf/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/iron/submarine_perf/rust_heretic_act()
	return

//For now just a titanium wall. I'll make sprites for it later
/turf/closed/wall/mineral/titanium/submarine
	name = "submarine wall"

/// Swimmable surface, can Z_Move through.
/turf/open/water/ocean_surface
	alpha = 255
	base_icon_state = "water"
	canSmoothWith = "0,4,"
	icon = 'icons/turf/beach.dmi'
	icon_state = "deepwater"
	name = "open ocean surface"
	planetary_atmos = 1
	fishing_datum = /datum/fish_source/ocean

/turf/open/water/ocean_surface/Initialize()
	. = ..()
	var/turf/turf_below = GET_TURF_BELOW(src)
	// If the turf below is solid, show shallower visuals
	if (istype(turf_below, /turf/closed))
		src.icon_state = "water"
		src.fishing_datum = /datum/fish_source/ocean/beach

/turf/open/water/ocean_surface/zPassIn(direction)
	if(direction == DOWN)
		for(var/obj/contained_object in contents)
			if(contained_object.obj_flags & BLOCK_Z_IN_DOWN)
				return FALSE
		return TRUE
	if(direction == UP)
		for(var/obj/contained_object in contents)
			if(contained_object.obj_flags & BLOCK_Z_IN_UP)
				return FALSE
		return TRUE
	return FALSE

/turf/open/water/ocean_surface/zPassOut(direction)
	if(direction == DOWN)
		for(var/obj/contained_object in contents)
			if(contained_object.obj_flags & BLOCK_Z_OUT_DOWN)
				return FALSE
		return TRUE
	if(direction == UP)
		return FALSE

/obj/effect/overlay/ocean_surface/
	name = "ocean_surface"
	icon = 'modular_nova/modules/thalassostation/icons/surface_overlay.dmi'
	icon_state = "deepwater"
	density = FALSE
	anchored = TRUE
	appearance_flags = RESET_TRANSFORM|RESET_COLOR|RESET_ALPHA|KEEP_TOGETHER
	vis_flags = VIS_INHERIT_PLANE|VIS_INHERIT_ID
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_INSET_OVERLAY
	layer = WATER_VISUAL_OVERLAY_LAYER
	plane = FLOAT_PLANE

/obj/effect/overlay/ocean_surface/shallow
	icon_state = "water"

/turf/open/water/ocean_surface/Entered(atom/movable/arrived)
	. = ..()

	if (src.icon_state == "water")
		var/obj/effect/overlay/ocean_surface/shallow/shallow_surface = new()
		arrived.vis_contents += shallow_surface
		return

	if (src.icon_state == "deepwater")
		var/obj/effect/overlay/ocean_surface/deep_surface = new()
		arrived.vis_contents += deep_surface
		return

/turf/open/water/ocean_surface/Exit(atom/movable/leaving, direction)
	. = ..()

	for (var/atom/A in leaving.vis_contents)
		if (A.name == "ocean_surface")
			qdel(A)

/turf/open/misc/beach/water_vapor_gas_act()
	. = ..()
	src.clearWet()

/turf/open/water/water_vapor_gas_act()
	. = ..()
	src.clearWet()
