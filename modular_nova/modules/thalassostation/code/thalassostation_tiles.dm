// Turfs for Thalassostation

/turf/open/misc/ocean/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/openspace/thalassostation
	planetary_atmos = 1
	initial_gas_mix = "THALASSOSTATION_ATMOS"

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

/turf/open/openspace/thalassostation/surface/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/immerse, icon, icon_state, "immerse", immerse_overlay_color)

/turf/open/water/beach/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/misc/beach/coast/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/misc/beach/coast/corner/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/misc/beach/sand/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/floor/plating/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/misc/grass/jungle/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/floor/wood/large/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/closed/mineral/random/stationside/ocean/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/closed/mineral/random/low_chance/ocean/thalassosstation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/misc/ocean/rock/heavy/thalassostation
	initial_gas_mix = "THALASSOSTATION_BATHYPELAGIC_ATMOS"

/turf/closed/mineral/random/high_chance/ocean/thalassostation
	initial_gas_mix = "THALASSOSTATION_BATHYPELAGIC_ATMOS"

/turf/open/floor/iron/pool/cobble/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/floor/iron/pool/cobble/corner/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/floor/iron/pool/cobble/side/thalassostation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/turf/open/floor/catwalk_floor/iron_smooth/thalassosstation
	initial_gas_mix = "THALASSOSTATION_ATMOS"

/obj/structure/stairs/sand
	icon_state = "stairs_t"
	icon = 'modular_nova/modules/Thalassostation/icons/lightsandstairs.dmi'
