/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation
	starting_mixture = list(/datum/reagent/water/salt = 600) //This could probably be changed to a variable from a proc if we wanted the option to pick from different chemicals.
	starting_temp = 300
	liquid_state = 5

/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation/opensubmerged
	starting_mixture = list(/datum/reagent/water/salt = 600) //This could probably be changed to a variable from a proc if we wanted the option to pick from different chemicals.


/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation/bathypelagic
	starting_temp = 277

/// Surface default tile, can Z_move through it.
/turf/open/ocean_surface/thalassostation
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS


///edited from modular_nova/module_liquids/code/ocean_turf.dm I need specific versions with different liquids, temp, and initialize logic. Overriding the ocean tile just gets messy.
/turf/open/openspace/thalassostation_submerged
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	baseturfs = /turf/open/openspace/thalassostation_submerged

/turf/open/openspace/thalassostation
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	baseturfs = /turf/open/openspace/thalassostation

/turf/open/openspace/thalassostation_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation)
	new_immmutable.mapload_turf(src)

/turf/open/misc/ironsand/thalassostation_submerged
	planetary_atmos = TRUE
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	baseturfs = /turf/open/misc/thalassostation_submerged


/turf/open/misc/ironsand/thalassostation_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation, src)
	new_immmutable.mapload_turf(src)

/turf/open/misc/thalassostation_submerged/rock
	name = "rock"
	desc = "Polished over centuries of undersea weather conditions and a distinct lack of light."
	baseturfs = /turf/open/misc/thalassostation_submerged/rock
	icon = 'modular_nova/modules/liquids/icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	base_icon_state = "seafloor"
	rand_variants = 0

/turf/open/misc/thalassostation_submerged/rock/heavy
	icon_state = "seafloor_heavy"
	base_icon_state = "seafloor_heavy"
	baseturfs = /turf/open/misc/thalassostation_submerged/rock/heavy

/turf/open/misc/thalassostation_submerged/rock/heavy/bathypelagic
	icon_state = "seafloor_heavy"
	base_icon_state = "seafloor_heavy"
	baseturfs = /turf/open/misc/thalassostation_submerged/rock/heavy
	liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation/bathypelagic
	initial_gas_mix = THALASSOSTATION_BATHYPELAGIC_ATMOS

/turf/open/misc/thalassostation_submerged
	gender = PLURAL
	name = "ocean sand"
	desc = "If you can't escape sandstorms underwater, is anywhere safe?"
	baseturfs = /turf/open/openspace/thalassostation_submerged
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

///Needed because using the cavegen flora generator will spawn floating structure since I'm using openspaces.
/turf/open/misc/thalassostation_submerged/Initialize(mapload)
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

/turf/open/misc/thalassostation_submerged/bottom
	baseturfs = /turf/open/misc/thalassostation_submerged/bottom

/turf/open/misc/thalassostation_submerged/Initialize(mapload)
	. = ..()
	if(rand_variants && prob(rand_chance))
		var/random = rand(1,rand_variants)
		icon_state = "[icon_state][random]"
		base_icon_state = "[icon_state][random]"

/turf/open/floor/plating/thalassostation_submerged
	baseturfs = /turf/open/misc/thalassostation_submerged
	planetary_atmos = TRUE
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS

/turf/open/floor/plating/thalassostation_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation, src)
	new_immmutable.mapload_turf(src)

/turf/open/floor/iron/thalassostation_submerged
	planetary_atmos = TRUE
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/thalassostation_submerged

/turf/open/floor/iron/thalassostation_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation, src)
	new_immmutable.mapload_turf(src)

/turf/open/floor/glass/reinforced/thalassostation_submerged
	planetary_atmos = TRUE
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/thalassostation_submerged

/turf/open/misc/thalassostation_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(liquid_type, src)
	new_immmutable.mapload_turf(src)

