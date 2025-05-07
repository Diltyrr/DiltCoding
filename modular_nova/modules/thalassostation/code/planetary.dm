//thalassostation main atmo

/datum/atmosphere/panthalassic
	id = THALASSOSTATION_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen=20,
		/datum/gas/nitrogen=10,
	)
	normal_gases = list(
		/datum/gas/oxygen=10,
		/datum/gas/nitrogen=10,
	)
	restricted_gases = list(
	)
	restricted_chance = 20

	minimum_pressure = WARNING_LOW_PRESSURE + 10
	maximum_pressure = WARNING_HIGH_PRESSURE -10

	minimum_temp = THALASSOSTATION_MIN_TEMPERATURE
	maximum_temp = THALASSOSTATION_MAX_TEMPERATURE

//thalassostation mining level

/datum/atmosphere/panthalassic/bathypelagic

	id = THALASSOSTATION_BATHYPELAGIC_ATMOS

	// simulating underwater depth by adding to atmo pressure (should probably be reworked if one day gases and liquid are both counted as "atmo")

	minimum_pressure = (WARNING_LOW_PRESSURE + 10) * 100
	maximum_pressure = (WARNING_LOW_PRESSURE + 10) * 400

	//temperature in the mining level is a constant 4°c

	minimum_temp = 277
	maximum_temp = 277
