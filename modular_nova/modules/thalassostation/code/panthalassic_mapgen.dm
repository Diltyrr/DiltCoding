/datum/map_generator/cave_generator/panthalassic_surface_generator

	weighted_open_turf_types = list(
		/turf/open/openspace/thalassostation/surface = 1
	)

	weighted_mob_spawn_list = list(
			/mob/living/basic/crab = 1
	)

	mob_spawn_chance = 1

	flora_spawn_chance = 25

	weighted_flora_spawn_list = list(
		/obj/structure/flora/coconuts = 1,
		/obj/structure/flora/tree/palm/style_random =1,
		/obj/item/toy/seashell = 1
	)


/datum/map_generator/cave_generator/panthalassic_oceanfloor_generator

	weighted_open_turf_types = list(
		/turf/open/openspace/thalassostation = 1
	)

	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/stationside/ocean/thalassostation =1
	)

	weighted_mob_spawn_list = list(
		/mob/living/basic/crab = 1,
		/mob/living/basic/carp = 1
		)

	mob_spawn_chance = 1

	flora_spawn_chance = 4

	weighted_flora_spawn_list = list(
		/obj/structure/flora/ocean/coral = 1,
		/obj/structure/flora/ocean/longseaweed = 1,
		/obj/structure/flora/ocean/seaweed = 1,
		/obj/item/toy/seashell = 1
	)

/datum/map_generator/cave_generator/panthalassic_mesopelagic_generator

	weighted_open_turf_types = list(
		/turf/open/misc/ocean/thalassostation = 1
	)

	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/low_chance/ocean/thalassosstation = 1
	)

	weighted_mob_spawn_list = list(
		/mob/living/basic/crab = 1,
		/mob/living/basic/carp = 1,
	)

	mob_spawn_chance = 1

	flora_spawn_chance = 4

	weighted_flora_spawn_list = list(
		/obj/structure/flora/ocean/longseaweed = 1,
		/obj/structure/flora/ocean/seaweed = 1,
		/obj/structure/flora/ocean/glowweed = 1,
		/obj/item/toy/seashell = 1
	)

/datum/map_generator/cave_generator/panthalassic_bathypelagic_generator

	weighted_open_turf_types = list(
		/turf/open/misc/ocean/rock/heavy/thalassostation = 1
	)

	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/high_chance/ocean/thalassostation = 1
	)

	weighted_mob_spawn_list = list(
		/mob/living/basic/crab = 1,
		/mob/living/basic/carp = 1,
		/mob/living/basic/carp/mega = 1,
		/mob/living/basic/crab/evil = 1,
		/mob/living/simple_animal/hostile/bigcrab = 1
	)

	mob_spawn_chance = 1

	flora_spawn_chance = 4

	weighted_flora_spawn_list = list(
		/obj/structure/flora/ocean/longseaweed = 1,
		/obj/structure/flora/ocean/seaweed = 1,
		/obj/structure/flora/ocean/glowweed = 1,
		/obj/structure/flora/rock = 1,
		/obj/structure/flora/rock/pile = 1,
		/obj/item/toy/seashell = 1
	)
