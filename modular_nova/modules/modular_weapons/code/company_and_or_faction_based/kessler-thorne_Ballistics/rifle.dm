/obj/item/gun/ballistic/delayed_rail
	name = "\improper KTB “Trailblazer” Rail Carbine"
	desc = "A lightweight civilian rail carbine chambered in 4.5x22mmR “Featherline”. High projectile speed, but a noticeable firing delay and slow follow-up shots."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/guns32x.dmi'
	icon_state = "trailblazer"
	accepted_magazine_type = /obj/item/ammo_box/magazine/c177featherline
	casing_ejector = FALSE
	bolt_wording = "coil assembly"
	bolt_type = BOLT_TYPE_STANDARD
	show_bolt_icon = FALSE
	semi_auto = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	internal_magazine = FALSE
	fire_sound = 'sound/items/weapons/thermalpistol.ogg'
	fire_sound_volume = 80
	tac_reloads = TRUE
	fire_delay = 1 SECONDS
	empty_indicator = TRUE

	///How much of a delay between clicking the fire button and the gun actually firing. The main gimmick of the KTB gun, used as a balancing tool for the higher projectile speed)
	var/prefire_delay = 0.2 SECONDS
	///Are we already preparing a shot? Used to avoid queing multiple shots.
	var/is_charging = FALSE
	///What are we aiming at currently? Used to update the target between clicking to fire and the shot firing.
	var/atom/ktb_current_aim = null
	///What we clicked on when we pulled the trigger. Used as a fallback in case update_aim returns something incompatible.
	var/atom/ktb_fallback_aim = null
	///Sounds used during the delay
	var/sound/delayed_rail_startup = 'sound/items/weapons/gun/tesla/tesla_start.ogg'

/obj/item/gun/ballistic/delayed_rail/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KESSLER_THORNE)

/obj/item/gun/ballistic/delayed_rail/homestead
	name = "\improper KTB “Homestead” Ranch Rifle"
	desc = "A rugged, civilian-legal rail rifle chambered in 4.5x22mmR “Featherline”. Accurate and reliable, but slow to cycle and limited by its internal magazine."
	icon_state = "homestead"
	bolt_type = BOLT_TYPE_LOCKING
	internal_magazine = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/c177featherline/
	fire_sound_volume = 85
	w_class = WEIGHT_CLASS_BULKY
	tac_reloads = FALSE
	prefire_delay = 0.25 SECONDS
	fire_delay = 1.5 SECONDS

/obj/item/gun/ballistic/delayed_rail/longshot
	name = "\improper KTB “Longshot” Tactical Rail Rifle"
	desc = "A designated-marksman rail rifle chambered in 9x60mmR “Railjack Standard”. High-alpha shots with a pronounced firing delay and long rechamber time."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/guns48x.dmi'
	icon_state = "longshot"
	bolt_type = BOLT_TYPE_LOCKING
	accepted_magazine_type = /obj/item/ammo_box/magazine/c354railjack
	fire_sound_volume = 100
	w_class = WEIGHT_CLASS_BULKY
	tac_reloads = FALSE
	prefire_delay = 0.3 SECONDS
	fire_delay = 1.4 SECONDS

/obj/item/gun/ballistic/delayed_rail/breaker
	name = "\improper KTB “Breaker” Anti-Armor Carbine"
	desc = "A heavy rail carbine chambered in 9x60mmR “Railjack Standard”. Trades precision for penetrative force, with a slow, deliberate firing cycle."
	icon_state = "breaker"
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound_volume = 112
	accepted_magazine_type = /obj/item/ammo_box/magazine/c354railjack
	spawn_magazine_type = /obj/item/ammo_box/magazine/c354railjack/compact
	tac_reloads = FALSE
	prefire_delay = 0.25 SECONDS
	fire_delay = 1.2 SECONDS

/obj/item/gun/ballistic/delayed_rail/mag_lance
	name = "\improper KTB “Mag-Lance” Precision Rifle"
	desc = "A high-energy precision rail rifle chambered in 9.8x72mmR “Lancecore”. Extremely powerful shots with a long firing delay and slow reloads."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/guns48x.dmi'
	icon_state = "maglance"
	bolt_type = BOLT_TYPE_LOCKING
	accepted_magazine_type = /obj/item/ammo_box/magazine/c386lancecore
	fire_sound_volume = 105
	w_class = WEIGHT_CLASS_BULKY
	tac_reloads = FALSE
	prefire_delay = 0.4 SECONDS
	fire_delay = 1.6 SECONDS

/obj/item/gun/ballistic/delayed_rail/thunderbolt
	name = "\improper KTB “Thunderbolt” Anti-Materiel Railgun"
	desc = "A single-shot anti-materiel railgun chambered in 14x90mmR “Titanstrike”. Massive recoil, extreme penetration, and a half-second firing delay."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/guns48x.dmi'
	icon_state = "thunderbolt"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/c551titanstrike
	fire_sound_volume = 130
	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	w_class = WEIGHT_CLASS_HUGE
	tac_reloads = FALSE
	prefire_delay = 0.5 SECONDS
	fire_delay = 2 SECONDS

/obj/item/gun/ballistic/delayed_rail/stormcaller
	name = "\improper KTB “Stormcaller” Rapid-Cycle Rail Carbine"
	desc = "A rapid-cycle rail carbine chambered in 6.5x28mmR “Midline”. High velocity and volume of fire, but heavy recoil and coil drift during bursts."
	icon_state = "stormcaller"
	accepted_magazine_type = /obj/item/ammo_box/magazine/c257midline
	fire_delay = 0.25 SECONDS
