/datum/element/swimming_tile/enter_water(atom/source, mob/living/swimmer)
    . = ..()
    // Add floating animation (for visual feedback)
    DO_FLOATING_ANIM(swimmer)

    // Give the swimmer the flying movement trait
    ADD_TRAIT(swimmer, TRAIT_MOVE_FLYING, ELEMENT_TRAIT(type))

/datum/element/swimming_tile/out_of_water(atom/source, mob/living/landlubber)
    . = ..()
    // Stop floating animation
    STOP_FLOATING_ANIM(landlubber)

    // Remove the flying trait when leaving the water
    REMOVE_TRAIT(landlubber, TRAIT_MOVE_FLYING, ELEMENT_TRAIT(type))
