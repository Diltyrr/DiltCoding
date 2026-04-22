//Most Railgun Ammo get a boost against robotics. (taken from the strela ammo)
/obj/projectile/bullet/delayed_rail
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/projectile.dmi'
	icon_state = "railgun"
	///How much damage is added if we hit something weak to it.
	var/anti_materiel_damage_addition = 0
	/// What biotype we look for
	var/biotype_we_look_for = MOB_ROBOTIC

/obj/projectile/bullet/delayed_rail/on_hit(atom/target, blocked, pierce_hit)
	if(!isliving(target) || (damage > initial(damage)))
		return ..()
	var/mob/living/target_mob = target
	if(target_mob.mob_biotypes & biotype_we_look_for)
		damage += anti_materiel_damage_addition
	return ..()

/obj/item/ammo_casing/railrod/
	name = "coding railrod"
	desc = "you should probably not see this"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/ammo.dmi'

/obj/item/ammo_casing/railrod/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

// 4.5×22mmR “Featherline”
// Ultra‑light rail rod used in compact pistols and PDWs.

/obj/item/ammo_casing/railrod/c177featherline
	name = "4.5x22mmR Featherline rod"
	desc = "A tiny, cryo-polished rail rod built for micro-coil weapons. Blindingly fast, barely any mass, and almost no over-penetration. More 'precision tool' than bullet."

	icon_state = "fl_loose"

	caliber = CALIBER_177FEATHERLINE
	projectile_type = /obj/projectile/bullet/delayed_rail/c177featherline
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c177featherline

	muzzle_flash_color = "#B8E6FF"

/obj/item/ammo_box/magazine/ammo_stack/c177featherline
	name = "4.5x22mmR Featherline rods"
	desc = "A stack of 4.5x22mmR Featherline rods"
	caliber = CALIBER_177FEATHERLINE
	ammo_type = /obj/item/ammo_casing/railrod/c177featherline
	max_ammo = 18
	casing_w_spacing = 2
	casing_z_padding = 6

/obj/projectile/bullet/delayed_rail/c177featherline
	name = "4.5x22mmR Featherline rod"
	speed = 2.5
	damage = 18
	armour_penetration = 15
	wound_bonus = -10
	demolition_mod = 0.2
	wound_falloff_tile = -8
	embed_falloff_tile = -4

/obj/item/ammo_box/c177featherline
	name = "ammo box (4.5x22mmR Featherline lethal)"
	desc = "A box of 4.5x22mmR Featherline rail rods, holds ten rods."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/ammo.dmi'
	icon_state = "featherlinebox"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_177FEATHERLINE
	ammo_type = /obj/item/ammo_casing/railrod/c177featherline
	max_ammo = 28

// 6.5×28mmR “Midline”
// Standard mid‑coil rail rod for KTB sidearms and carbines.

/obj/item/ammo_casing/railrod/c257midline
	name = "6.5x28mmR Midline rod"
	desc = "A balanced, coil-matched rail rod used in most KTB sidearms and carbines. Fast, clean, and reliable."

	icon_state = "ml_loose"

	caliber = CALIBER_257MIDLINE
	projectile_type = /obj/projectile/bullet/delayed_rail/c257midline
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c257midline

	muzzle_flash_color = "#4fD3c4"

/obj/item/ammo_box/magazine/ammo_stack/c257midline
	name = "6.5x28mmR Midline rods"
	desc = "A stack of 6.5x28mmR Midline rods"
	caliber = CALIBER_257MIDLINE
	ammo_type = /obj/item/ammo_casing/railrod/c257midline
	max_ammo = 15
	casing_w_spacing = 2
	casing_z_padding = 6

/obj/projectile/bullet/delayed_rail/c257midline
	name = "6.5x28mmR Midline rod"
	speed = 3
	damage = 28
	armour_penetration = 25
	wound_bonus = 0
	exposed_wound_bonus = 10
	demolition_mod = 0.3
	anti_materiel_damage_addition = 5
	wound_falloff_tile = -6
	embed_falloff_tile = -3

/obj/item/ammo_box/c257midline
	name = "ammo box (6.5x28mmR Midline lethal)"
	desc = "A box of 6.5x28mmR Midline rail rods, holds ten rods."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/ammo.dmi'
	icon_state = "midlinebox"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_257MIDLINE
	ammo_type = /obj/item/ammo_casing/railrod/c257midline
	max_ammo = 24

// 9×60mmR “Railjack Standard”
// Heavy rod for full platforms.

/obj/item/ammo_casing/railrod/c354railjack
	name = "9x60mmR Railjack Standard rod"
	desc = "A long-coherence penetrator rod built for full railjack coils. Heavy, fast, and brutally good at punching through armor. Favored by marksmen and breachers alike"

	icon_state = "rj_loose"

	caliber = CALIBER_354RAILJACK
	projectile_type = /obj/projectile/bullet/delayed_rail/c354railjack
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c354railjack

	muzzle_flash_color = "#1a4fff"

