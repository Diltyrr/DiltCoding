/obj/effect/abstract/liquid_turf/immutable/ocean/pelagic
	starting_mixture = list(/datum/reagent/water/salt = 600) //This could probably be changed to a variable from a proc if we wanted the option to pick from different chemicals.
	starting_temp = 277
	liquid_state = 5

/turf/open/openspace/pelagic_submerged
	initial_gas_mix = PELAGIC_DEFAULT_ATMOS
	baseturfs = /turf/open/openspace/pelagic_submerged

/turf/open/openspace/pelagic_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/pelagic, src)
	new_immmutable.mapload_turf(src)

/turf/open/misc/ironsand/pelagic_submerged
	planetary_atmos = TRUE
	initial_gas_mix = PELAGIC_DEFAULT_ATMOS
	baseturfs = /turf/open/misc/pelagic_submerged

/turf/open/misc/ironsand/pelagic_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/pelagic, src)
	new_immmutable.mapload_turf(src)

/turf/open/misc/pelagic_submerged/rock
	name = "rock"
	desc = "Polished over centuries of undersea weather conditions and a distinct lack of light."
	baseturfs = /turf/open/misc/pelagic_submerged/rock
	icon = 'modular_nova/modules/liquids/icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	base_icon_state = "seafloor"
	rand_variants = 0

/turf/open/misc/pelagic_submerged/rock/heavy
	icon_state = "seafloor_heavy"
	base_icon_state = "seafloor_heavy"
	baseturfs = /turf/open/misc/pelagic_submerged/rock/heavy

/turf/open/misc/pelagic_submerged
	gender = PLURAL
	name = "ocean sand"
	desc = "If you can't escape sandstorms underwater, is anywhere safe?"
	baseturfs = /turf/open/openspace/pelagic_submerged
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	planetary_atmos = 1
	initial_gas_mix = PELAGIC_DEFAULT_ATMOS
	var/rand_variants = 12
	var/rand_chance = 30
	var/liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean/pelagic

/turf/open/misc/pelagic_submerged/Initialize(mapload)
	. = ..()
	if(rand_variants && prob(rand_chance))
		var/random = rand(1,rand_variants)
		icon_state = "[icon_state][random]"
		base_icon_state = "[icon_state][random]"

/turf/open/floor/plating/pelagic_submerged
	baseturfs = /turf/open/misc/pelagic_submerged
	planetary_atmos = TRUE
	initial_gas_mix = PELAGIC_DEFAULT_ATMOS

/turf/open/floor/plating/pelagic_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/pelagic, src)
	new_immmutable.mapload_turf(src)

/turf/open/floor/iron/pelagic_submerged
	planetary_atmos = TRUE
	initial_gas_mix = PELAGIC_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/pelagic_submerged

/turf/open/floor/iron/pelagic_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/pelagic, src)
	new_immmutable.mapload_turf(src)

/turf/open/floor/glass/reinforced/pelagic_submerged
	planetary_atmos = TRUE
	initial_gas_mix = PELAGIC_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/pelagic_submerged

/turf/open/misc/pelagic_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(liquid_type, src)
	new_immmutable.mapload_turf(src)

/turf/open/floor/glass/reinforced/pelagic_submerged/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean/pelagic, src)
	new_immmutable.mapload_turf(src)

/turf/closed/mineral/random/pelagic
	baseturfs = /turf/open/misc/pelagic_submerged/rock/heavy
	turf_type = /turf/open/misc/pelagic_submerged/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/high_chance/pelagic
	baseturfs = /turf/open/misc/pelagic_submerged/rock/heavy
	turf_type = /turf/open/misc/pelagic_submerged/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/low_chance/pelagic
	baseturfs = /turf/open/misc/pelagic_submerged/rock/heavy
	turf_type = /turf/open/misc/pelagic_submerged/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/stationside/pelagic
	baseturfs = /turf/open/openspace/pelagic_submerged
	turf_type = /turf/open/misc/pelagic_submerged/rock/heavy
	color = "#58606b"

/turf/open/floor/plating/pelagic
	planetary_atmos = TRUE
	initial_gas_mix = PELAGIC_DEFAULT_ATMOS

///Poking a hole in a wall should cause flooding immediatly.
/turf/closed/ChangeTurf(path, list/new_baseturfs, flags)
	. = ..()
	for(var/turf/inactive_turf in get_adjacent_open_turfs(src))
		if(inactive_turf && inactive_turf.liquids)  // Check if the turf has liquids
			if(inactive_turf.liquids.immutable)
				SSliquids.active_immutables[inactive_turf] = TRUE
			else
				SSliquids.add_active_turf(inactive_turf)
