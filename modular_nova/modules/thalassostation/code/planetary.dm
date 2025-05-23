//thalassostation main atmo

/datum/atmosphere/panthalassic
	id = THALASSOSTATION_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen=5,
		/datum/gas/nitrogen=10,
	)
	normal_gases = list(
		/datum/gas/oxygen=10,
		/datum/gas/nitrogen=10,
	)
	restricted_gases = list(
		/datum/gas/water_vapor=0.1,
	)
	restricted_chance = 20

	minimum_pressure = ONE_ATMOSPHERE
	maximum_pressure = ONE_ATMOSPHERE

	minimum_temp = THALASSOSTATION_MIN_TEMPERATURE
	maximum_temp = THALASSOSTATION_MAX_TEMPERATURE

//thalassostation mining level

/datum/atmosphere/panthalassic/bathypelagic

	id = THALASSOSTATION_BATHYPELAGIC_ATMOS

	// simulating underwater depth by adding to atmo pressure (should probably be reworked if one day gases and liquid are both counted as "atmo")

	minimum_pressure = ONE_ATMOSPHERE * 100
	maximum_pressure = ONE_ATMOSPHERE * 400

	//temperature in the mining level is a constant 4°c

	minimum_temp = 277
	maximum_temp = 277
