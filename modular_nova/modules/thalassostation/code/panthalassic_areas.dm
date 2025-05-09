/area/panthalassic/surface
	name = "Beach"
	area_has_base_lighting = TRUE
	base_lighting_alpha = 80
	area_flags = FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	outdoors = TRUE

/area/panthalassic/surface/Initialize(mapload)
	if(HAS_TRAIT(SSstation, STATION_TRAIT_BRIGHT_DAY))
		base_lighting_alpha += 145
	return ..()

/area/panthalassic/middle
	name = "Ocean"
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/panthalassic_mid_generator
	outdoors = TRUE

/area/panthalassic/floor
	name = "Ocean_Floor"
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/panthalassic_oceanfloor_generator
	outdoors = TRUE

/area/panthalassic/bathypelagic
	name = "Bathypelagic zone"
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/panthalassic_bathypelagic_generator
	outdoors = TRUE
