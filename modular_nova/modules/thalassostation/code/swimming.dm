#define SWIM_TRAIT_ELEMENT_ID "swimming"

/area/
	var/cap_turf = null

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
			REMOVE_TRAIT(src, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
		return

	var/turf/turf_above = GET_TURF_ABOVE(swimmer_turf)
	if (buoyancy > 0 && istype(turf_above, /turf/open/openspace) && turf_above.liquids)
		src.visible_message(
			span_danger("[src] shoots up toward the surface!"),
			span_userdanger("You feel yourself pulled upward!")
		)
		src.forceMove(turf_above)
	if (buoyancy > 0 && istype(turf_above, /turf/open/water/ocean_surface/))
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
	if (!istype(moving_object, /mob/living))
		return
	var/mob/living/L = moving_object
	if (!src.liquids && !istype(src, /turf/open/water/ocean_surface/))
		if (HAS_TRAIT(L, TRAIT_MOVE_SWIMMING))
			REMOVE_TRAIT(L, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
			L.visible_message(
				span_notice("[L] stops swimming."),
				span_notice("You stop to swim.")
			)
		return
	var/turf/turf_below = GET_TURF_BELOW(src)
	var/liquid_offset = src.liquid_height - src.turf_height
	L.update_buoyancy()
	// Handle sinking immediately
	if (L.buyoancy < 0 && istype(turf_below, /turf/open))
		L.visible_message(
			span_danger("[L] sinks like a stone!"),
			span_userdanger("You feel yourself pulled to the bottom!")
		)
		if (HAS_TRAIT(L, TRAIT_MOVE_SWIMMING))
			REMOVE_TRAIT(L, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
		return
	// Not deep enough to swim
	if (liquid_offset < LIQUID_STATE_WAIST && !istype(src, /turf/open/water/ocean_surface/))
		return
	// Handle flight interruption
	if (HAS_TRAIT(L, TRAIT_MOVE_FLYING) && src.liquid_height >= LIQUID_STATE_FULLTILE)
		if (istype(L, /mob/living/carbon))
			var/mob/living/carbon/C = L
			if ((C.movement_type & FLYING) && !C.buckled)
				var/obj/item/organ/wings/functional/W = C.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
				if (W)
					W.toggle_flight(C)
					W.fly_slip(C)
				else
					return

	// Begin swimming
	if (!HAS_TRAIT(L, TRAIT_MOVE_SWIMMING))
		ADD_TRAIT(L, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
		L.visible_message(
			span_notice("[L] starts to swim."),
			span_notice("You start to swim.")
		)

		if (istype(L, /mob/living/carbon))
			var/mob/living/carbon/C = L
			C.do_sink_or_float()
		return

	// Non-living movable
	if (ismovable(moving_object))
		moving_object.do_sink_or_float()

/// Submerged openspace with a closed turf below should be visually capped by a floor turf.
/// Requires the area to define a `cap_turf` var (typepath) for this behavior to activate.
/turf/open/openspace/LateInitialize()
	. = ..()
	if (!src.liquids)
		return
	var/area/current_area = get_area(src)
	if (current_area.cap_turf)
		var/turf/turf_below = GET_TURF_BELOW(src)
		if (istype(turf_below, /turf/closed/mineral))
			ChangeTurf(current_area.cap_turf, null, CHANGETURF_IGNORE_AIR)


/// If the turf above is a visual cap_turf placed over openspace, remove it.
/turf/closed/ChangeTurf(path, list/new_baseturfs, flags)
	. = ..()

	var/turf/turf_above = GET_TURF_ABOVE(src)
	if (!turf_above)
		return

	if (istype(turf_above, /turf/open/water/ocean_surface))
		var/turf/open/water/ocean_surface/surface_above
		surface_above.icon_state = "deepwater"
		surface_above.fishing_datum = /datum/fish_source/ocean/

	// Check for replacement logic
	var/area/current_area = get_area(turf_above)
	if (current_area.cap_turf && istype(turf_above, current_area.cap_turf))
		qdel(turf_above)

/// Stops rain overlay from forming over the surface of the ocean.
/datum/weather/can_weather_act_turf(turf/valid_weather_turf)
	. = ..()
	if (istype(valid_weather_turf, /turf/open/misc/beach/coast) || istype(valid_weather_turf, /turf/open/water/ocean_surface))
		return FALSE
	return ..()
