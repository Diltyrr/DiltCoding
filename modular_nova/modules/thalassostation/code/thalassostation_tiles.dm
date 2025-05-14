/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation
	starting_mixture = list(/datum/reagent/water/salt = 600) //This could probably be changed to a variable from a proc if we wanted the option to pick from different chemicals.
	starting_temp = 300

/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation
	starting_mixture = list(/datum/reagent/water/salt = 300)

//should be lower
/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation/surface


/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation/bathypelagic
	starting_temp = 277

/// Surface default tile, can Z_move through it.
/turf/open/openspace/thalassostation/surface
	alpha = 200
	base_icon_state = "water"
	canSmoothWith = "0,4,"
	color = "#E8E8E8"
	icon = 'icons/turf/beach.dmi'
	icon_state = "water"
	plane = -6
	name = "open ocean surface"
	var/immerse_overlay_color = "#7799AA"
	planetary_atmos = 1
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	turf_height = -30
	liquid_height = LIQUID_SHOULDERS_LEVEL_HEIGHT


///edited from modular_nova/module_liquids/code/ocean_turf.dm I need specific versions with different liquids, temp, and initialize logic. Overriding the ocean tile just gets messy.
/turf/open/openspace/thalassostation/submerged
	name = "ocean"
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/openspace/thalassostation/submerged
	var/replacement_turf = /turf/open/misc/thalassostation
	liquid_height = LIQUID_HEIGHT_CONSIDER_FULL_TILE

/turf/open/openspace/thalassostation/submerged/LateInitialize()
	. = ..()
	var/turf/turfbelow = GET_TURF_BELOW(src)
	if(isclosedturf(turfbelow))
		var/turf/newturf = ChangeTurf(replacement_turf, null, CHANGETURF_IGNORE_AIR)
		if(!isopenspaceturf(newturf))
			return INITIALIZE_HINT_NORMAL
	return


/turf/open/openspace/thalassostation/surface/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation/surface)
	new_immmutable.mapload_turf(src)
	AddElement(/datum/element/soft_landing)

/turf/open/openspace/thalassostation/submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation)
	new_immmutable.mapload_turf(src)
	AddElement(/datum/element/soft_landing)

/turf/open/misc/ironsand/thalassostation
	planetary_atmos = TRUE
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	baseturfs = /turf/open/misc/thalassostation
	liquid_height = LIQUID_HEIGHT_CONSIDER_FULL_TILE


/turf/open/misc/ironsand/thalassostation/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation, src)
	new_immmutable.mapload_turf(src)
	AddElement(/datum/element/soft_landing)

/turf/open/misc/thalassostation/rock
	name = "rock"
	desc = "Polished over centuries of undersea weather conditions and a distinct lack of light."
	baseturfs = /turf/open/misc/thalassostation/rock
	icon = 'modular_nova/modules/liquids/icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	base_icon_state = "seafloor"
	rand_variants = 0

/turf/open/misc/thalassostation/rock/heavy
	icon_state = "seafloor_heavy"
	base_icon_state = "seafloor_heavy"
	baseturfs = /turf/open/misc/thalassostation/rock/heavy

/turf/open/misc/thalassostation/rock/heavy/bathypelagic
	icon_state = "seafloor_heavy"
	base_icon_state = "seafloor_heavy"
	baseturfs = /turf/open/misc/thalassostation/rock/heavy
	liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation/bathypelagic
	initial_gas_mix = THALASSOSTATION_BATHYPELAGIC_ATMOS

/turf/open/misc/thalassostation
	gender = PLURAL
	name = "ocean sand"
	desc = "If you can't escape sandstorms underwater, is anywhere safe?"
	baseturfs = /turf/open/openspace/thalassostation/submerged
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	planetary_atmos = 1
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	var/rand_variants = 12
	var/rand_chance = 30
	var/liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation
	liquid_height = LIQUID_HEIGHT_CONSIDER_FULL_TILE

/turf/open/Initialize()
	. = ..()
	var/turf/above = GET_TURF_ABOVE(src)

	// Check if the above turf has a liquid, the current turf is not openspace, and the above turf is openspace
	if(above && istype(above, /turf/open/openspace) && above.liquids && !istype(src, /turf/open/openspace))
		new /obj/effect/overlay/lightrays(src)  // Create the lightray effect on this turf


///when we cover a lightray, it should vanish.
/turf/open/openspace/ChangeTurf(path, list/new_baseturfs, flags)
	. = ..()
	if(istype(src, /turf/open/openspace))
		return
	var/turf/below = GET_TURF_BELOW(src)
	if(!below)
		return
	for(var/obj/effect/overlay/lightrays/L in below.contents)
		qdel(L)

