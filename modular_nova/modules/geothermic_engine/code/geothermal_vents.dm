/obj/structure/thermal_vent
	name = "geothermal vent"
	desc = "A natural vent spewing superheated gases from deep underground."
	//todo icon =
	//todo icon_state =
	anchored = TRUE
	density = FALSE

	/// Pressure of the vent in kilopascals (kPa)
	var/vent_pressure = 500

	/// Temperature of the vent in Kelvin
	var/vent_temperature = 600

	/// Fraction of the vent gas that is mineral impurities (0–1)
	var/vent_impurity_frac = 0.10

/obj/structure/thermal_vent/random
	name = "unstable geothermal vent"
	desc = "A volatile vent with unpredictable pressure, temperature, and impurities."
	// todo icon_state =

	/// Minimum possible temperature (K) for randomized vent
	var/min_temperature = 400

	/// Maximum possible temperature (K) for randomized vent
	var/max_temperature = 1200

	/// Minimum possible pressure (kPa) for randomized vent
	var/min_pressure = 200

	/// Maximum possible pressure (kPa) for randomized vent
	var/max_pressure = 2000

	/// Minimum fraction of impurities in vent gas
	var/min_impurity_fraction = 0.05

	/// Maximum fraction of impurities in vent gas
	var/max_impurity_fraction = 0.25

/obj/structure/thermal_vent/random/Initialize()
	. = ..()
	vent_temperature = rand(min_temperature, max_temperature)
	vent_pressure = rand(min_pressure, max_pressure)
	vent_impurity_frac = randfloat(min_impurity_fraction, max_impurity_fraction)

/// Returns a float between min and max
/proc/randfloat(min, max)
    return min + (rand() / 100) * (max - min)

/datum/gas/water_vapor/mineral_impurities
	id = GAS_WATER_VAPOR_MINERAL_IMPURITIES
	name = "Water Vapor with Mineral Impurities"
	desc = "Water vapor containing trace minerals. Slightly more conductive and leaves residue on surfaces."
	primary_color = "#a0b0c0"
	specific_heat = 38 // slightly lower due to impurities
	base_value = 0.6 // slightly more valuable
	moles_visible = MOLES_GAS_VISIBLE
	purchaseable = FALSE

/obj/machinery/atmospherics/components/unary/geo_vent_tap
	name = "geothermal vent tap"
	desc = "A machinery unit that draws superheated gases from a geothermal vent into the station's piping."
	//todo icon
	//todo icon_state = "vent_tap"
	anchored = TRUE
	density = TRUE

	/// Reference to the vent this tap is built over
	var/obj/structure/thermal_vent/linked_vent
	/// Flow rate multiplier (how aggressively it pulls gas relative to vent pressure)
	var/flow_multiplier = 0.01
	/// Cached pipenet connection
	var/datum/pipeline/connected_pipenet

/obj/machinery/atmospherics/components/unary/geo_vent_tap/Initialize()
	. = ..()
	// Find vent underneath
	var/turf/T = get_turf(src)
	for(var/obj/structure/thermal_vent/V in T)
		linked_vent = V
		break

/obj/machinery/atmospherics/components/unary/geo_vent_tap/process()
	if(!linked_vent || !connected_pipenet)
		return

	// Calculate amount to inject based on vent pressure
	var/injection_moles = linked_vent.vent_pressure * flow_multiplier

	// Build a gasmix from vent parameters
	var/datum/gas_mixture/injected_mix = new /datum/gas_mixture()
	injected_mix.temperature = linked_vent.vent_temperature

	var/water_fraction = 1 - linked_vent.vent_impurity_frac
	var/impurity_fraction = linked_vent.vent_impurity_frac

	ASSERT_GAS(/datum/gas/water_vapor, injected_mix)
	injected_mix.gases[/datum/gas/water_vapor][MOLES] = injection_moles * water_fraction

	ASSERT_GAS(/datum/gas/water_vapor/mineral_impurities, injected_mix)
	injected_mix.gases[/datum/gas/water_vapor/mineral_impurities][MOLES] = injection_moles * impurity_fraction

	// Merge into connected pipenet
	connected_pipenet.air.merge(injected_mix)
