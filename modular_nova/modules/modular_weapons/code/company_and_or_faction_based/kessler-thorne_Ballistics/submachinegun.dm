/obj/item/gun/ballistic/delayed_rail/automatic
	name = "\improper KTB “Courier” Compact Rail PDW"
	desc = "A compact rail-accelerated PDW chambered in 4.5x22mmR “Featherline”. High projectile speed and fast handling, with minimal firing delay."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/guns32x.dmi'
	icon_state = "courier"
	bolt_wording = "coil assembly"
	w_class = WEIGHT_CLASS_NORMAL
	tac_reloads = TRUE
	fire_sound_volume = 80
	fire_delay = 0.4 SECONDS
	burst_size = 1
	actions_types = list()
	mag_display = TRUE
	empty_indicator = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/c177featherline
	spawn_magazine_type = /obj/item/ammo_box/magazine/c177featherline/pdw
	bolt_type = BOLT_TYPE_STANDARD
	show_bolt_icon = FALSE
	empty_indicator = TRUE
	casing_ejector = FALSE
	///How much of a delay between clicking the fire button and the gun actually firing (the main gimmick of the KTB gun, used as a balancing tool for the higher projectile speed)
	prefire_delay = 0.1 SECONDS
	///Are we currently precharging before autofire?
	var/charging_autofire = FALSE
	///Mouseclick tracking for the purpose of delayed autofire.
	var/wants_autofire = FALSE

/obj/item/gun/ballistic/delayed_rail/automatic/Initialize(mapload)
	. = ..()
	give_autofire()

/obj/item/gun/ballistic/delayed_rail/automatic/proc/give_autofire()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/delayed_rail/automatic/sentinel
	name = "\improper KTB “Sentinel” Security Rail SMG"
	desc = "A precisio-focused rail SMG chambered in 4.5x22mmR “Featherline”. High projectile speed and controllable bursts, with minimal delay."
	spawn_magazine_type = /obj/item/ammo_box/magazine/c177featherline/smg
	icon_state = "sentinel"
	fire_sound_volume = 88
	prefire_delay = 0.05 SECONDS
	fire_delay = 0.3 SECONDS