///Needed because using the cavegen flora generator will spawn floating structure since I'm using openspaces.
/turf/open/misc/thalassostation/Initialize(mapload)
	. = ..()
	if (prob(20))
		var/list/possible_spawns = list(
			/obj/structure/flora/ocean/coral,
			/obj/structure/flora/ocean/longseaweed,
			/obj/structure/flora/ocean/seaweed,
			/obj/item/toy/seashell,
			/obj/structure/flora/rock,
			/obj/structure/flora/rock/pile
		)
		var/type_to_spawn = pick(possible_spawns)
		new type_to_spawn(src) // Spawns the object on this turf

/turf/open/misc/thalassostation/bottom
	baseturfs = /turf/open/misc/thalassostation/bottom


/turf/open/misc/thalassostation/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(liquid_type, src)
	new_immmutable.mapload_turf(src)
	AddElement(/datum/element/soft_landing)

	if(rand_variants && prob(rand_chance))
		var/random = rand(1,rand_variants)
		icon_state = "[icon_state][random]"
		base_icon_state = "[icon_state][random]"

/turf/open/floor/plating/thalassostation_plating
	baseturfs = /turf/open/misc/thalassostation
	planetary_atmos = TRUE
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	liquid_height = LIQUID_HEIGHT_CONSIDER_FULL_TILE

/turf/open/floor/plating/thalassostation_plating/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation, src)
	new_immmutable.mapload_turf(src)
	AddElement(/datum/element/soft_landing)

/turf/open/floor/iron/thalassostation
	planetary_atmos = TRUE
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/thalassostation_plating
	liquid_height = LIQUID_HEIGHT_CONSIDER_FULL_TILE

/turf/open/floor/iron/thalassostation/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation, src)
	new_immmutable.mapload_turf(src)
	AddElement(/datum/element/soft_landing)

/turf/open/floor/glass/reinforced/thalassosation
	planetary_atmos = TRUE
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/thalassostation_plating
	liquid_height = LIQUID_HEIGHT_CONSIDER_FULL_TILE

/turf/open/floor/glass/reinforced/thalassostation/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation, src)
	new_immmutable.mapload_turf(src)
	AddElement(/datum/element/soft_landing)

/turf/closed/mineral/random/thalassosation
	baseturfs = /turf/open/misc/thalassostation/rock/heavy
	turf_type = /turf/open/misc/thalassostation/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/high_chance/thalassosation
	baseturfs = /turf/open/misc/thalassostation/rock/heavy
	turf_type = /turf/open/misc/thalassostation/rock/heavy
	color = "#58606b"
	initial_gas_mix = THALASSOSTATION_BATHYPELAGIC_ATMOS

/turf/closed/mineral/random/low_chance/thalassosation
	baseturfs = /turf/open/misc/thalassostation/rock/heavy
	turf_type = /turf/open/misc/thalassostation/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/stationside/thalassosation
	baseturfs = /turf/open/openspace/thalassostation/submerged
	turf_type = /turf/open/misc/thalassostation/rock/heavy
	color = "#58606b"

///end of the copy and edit of ocean_turfs.dm

/turf/closed/mineral/random/low_chance/thalassosation/gets_drilled(mob/user, give_exp)
	. = ..()

	var/turf/turf_above = GET_TURF_ABOVE(src)
	if (!turf_above)
		return
	if (istype(turf_above, /turf/open/misc/thalassostation))
		for(var/obj/effect/overlay/lightrays/L in turf_above.contents)
			qdel(L)
		turf_above.ChangeTurf(/turf/open/openspace/thalassostation/submerged)

/// we want mapchanges to cause flooding immediatly.
/turf/closed/ChangeTurf(path, list/new_baseturfs, flags)
	. = ..()
	var/turf/above = GET_TURF_ABOVE(src)
	// Check if there's liquid on the turf above and handle accordingly
	if(above && above.liquids)
		if(above.liquids.immutable)
			SSliquids.active_immutables[above] = TRUE
		else
			SSliquids.add_active_turf(above)

	for(var/turf/inactive_turf in get_adjacent_open_turfs(src))
		if(inactive_turf && inactive_turf.liquids)  // Check if the turf has liquids
			if(inactive_turf.liquids.immutable)
				SSliquids.active_immutables[inactive_turf] = TRUE
			else
				SSliquids.add_active_turf(inactive_turf)

/turf/open/ChangeTurf(path, list/new_baseturfs, flags)
	. = ..()
	if(istype(src, /turf/closed))
		for(var/obj/effect/overlay/lightrays/L in src.contents)
			qdel(L)
