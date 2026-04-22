/obj/structure/sign/poster/official/kessler_thorne_precision
	name = "Precision Is the Baseline"
	desc = "A sleek Kessler-Thorne advertisement featuring a superconductive rail assembly \
		rendered in silver and horizon blue. The caption reads: 'Precision is not a feature. \
		It is the baseline.'"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_ballistics/propaganda.dmi'
	icon_state = "precision"

/obj/structure/sign/poster/official/kessler_thorne_precision/examine_more(mob/user)
	. = ..()

	. += "<i>Fine print notes that Kessler-Thorne Ballistics reserves the right to refuse \
		service to customers seeking 'volume-fire solutions' or 'weapons incompatible with \
		disciplined operation.'</i>"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/kessler_thorne_precision, 32)

/obj/structure/sign/poster/official/kessler_thorne_calibrated
	name = "Hand-Calibrated. Coil-Matched."
	desc = "A minimalist advertisement showing a technician's gloved hands aligning a \
		superconductive rail pack. The text highlights Kessler-Thorne's signature process: \
		'Hand-Calibrated. Coil-Matched. Field-Ready.'"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/kessler-thorne_ballistics/propaganda.dmi'
	icon_state = "calibrated"

/obj/structure/sign/poster/official/kessler_thorne_calibrated/examine_more(mob/user)
	. = ..()

	. += "<i>Small text clarifies that coil matching is performed by certified technicians \
		and that unauthorized recalibration voids all warranties, guarantees, and \
		'philosophical assurances of accuracy.'</i>"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/kessler_thorne_calibrated, 32)
