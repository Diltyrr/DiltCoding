///Proc used to update the gun's aimpoint during charge.
/obj/item/gun/ballistic/delayed_rail/proc/update_aim(mob/user, atom/entered)
	ktb_current_aim = entered

/obj/item/gun/ballistic/delayed_rail/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	// If we're already charging, block further firing
	if(is_charging)
		balloon_alert(user, "coil is charging!")
		return FALSE

	if(fire_cd)
		balloon_alert(user, "coil is cooling down!")
		return FALSE

	// Begin charging
	is_charging = TRUE
	overlays += icon(icon, "[icon_state]-fire")

	// Fallback aim = the atom they clicked
	ktb_fallback_aim = interacting_with

	// Start tracking live aim
	RegisterSignal(user, COMSIG_ATOM_MOUSE_ENTERED, PROC_REF(update_aim))

	// Play the charge start sound
	playsound(src, delayed_rail_startup, 50, FALSE)

	// Fire after delay
	addtimer(CALLBACK(src, PROC_REF(fire_after_delay), user), prefire_delay)

	return ITEM_INTERACT_BLOCKING

/obj/item/gun/ballistic/delayed_rail/proc/fire_after_delay(mob/living/user)
	UnregisterSignal(user, COMSIG_ATOM_MOUSE_ENTERED)

	is_charging = FALSE
	overlays -= icon(icon, "[icon_state]-fire")

	if(!(src in user.held_items))
		balloon_alert(user, "charge aborted: safety override active")
		return

	var/atom/aim = ktb_current_aim || ktb_fallback_aim || get_turf(user)

	fire_gun(aim, user)

/obj/item/gun/ballistic/delayed_rail/automatic/on_autofire_start(mob/living/shooter)
	if(charging_autofire)
		return TRUE  // already charging, allow autofire to continue

	if(fire_cd)
		balloon_alert(shooter, "coil is cooling down!")
		return FALSE

	charging_autofire = TRUE
	is_charging = TRUE
	overlays += icon(icon, "[icon_state]-fire")

	playsound(src, delayed_rail_startup, 50, FALSE)

	addtimer(CALLBACK(src, PROC_REF(finish_charge), shooter), prefire_delay)

	return TRUE  // IMPORTANT: autofire must start

/obj/item/gun/ballistic/delayed_rail/automatic/do_autofire(datum/source, atom/target, mob/living/shooter, allow_akimbo, params)
	if(charging_autofire)
		return NONE  // block the shot entirely

	return ..()  // normal autofire behavior

/obj/item/gun/ballistic/delayed_rail/automatic/proc/finish_charge(mob/living/shooter)
	charging_autofire = FALSE
	is_charging = FALSE
	overlays -= icon(icon, "[icon_state]-fire")

	if(!(src in shooter.held_items))
		balloon_alert(shooter, "charge aborted: safety override active")
		return

	// If the user is still holding M1, restart autofire
	if(wants_autofire && shooter.client)
		SEND_SIGNAL(shooter.client, COMSIG_CLIENT_MOUSEDOWN, shooter, get_turf(shooter), null, null)

/obj/item/gun/ballistic/delayed_rail/automatic/autofire_bypass_check(datum/source, client/clicker, atom/target, turf/location, control, params)
	wants_autofire = TRUE
	return ..()

/obj/item/gun/ballistic/delayed_rail/automatic/on_autofire_end()
	wants_autofire = FALSE
	return ..()
