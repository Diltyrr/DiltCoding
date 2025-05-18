/datum/map_generator/cave_generator/panthalassic_mid_generator

	weighted_open_turf_types = list(
		/turf/open/openspace/thalassostation_submerged = 1
	)

	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/stationside/thalassostation =1
	)

	weighted_mob_spawn_list = list(
		/mob/living/basic/crab = 1,
		/mob/living/basic/carp = 1
		)

	mob_spawn_chance = 1

	/// I need this to exist, or else the cavegen will add random floating vents / geysers.
	weighted_feature_spawn_list = list(
		/obj/structure/flora/floating_algae = 1,
		/obj/structure/flora/bioluminescent_cluster = 1,
		/obj/structure/flora/ocean/kelp_balloon = 1,
		/obj/item/toy/seashell = 1
	)

	perlin_zoom = 120

/datum/map_generator/cave_generator/panthalassic_oceanfloor_generator

	weighted_open_turf_types = list(
		/turf/open/misc/thalassostation = 1
	)

	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/low_chance/thalassostation = 1
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

	perlin_zoom = 90

/datum/map_generator/cave_generator/panthalassic_bathypelagic_generator

	weighted_open_turf_types = list(
		/turf/open/misc/thalassostation/rock/heavy =1
	)

	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/high_chance/thalassostation = 1
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
