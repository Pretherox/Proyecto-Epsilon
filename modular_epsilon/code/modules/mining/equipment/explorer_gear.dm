
// CITADEL ADDITIONS BELOW
//trajes porteados por jiyii

/****************SEVA Suit and Mask****************/

/obj/item/clothing/suit/hooded/explorer/seva
	name = "SEVA suit"
	desc = "A fire-proof suit for exploring hot environments."
	epsilon_icon = TRUE
	icon_state = "seva"
	item_state = "seva"
	hoodtype = /obj/item/clothing/head/hooded/explorer/seva
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	armor = list(MELEE = 20, BULLET = 15, LASER = 20, ENERGY = 15, BOMB = 50, BIO = 100, RAD = 70, FIRE = 65, ACID = 70)
	resistance_flags = FIRE_PROOF

	sprite_sheets = list(
		"Vox" = 'modular_epsilon/icons/mob/clothing/species/vox/suit.dmi',
		"Drask" = 'modular_epsilon/icons/mob/clothing/species/drask/suit.dmi',
		"Tajaran" = 'modular_epsilon/icons/mob/clothing/species/tajaran/suit.dmi',
		"Unathi" = 'modular_epsilon/icons/mob/clothing/species/unathi/suit.dmi',
		"Vulpkanin" = 'modular_epsilon/icons/mob/clothing/species/vulpkanin/suit.dmi'
	)


/obj/item/clothing/head/hooded/explorer/seva
	name = "SEVA hood"
	desc = "A fire-proof hood for exploring hot environments."
	epsilon_icon = TRUE
	icon_state = "seva"
	item_state = "seva"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	armor = list(MELEE = 10, BULLET = 10, LASER = 20, ENERGY = 10, BOMB = 25, BIO = 100, RAD = 80, FIRE = 65, ACID = 70)
	resistance_flags = FIRE_PROOF

	sprite_sheets = list(
		"Vox" = 'modular_epsilon/icons/mob/clothing/species/vox/head.dmi',
		"Drask" = 'modular_epsilon/icons/mob/clothing/species/drask/head.dmi',
		"Grey" = 'modular_epsilon/icons/mob/clothing/species/grey/head.dmi',
		"Skrell" = 'modular_epsilon/icons/mob/clothing/species/skrell/head.dmi'
	)

/obj/item/clothing/mask/gas/seva
	name = "SEVA Mask"
	desc = "A face-covering plate that can be connected to an air supply. Intended for use with the SEVA Suit."
	epsilon_icon = TRUE
	icon_state = "seva"
	item_state = "seva"
	armor = list(MELEE = 0, BULLET = 0, LASER = 10, ENERGY = 5, BOMB = 0, BIO = 100, RAD = 30, FIRE = 65, ACID = 25)
	resistance_flags = FIRE_PROOF

	sprite_sheets = list(
		"Vox" = 'modular_epsilon/icons/mob/clothing/species/vox/mask.dmi',
		"Drask" = 'modular_epsilon/icons/mob/clothing/species/drask/mask.dmi',
		"Unathi" = 'modular_epsilon/icons/mob/clothing/species/unathi/mask.dmi',
		"Tajaran" = 'modular_epsilon/icons/mob/clothing/species/tajaran/mask.dmi',
		"Vulpkanin" = 'modular_epsilon/icons/mob/clothing/species/vulpkanin/mask.dmi',
	)


/****************Exo-Suit and Mask****************/

/obj/item/clothing/suit/hooded/explorer/exo
	name = "Explorer Exoskeleton Mk.I"
	desc = "A very robust military exosuit. It is composed of two separate pieces of equipment: the Radiation suit which boasts heavy military kevlar around the entire body, along with composite plates on some of the outer regions of the armour."
	epsilon_icon = TRUE
	icon_state = "exo"
	item_state = "exo"
	w_class = WEIGHT_CLASS_BULKY
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS|HANDS|FEET
	hoodtype = /obj/item/clothing/head/hooded/explorer/exo
	armor = list(MELEE = 60, BULLET = 35, LASER = 25, ENERGY = 10, BOMB = 60, BIO = 25, RAD = 10, FIRE = 25, ACID = 20)
	resistance_flags = FIRE_PROOF

	sprite_sheets = list(
		"Vox" = 'modular_epsilon/icons/mob/clothing/species/vox/suit.dmi',
		"Drask" = 'modular_epsilon/icons/mob/clothing/species/drask/suit.dmi',
		"Tajaran" = 'modular_epsilon/icons/mob/clothing/species/tajaran/suit.dmi',
		"Unathi" = 'modular_epsilon/icons/mob/clothing/species/unathi/suit.dmi',
		"Vulpkanin" = 'modular_epsilon/icons/mob/clothing/species/vulpkanin/suit.dmi'
	)

/obj/item/clothing/head/hooded/explorer/exo
	name = "Tactical Exo-Helmet"
	desc = "A recent model of a tactical helmet that lacks camouflage. It is not known how it made its way into NT. The helmet is designed to provide a squad leader with strategic superiority over the enemy via its many scanners and satellite communications devices, which have not been installed in this particular helmet. Comes with multi-layered Kevlar protection and armored elements."
	epsilon_icon = TRUE
	icon_state = "exo"
	item_state = "exo"
	armor = list(MELEE = 60, BULLET = 15, LASER = 5, ENERGY = 5, BOMB = 60, BIO = 25, RAD = 10, FIRE = 25, ACID = 0)
	resistance_flags = FIRE_PROOF

	sprite_sheets = list(
		"Vox" = 'modular_epsilon/icons/mob/clothing/species/vox/head.dmi',
		"Drask" = 'modular_epsilon/icons/mob/clothing/species/drask/head.dmi',
		"Grey" = 'modular_epsilon/icons/mob/clothing/species/grey/head.dmi',
		"Skrell" = 'modular_epsilon/icons/mob/clothing/species/skrell/head.dmi'
	)

/obj/item/clothing/mask/gas/exo
	name = "M40 Gasmask"
	desc = "One of various gas masks used by the ancient Miners Guild and its allies to protect from field concentrations of chemical and biological agents, along with radiological fallout particles. It is not effective in an oxygen deficient environment, so it must be connected to an air supply."
	epsilon_icon = TRUE
	icon_state = "exo"
	item_state = "exo"
	armor = list(MELEE = 10, BULLET = 5, LASER = 5, ENERGY = 5, BOMB = 0, BIO = 50, RAD = 0, FIRE = 20, ACID = 40)
	resistance_flags = FIRE_PROOF

	sprite_sheets = list(
		"Vox" = 'modular_epsilon/icons/mob/clothing/species/vox/mask.dmi',
		"Drask" = 'modular_epsilon/icons/mob/clothing/species/drask/mask.dmi',
		"Unathi" = 'modular_epsilon/icons/mob/clothing/species/unathi/mask.dmi',
		"Tajaran" = 'modular_epsilon/icons/mob/clothing/species/tajaran/mask.dmi',
		"Vulpkanin" = 'modular_epsilon/icons/mob/clothing/species/vulpkanin/mask.dmi',
	)
