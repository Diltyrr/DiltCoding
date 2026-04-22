/obj/item/gun/ballistic/delayed_rail/pistol
	name = "\improper KTB “Surveyor” Marksman Pistol"
	desc = "A precision rail pistol chambered in 4.5x22mmR “Featherline”. Extremely accurate, with a noticeable firing delay and a small four-round magazine."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/guns32x.dmi'
	icon_state = "surveyor"
	accepted_magazine_type = /obj/item/ammo_box/magazine/c177featherline
	spawn_magazine_type = /obj/item/ammo_box/magazine/c177featherline/compact
	bolt_wording = "coil assembly"
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	w_class = WEIGHT_CLASS_SMALL
	tac_reloads = FALSE
	fire_sound_volume = 65
	fire_delay = 1.2 SECONDS
	empty_indicator = TRUE
	casing_ejector = FALSE
	prefire_delay = 0.25 SECONDS

/obj/item/gun/ballistic/delayed_rail/pistol/surveyor_two
	name = "\improper KTB “Surveyor Mk II” Precision Pistol"
	desc = "A high-energy precision rail pistol chambered in 6.5x28mmR “Midline”. Deliberate firing delay and a tiny magazine make it demanding but powerful."
	icon_state = "surveyortwo"
	accepted_magazine_type = /obj/item/ammo_box/magazine/c257midline
	spawn_magazine_type = /obj/item/ammo_box/magazine/c257midline/compact
	fire_sound_volume = 70
	prefire_delay = 0.3 SECONDS
	fire_delay = 1 SECONDS

/obj/item/gun/ballistic/delayed_rail/pistol/ghostline
	name = "\improper KTB “Ghostline” Covert Rail Pistol"
	desc = "A silent, single-shot rail pistol chambered in 6.5x28mmR “Midline”. No muzzle flash and high energy, but slow to reload and fires with a delay."
	icon_state = "ghostline"
	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/c257midline
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/c257midline
	prefire_delay = 0.3 SECONDS
	fire_delay = 0.9 SECONDS
	can_muzzle_flash = FALSE
	fire_sound = 'sound/items/weapons/gun/pistol/shot_suppressed.ogg'
	suppressed = SUPPRESSED_QUIET
