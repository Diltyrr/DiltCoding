/datum/map_generator/cave_generator/pelagic_generator

	weighted_open_turf_types = list(
		//
	)

	weighted_closed_turf_types = list(
		//
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

	perlin_zoom = 65
