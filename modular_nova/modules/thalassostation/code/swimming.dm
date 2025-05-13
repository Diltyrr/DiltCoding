/// Items that have neutral buyoancy
var/list/heavy_gear = list(
	/obj/item/clothing/shoes/magboots
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
		src.buyoancy += 1
	else if(type in heavy_gear)
		src.buyoancy -= 1

/// Mob buoyancy flags
/atom/movable
	var/buyoancy = 0

// Checks equipped gear, compares with above list.
/mob/living/proc/update_buoyancy()
	var/buoyancy = 0
	for (var/obj/item/carried_item in src.contents)
		if (carried_item.buyoancy > 0)
			buoyancy += 1
		else if (carried_item.buyoancy <0 )
			buoyancy -= 1

	src.do_sink_or_float(buoyancy)

/mob/living/proc/do_sink_or_float(buoyancy)
	var/turf/open/swimmer_turf = src.loc
	if (!istype(swimmer_turf, /turf/open) || (buoyancy == 0))
		return

	var/turf/turf_below = GET_TURF_BELOW(swimmer_turf)
	if (buoyancy < 0 && swimmer_turf.allow_sinking && istype(turf_below, /turf/open))
		src.visible_message(
			span_danger("[src] sinks like a stone!"),
			span_userdanger("You feel yourself pulled to the bottom!")
		)
		if (HAS_TRAIT(src, TRAIT_MOVE_SWIMMING))
			REMOVE_TRAIT(src, TRAIT_MOVE_SWIMMING, ELEMENT_TRAIT(/mob/living))
		return

	var/turf/turf_above = GET_TURF_ABOVE(swimmer_turf)
	if (buoyancy > 0 && istype(turf_above, /turf/open/openspace) && turf_above.liquids && !swimmer_turf.surface)
		src.visible_message(
			span_danger("[src] shoots up toward the surface!"),
			span_userdanger("You feel yourself pulled upward!")
		)
		src.forceMove(turf_above)

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
	if(istype(moving_object, /mob/living/))
		moving_object.update_buoyancy
	var/turf_below = GET_TURF_BELOW(src)
	if(moving_object.sinker)
		if(src.allow_sinking && istype(turf_below, /turf/open))
			moving_object.visible_message(
				span_danger("[moving_object] sinks like a stone!"),
				span_userdanger("You feel yourself pulled to the bottom!")
			)
			if(HAS_TRAIT(moving_object,TRAIT_MOVE_SWIMMING))
				REMOVE_TRAIT(moving_object, TRAIT_MOVE_SWIMMING, ELEMENT_TRAIT(type))
		return

	///can't swim on the surface of a tile with less than waist level water.
	var/liquid_height_with_offset = src.liquid_height - src.turf_height
	if(liquid_height_with_offset < LIQUID_STATE_WAIST)
		return

	ADD_TRAIT(moving_object, TRAIT_MOVE_SWIMMING, ELEMENT_TRAIT(type))
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
	update_buoyancy(moving_away)
	if(!HAS_TRAIT(moving_away, TRAIT_MOVE_SWIMMING))
		return

	if(src.liquids)
		var/liquid_height_with_offset = src.liquid_height - src.turf_height
		if(liquid_height_with_offset > LIQUID_STATE_WAIST)
			return

	REMOVE_TRAIT(moving_away, TRAIT_MOVE_SWIMMING, ELEMENT_TRAIT(type))
