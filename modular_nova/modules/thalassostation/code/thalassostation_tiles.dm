///Surface default tile, can Z_move through it.
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

///first underwater default open
/turf/open/openspace/ocean/thalassostation
	planetary_atmos = 1
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS

/turf/open/openspace/ocean/thalassostation/Initialize(mapload)
	. = ..()
	if (!.)
		return
	AddElement(/datum/element/swimming_tile)

///first underwater default closed
/turf/closed/mineral/random/stationside/ocean/thalassostation
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	baseturfs = /turf/open/misc/ocean/rock/thalassostation

///second underwater layer default open
/turf/open/misc/ocean/thalassostation
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	planetary_atmos = 1

/turf/open/misc/ocean/thalassostation/Initialize(mapload)
	. = ..()
	if (!.)
		return
	AddElement(/datum/element/swimming_tile)

/turf/open/misc/ocean/rock/thalassostation
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	planetary_atmos = 1

/turf/open/misc/ocean/rock/thalassostation/Initialize(mapload)
	. = ..()
	if (!.)
		return
	AddElement(/datum/element/swimming_tile)

///second underwater layer default closed.
/turf/closed/mineral/random/low_chance/ocean/thalassostation
	initial_gas_mix = THALASSOSTATION_DEFAULT_ATMOS
	baseturfs = /turf/open/misc/ocean/rock/thalassostation

///third undeerwater layer default open
/turf/open/misc/ocean/rock/heavy/thalassostation
	initial_gas_mix = THALASSOSTATION_BATHYPELAGIC_ATMOS
	planetary_atmos = 1

/turf/open/misc/ocean/rock/heavy/thalassostation/Initialize(mapload)
	. = ..()
	if (!.)
		return
	AddElement(/datum/element/swimming_tile)

///third underwater layer default closed
/turf/closed/mineral/random/high_chance/ocean/thalassostation
	initial_gas_mix = THALASSOSTATION_BATHYPELAGIC_ATMOS
	baseturfs = /turf/open/misc/ocean/rock/heavy/thalassostation