/turf/open/floor/glass/reinforced/thalassostation_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/thalassostation, src)
	new_immmutable.mapload_turf(src)


/turf/closed/mineral/random/thalassostation
	baseturfs = /turf/open/misc/thalassostation_submerged/rock/heavy
	turf_type = /turf/open/misc/thalassostation_submerged/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/high_chance/thalassostation
	baseturfs = /turf/open/misc/thalassostation_submerged/rock/heavy
	turf_type = /turf/open/misc/thalassostation_submerged/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/low_chance/thalassostation
	baseturfs = /turf/open/misc/thalassostation_submerged/rock/heavy
	turf_type = /turf/open/misc/thalassostation_submerged/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/stationside/thalassostation
	baseturfs = /turf/open/openspace/thalassostation_submerged
	turf_type = /turf/open/misc/thalassostation_submerged/rock/heavy
	color = "#58606b"

///end of the copy and edit of ocean_turfs.dm

/turf/open/floor/plating/thalassostation
	planetary_atmos = TRUE
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS

///Poking a hole in a wall should cause flooding immediatly.
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

///When a non-natural wall is built, if layer above is surface, put a plating on it.
/turf/open/place_on_top(turf/added_layer, flags)
	. = ..()
	if(ispath(added_layer, /turf/open/))
		return
	var/turf/above_turf = GET_TURF_ABOVE(src)
	if(istype(above_turf, /turf/open/ocean_surface/thalassostation) || istype(above_turf, /turf/open/openspace/thalassostation))
		above_turf.ChangeTurf(/turf/open/floor/plating/thalassostation, null, CHANGETURF_IGNORE_AIR)

///We don't want surface floating over a non full turf, or full turf without a surface.
/turf/open/liquids_change(new_state)
	. = ..()
	var/list/adj_turf = get_adjacent_turfs(src)
	for (var/turf/checking_turf in adj_turf)
		if(!checking_turf?.liquids?.immutable)
			SSliquids.add_active_turf(checking_turf)
	if(istype(src, /turf/open/ocean_surface/thalassostation) || istype(src, /turf/open/misc/beach))
		qdel(src.liquids)
		return
	var/turf/above_turf = GET_TURF_ABOVE(src)
	if(src.liquids?.liquid_state < LIQUID_STATE_FULLTILE)
		if(istype(above_turf, /turf/open/ocean_surface/thalassostation))
			above_turf.ChangeTurf(/turf/open/openspace/thalassostation, null, CHANGETURF_IGNORE_AIR)
	if(src.liquids?.liquid_state > LIQUID_STATE_SHOULDERS)
		if(istype(above_turf, /turf/open/openspace/thalassostation))
			above_turf.ChangeTurf(/turf/open/ocean_surface/thalassostation, null, CHANGETURF_IGNORE_AIR)
		for(var/mob/living/L in src.contents)
			if (!HAS_TRAIT(L, TRAIT_MOVE_SWIMMING))
				ADD_TRAIT(L, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
				L.visible_message(
					span_notice("[L] starts to swim."),
					span_notice("You start to swim.")
				)
	if(src.liquids?.liquid_state < LIQUID_STATE_SHOULDERS)
		for(var/mob/living/L in src.contents)
			if (HAS_TRAIT(L, TRAIT_MOVE_SWIMMING))
				REMOVE_TRAIT(L, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
				L.visible_message(
					span_notice("[L] stops swimming."),
					span_notice("You stop swimming.")
				)

/turf/open/misc/beach/coast/thalassostation
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS

/turf/open/misc/beach/coast/corner/thalassostation
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS

/turf/open/misc/beach/sand/thalassostation
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS

/turf/open/proc/add_remove_lightrays()
	var/turf/above_turf = GET_TURF_ABOVE(src)
	if(!above_turf)
		return
	if(istype(above_turf, /turf/open/openspace || /turf/open/ocean_surface))
		src.color = "#FFFF"
	else
		src.color = null
