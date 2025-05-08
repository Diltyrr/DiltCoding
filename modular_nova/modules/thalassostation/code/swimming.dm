/datum/element/swimming_tile/enter_water(atom/source, mob/living/swimmer)
	. = ..()
	RegisterSignal(swimmer, COMSIG_CAN_Z_MOVE)
	DO_FLOATING_ANIM(swimmer)

/datum/element/swimming_tile/out_of_water(atom/source, mob/living/landlubber)
	. = ..()
	UnregisterSignal(landlubber, COMSIG_CAN_Z_MOVE)
	STOP_FLOATING_ANIM(landlubber)
