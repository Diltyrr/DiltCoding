#define SWIM_TRAIT_ELEMENT_ID "swimming"

/turf/open/Entered(atom/movable/arrived_atom, atom/old_location, list/atom/old_locations)
	. = ..()
	if (!istype(arrived_atom, /mob/living))
		return

	var/mob/living/arrived_mob = arrived_atom

	// Too shallow to swim
	if (src.liquids?.liquid_state < LIQUID_STATE_SHOULDERS)
		if (HAS_TRAIT(arrived_mob, TRAIT_MOVE_SWIMMING))
			REMOVE_TRAIT(arrived_mob, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
			arrived_mob.visible_message(
				span_notice("[arrived_mob] stops swimming."),
				span_notice("You stop swimming.")
			)
		return

	// Not deep enough to swim
	if (src.liquids?.liquid_state < LIQUID_STATE_WAIST)
		return

	// Handle flight interruption
	if (HAS_TRAIT(arrived_mob, TRAIT_MOVE_FLYING) && src.liquids?.liquid_state >= LIQUID_STATE_FULLTILE)
		if (istype(arrived_mob, /mob/living/carbon))
			var/mob/living/carbon/carbon_mob = arrived_mob
			if ((carbon_mob.movement_type & FLYING) && !carbon_mob.buckled)
				var/obj/item/organ/wings/functional/wings = carbon_mob.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
				if (wings)
					wings.toggle_flight(carbon_mob)
					wings.fly_slip(carbon_mob)
				else
					return

	// Begin swimming
	if (!HAS_TRAIT(arrived_mob, TRAIT_MOVE_SWIMMING))
		ADD_TRAIT(arrived_mob, TRAIT_MOVE_SWIMMING, SWIM_TRAIT_ELEMENT_ID)
		arrived_mob.visible_message(
			span_notice("[arrived_mob] starts to swim."),
			span_notice("You start to swim.")
		)
		return
