/// Items that should make you sink to the bottom.
var/list/heavy_gear = list(
	/obj/item/clothing/shoes/magboots,
	/obj/item/storage/backpack/duffelbag,
	/obj/item/mod/control
)

/// Items that should make you float to the top.
var/list/flotation_gear = list(
	/obj/item/clothing/suit/hazardvest/lifejacket
)

/// Mob buoyancy flags
/atom/movable
	var/should_sink = FALSE
	var/should_float = FALSE

/// Recalculate buoyancy based on carried gear
/mob/living/proc/update_buoyancy()
	should_sink = FALSE
	should_float = FALSE

	for(var/obj/item/carried_item in src.contents)
		if(!should_sink && heavy_gear.Find(carried_item.type))
			should_sink = TRUE
		if(!should_float && flotation_gear.Find(carried_item.type))
			should_float = TRUE
		if(should_sink && should_float)
			break

	if(should_sink && should_float)
		should_sink = FALSE
		should_float = FALSE

/// Perform buoyancy effect (sink or float)
/mob/living/carbon/proc/do_sink_or_float()
	var/turf/swimmer_turf = src.loc
	if(!should_sink && !should_float)
		return

	var/turf/turf_below = GET_TURF_BELOW(swimmer_turf)
	if(should_sink && istype(swimmer_turf, /turf/open/openspace) && istype(turf_below, /turf/open))
		src.visible_message(
			span_danger("[src] sinks like a stone!"),
			span_userdanger("You feel yourself pulled to the bottom!")
		)
		GLOB.move_manager.move(swimmer_turf, DOWN)
		return

	var/turf/turf_above = GET_TURF_ABOVE(swimmer_turf)
	if(should_float && istype(turf_above, /turf/open/openspace) && !istype(swimmer_turf, /turf/open/openspace/thalassostation/surface))
		src.visible_message(
			span_danger("[src] shoots up toward the surface!"),
			span_userdanger("You feel yourself pulled upward!")
		)
		GLOB.move_manager.move(src, UP)

/obj/item/pickup(mob/user)
	. = ..()
	if(istype(user, /mob/living))
		var/mob/living/living_user = user
		living_user.update_buoyancy()
		if(istype(living_user, /mob/living/carbon))
			var/mob/living/carbon/carbon_user = living_user
			carbon_user.do_sink_or_float()

/obj/item/dropped(mob/user, silent)
	. = ..()
	if(istype(user, /mob/living))
		var/mob/living/living_user = user
		living_user.update_buoyancy()
		if(istype(living_user, /mob/living/carbon))
			var/mob/living/carbon/carbon_user = living_user
			carbon_user.do_sink_or_float()

/turf/open/Enter(atom/movable/moving_object)
	. = ..()
	if(!src.liquids || !istype(moving_object, /mob/living/carbon))
		return

	if(moving_object.should_sink)
		moving_object.visible_message(
			span_danger("[moving_object] sinks like a stone!"),
			span_userdanger("You feel yourself pulled to the bottom!")
		)
		return

	var/liquid_height_with_offset = src.liquid_height - src.turf_height
	if(liquid_height_with_offset < LIQUID_STATE_WAIST)
		return

	ADD_TRAIT(moving_object, TRAIT_MOVE_FLYING, ELEMENT_TRAIT(type))

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