/obj/item/ammo_box/magazine/ammo_stack/c354railjack
	name = "9x60mmR Railjack Standard rods"
	desc = "A stack of 9x60mmR Railjack Standard rods"
	caliber = CALIBER_354RAILJACK
	ammo_type = /obj/item/ammo_casing/railrod/c177featherline
	max_ammo = 10
	casing_w_spacing = 2
	casing_z_padding = 8

/obj/projectile/bullet/delayed_rail/c354railjack
	name = "9x60mmR Railjack Standard rod"
	speed = 4
	damage = 45
	armour_penetration = 45
	wound_bonus = 10
	exposed_wound_bonus = 20
	demolition_mod = 0.8
	anti_materiel_damage_addition = 20
	wound_falloff_tile = -4
	embed_falloff_tile = -2

/obj/item/ammo_box/c354railjack
	name = "ammo box (9x60mmR Railjack Standard lethal)"
	desc = "A box of 9x60mmR Railjack Standard rail rods, holds ten rods."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/ammo.dmi'
	icon_state = "railjackbox"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_354RAILJACK
	ammo_type = /obj/item/ammo_casing/railrod/c354railjack
	max_ammo = 12

// 9.8×72mmR “Lancecore”
// Bespoke rod built exclusively for the Mag‑Lance.

/obj/item/ammo_casing/railrod/c386lancecore
	name = "9.8x72mmR Lancecore rod"
	desc = "A bespoke, cryo-aligned railjack penetrator built solely for the Mag-Lance. Long, dense, and brutally coherent at extreme range. When you need a shot that doesn't drift."

	icon_state = "lc_loose"

	caliber = CALIBER_386LANCECORE
	projectile_type = /obj/projectile/bullet/delayed_rail/c386lancecore
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c386lancecore

	muzzle_flash_color = "#E8F3FF"

/obj/item/ammo_box/magazine/ammo_stack/c386lancecore
	name = "9.8x72mmR Lancecore rods"
	desc = "A stack of 9.8x72mmR Lancecore rods"
	caliber = CALIBER_386LANCECORE
	ammo_type = /obj/item/ammo_casing/railrod/c386lancecore
	max_ammo = 6
	casing_w_spacing = 2
	casing_z_padding = 8

/obj/projectile/bullet/delayed_rail/c386lancecore
	name = "9.8x72mmR Lancecore rod"
	speed = 5.5
	damage =  55
	armour_penetration = 60
	wound_bonus = 15
	exposed_wound_bonus = 25
	demolition_mod = 1
	anti_materiel_damage_addition = 30
	wound_falloff_tile = -3
	embed_falloff_tile = -1

/obj/item/ammo_box/c386lancecore
	name = "ammo box (9.8x72mmR Lancecore lethal)"
	desc = "A box of 9.8x72mmR Lancecore rail rods, holds ten rods."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/ammo.dmi'
	icon_state = "lancecorebox"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_386LANCECORE
	ammo_type = /obj/item/ammo_casing/railrod/c386lancecore
	max_ammo = 8

// 14×90mmR “Titanstrike”
// Oversized penetrator for the Thunderbolt AMR.

/obj/item/ammo_casing/railrod/c551titanstrike
	name = "14x90mmR Titanstrike rod"
	desc = "An oversized, hyper-density rail penetrator built for the Thunderbolt. Hits like a cannon shot. Meant for bulkheads, mechs, and anything unlucky enough to stand behind them."

	icon_state = "ts_loose"

	caliber = CALIBER_551TITANSTRIKE
	projectile_type = /obj/projectile/bullet/delayed_rail/c551titanstrike
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c551titanstrike

	muzzle_flash_color = "#D6C2FF"

/obj/item/ammo_box/magazine/ammo_stack/c551titanstrike
	name = "14x90mmR Titanstrike rod"
	desc = "A stack of 14x90mmR Titanstrike rod rods"
	caliber = CALIBER_386LANCECORE
	ammo_type = /obj/item/ammo_casing/railrod/c551titanstrike
	max_ammo = 3
	casing_w_spacing = 2
	casing_z_padding = 8

/obj/projectile/bullet/delayed_rail/c551titanstrike
	name = "14x90mmR Titanstrike rod"
	speed = 7.5
	damage = 80
	armour_penetration = 90
	wound_bonus = 25
	exposed_wound_bonus = 40
	demolition_mod = 2.2
	anti_materiel_damage_addition = 60
	wound_falloff_tile = -1
	embed_falloff_tile = 0

/obj/item/ammo_box/c551titanstrike
	name = "ammo box (14x90mmR Titanstrike lethal)"
	desc = "A box of 14x90mmR Titanstrike rail rods, holds five rods."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_Ballistics/ammo.dmi'
	icon_state = "titanstrikebox"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_551TITANSTRIKE
	ammo_type = /obj/item/ammo_casing/railrod/c551titanstrike
	max_ammo = 6
