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

/atom/movable/proc/do_sink_or_float(buoyancy)
	var/turf/open/swimmer_turf = src.loc
	if (!istype(swimmer_turf, /turf/open) || (buoyancy == 0))
		return

	var/turf/turf_below = GET_TURF_BELOW(swimmer_turf)
	if (buoyancy < 0 && istype(swimmer_turf, /turf/open/openspace) && istype(turf_below, /turf/open))
		src.visible_message(
			span_danger("[src] sinks like a stone!"),
			span_userdanger("You feel yourself pulled to the bottom!")
		)
		if (HAS_TRAIT(src, TRAIT_MOVE_SWIMMING))
			REMOVE_TRAIT(src, TRAIT_MOVE_SWIMMING, ELEMENT_TRAIT(/mob/living))
		return

	var/turf/turf_above = GET_TURF_ABOVE(swimmer_turf)
	if (buoyancy > 0 && istype(turf_above, /turf/open/openspace) && turf_above.liquids)
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
	if (!src.liquids)
		return

	var/turf/turf_below = GET_TURF_BELOW(src)
	var/liquid_offset = src.liquid_height - src.turf_height

	// Handle /mob/living
	if (istype(moving_object, /mob/living))
		var/mob/living/living_mob = moving_object
		living_mob.update_buoyancy()

		// Sinking
		if (living_mob.buyoancy < 0 && istype(src, /turf/open/openspace) && istype(turf_below, /turf/open))
			living_mob.visible_message(
				span_danger("[living_mob] sinks like a stone!"),
				span_userdanger("You feel yourself pulled to the bottom!")
			)
			if (HAS_TRAIT(living_mob, TRAIT_MOVE_SWIMMING))
				REMOVE_TRAIT(living_mob, TRAIT_MOVE_SWIMMING, ELEMENT_TRAIT(type))
			return

		// Not deep enough
		if (liquid_offset < LIQUID_STATE_WAIST)
			return

		// Handle flying override
		if (HAS_TRAIT(living_mob, TRAIT_MOVE_FLYING))
			if (src.liquid_height < LIQUID_STATE_FULLTILE)
				return
			if(istype(living_mob, /mob/living/carbon))
				var/mob/living/carbon/maybe_winged = living_mob
				if((maybe_winged.movement_type & FLYING) && !maybe_winged.buckled)
					var/obj/item/organ/wings/functional/wings = maybe_winged.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
					if(wings)
						wings.toggle_flight(maybe_winged)
						wings.fly_slip(maybe_winged)
					else
						return

		// Begin swimming
		if(!HAS_TRAIT(living_mob, TRAIT_MOVE_SWIMMING))
			ADD_TRAIT(living_mob, TRAIT_MOVE_SWIMMING, ELEMENT_TRAIT(type))
			living_mob.visible_message(
				span_notice("[living_mob] starts to swim."),
				span_notice("You start to swim.")
			)

		if (istype(living_mob, /mob/living/carbon))
			var/mob/living/carbon/carbon_mob = living_mob
			carbon_mob.do_sink_or_float()
		return

	// Handle non-mob/living buoyancy
	if (ismovable(moving_object))
		moving_object.do_sink_or_float()

/turf/open/Exited(atom/movable/moving_away, direction)
	. = ..()
	if(!istype(moving_away, /mob/living/carbon))
		return
	var/mob/living/carbon/carbon_leaver = moving_away
	carbon_leaver.update_buoyancy()
	if(!HAS_TRAIT(carbon_leaver, TRAIT_MOVE_SWIMMING))
		return

	if(src.liquids)
		var/liquid_height_with_offset = src.liquid_height - src.turf_height
		if(liquid_height_with_offset > LIQUID_STATE_WAIST)
			return

	REMOVE_TRAIT(carbon_leaver, TRAIT_MOVE_SWIMMING, ELEMENT_TRAIT(type))
