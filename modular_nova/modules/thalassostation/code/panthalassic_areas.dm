/area/panthalassic
	name = "Ocean"
	outdoors = TRUE

/area/panthalassic/surface
	area_flags = FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	name = "Beach"

/area/panthalassic/surface/Initialize(mapload)
	if(HAS_TRAIT(SSstation, STATION_TRAIT_BRIGHT_DAY))
		base_lighting_alpha = 145
	return ..()

/area/panthalassic/floor
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/panthalassic_oceanfloor_generator
	name = "Ocean Floor"

/area/panthalassic/mesopelagic
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/panthalassic_mesopelagic_generator
	name = "Mesopelagic zone"

/area/panthalassic/bathypelagic
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/panthalassic_bathypelagic_generator
	name = "Bathypelagic zone"
