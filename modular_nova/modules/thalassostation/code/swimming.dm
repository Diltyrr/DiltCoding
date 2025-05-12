/// Items that have neutral buyoancy
var/list/swimming_gear = list(
)

/// Items that should make you float to the top.
var/list/flotation_gear = list(
	/obj/item/clothing/suit/hazardvest/lifejacket
)

///Adding the relevant component to swim gear.
/obj/item/Initialize()
	. = ..()

	// Skip buoyancy setup for body parts.
	if(istype(src, /obj/item/bodypart))
		return

	if(type in flotation_gear)
		src.should_float = TRUE
	else if(!(type in swimming_gear))
		src.should_sink = TRUE

/// Mob buoyancy flags
/atom/movable
	var/should_sink = FALSE
	var/should_float = FALSE

// Checks equipped gear, compares with above list.
/mob/living/proc/update_buoyancy()
	should_sink = FALSE
	should_float = FALSE

	var/found_flotation = FALSE
	var/found_heavy = FALSE

	for(var/obj/item/carried_item in src.contents)
		if(carried_item.should_float)
			found_flotation = TRUE
		else if(carried_item.should_sink)
			found_heavy = TRUE

		if(found_flotation && found_heavy)
			break

	// Final buoyancy logic
	if(found_flotation && !found_heavy)
		should_float = TRUE
	else if(found_heavy && !found_flotation)
		should_sink = TRUE
	// If both, do nothing (neutral)

	src.do_sink_or_float()


/// Perform buoyancy effect (sink or float)
/mob/living/proc/do_sink_or_float()
	var/turf/open/swimmer_turf = src.loc
	if(!istype(swimmer_turf) || (!should_sink && !should_float))
		return

	var/turf/turf_below = GET_TURF_BELOW(swimmer_turf)
	if(should_sink && swimmer_turf.allow_sinking && istype(turf_below, /turf/open))
		src.visible_message(
			span_danger("[src] sinks like a stone!"),
			span_userdanger("You feel yourself pulled to the bottom!")
		)
		GLOB.move_manager.move(swimmer_turf, DOWN)
		return

	var/turf/turf_above = GET_TURF_ABOVE(swimmer_turf)

	if(should_float && istype(turf_above, /turf/open/openspace) && turf_above.liquids && !swimmer_turf.surface)
		src.visible_message(
			span_danger("[src] shoots up toward the surface!"),
			span_userdanger("You feel yourself pulled upward!")
		)
		GLOB.move_manager.move(src, UP)

/obj/item/equipped(mob/user, slot, initial)
	. = ..()
	if(!istype(user, /mob/living))
		return

	var/mob/living/equipper = user
	equipper.update_buoyancy()

/turf/open/Enter(atom/movable/moving_object)
	. = ..()
	if(!src.liquids)
		return

	var/turf_below = GET_TURF_BELOW(src)
	if(moving_object.should_sink)
		if(src.allow_sinking && istype(turf_below, /turf/open))
			moving_object.visible_message(
				span_danger("[moving_object] sinks like a stone!"),
				span_userdanger("You feel yourself pulled to the bottom!")
			)
			if(HAS_TRAIT(moving_object,TRAIT_MOVE_FLYING))
				REMOVE_TRAIT(moving_object, TRAIT_MOVE_FLYING, ELEMENT_TRAIT(type))
		return

	///can't swim on the surface of a tile with less than waist level water.
	var/liquid_height_with_offset = src.liquid_height - src.turf_height
	if(liquid_height_with_offset < LIQUID_STATE_WAIST)
		return

	ADD_TRAIT(moving_object, TRAIT_MOVE_FLYING, ELEMENT_TRAIT(type))
	moving_object.visible_message(
				span_notice("[moving_object]starts to swim."),
				span_notice("You start to swim.")
			)

	if(istype(moving_object, /mob/living/carbon))
		var/mob/living/carbon/carbon_object = moving_object
		carbon_object.do_sink_or_float()

/turf/open/Exited(atom/movable/moving_away, direction)
	. = ..()
	if(!istype(moving_away, /mob/living/carbon))
		return

	if(!HAS_TRAIT(moving_away, TRAIT_MOVE_FLYING))
		return

	if(src.liquids)
		var/liquid_height_with_offset = src.liquid_height - src.turf_height
		if(liquid_height_with_offset > LIQUID_STATE_WAIST)
			return

	REMOVE_TRAIT(moving_away, TRAIT_MOVE_FLYING, ELEMENT_TRAIT(type))
