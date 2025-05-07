/area/panthalassic
	name = "Ocean"
	icon_state = "space"
	requires_power = TRUE
	always_unpowered = TRUE
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	outdoors = TRUE
	ambience_index = AMBIENCE_SPACE
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_AREA_SPACE

/area/panthalassic/surface
	area_flags = FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/panthalassic_surface_generator
	name = "Beach"

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

/area/ruin/panthalassic
	area_flags = UNIQUE_AREA
