/turf/open/Enter(atom/movable/mover)
	. = ..()
	if(!src.liquids)
		return
	if(!istype(mover, /mob/living/carbon))
		return

	var/liquid_height_with_offset = src.liquid_height - src.turf_height
	if(liquid_height_with_offset < LIQUID_STATE_WAIST)
		return

	ADD_TRAIT(mover, TRAIT_MOVE_FLYING, ELEMENT_TRAIT(type))

/turf/open/Exited(atom/movable/gone, direction)
	. = ..()
	if(!istype(gone, /mob/living/carbon))
		return

	if(!HAS_TRAIT(gone, TRAIT_MOVE_FLYING))
		return

	if(src.liquids)
		var/liquid_height_with_offset = src.liquid_height - src.turf_height
		if(liquid_height_with_offset > LIQUID_STATE_WAIST)
			return

	REMOVE_TRAIT(gone, TRAIT_MOVE_FLYING, ELEMENT_TRAIT(type))
