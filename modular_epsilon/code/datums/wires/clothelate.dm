/datum/wires/clothelate
	holder_type = /obj/machinery/clothelate
	wire_count = 10
	proper_name = "Clothelate"
	window_x = 340
	window_y = 55

/datum/wires/clothelate/New(atom/_holder)
	wires = list(WIRE_CLOTHELATE_HACK, WIRE_ELECTRIFY, WIRE_CLOTHELATE_DISABLE)
	return ..()

/datum/wires/clothelate/get_status()
	. = ..()
	var/obj/machinery/clothelate/A = holder
	. += "The red light is [A.disabled ? "off" : "on"]."
	. += "The green light is [A.shocked ? "off" : "on"]."
	. += "The blue light is [A.hacked ? "off" : "on"]."

/datum/wires/clothelate/interactable(mob/user)
	var/obj/machinery/clothelate/A = holder
	if(iscarbon(user) && A.Adjacent(user) && A.shocked && A.shock(user, 100))
		return FALSE
	if(A.panel_open)
		return TRUE
	return FALSE

/datum/wires/clothelate/on_cut(wire, mend)
	var/obj/machinery/clothelate/A = holder
	switch(wire)
		if(WIRE_CLOTHELATE_HACK)
			A.adjust_hacked(!mend)
		if(WIRE_ELECTRIFY)
			A.shocked = !mend
		if(WIRE_CLOTHELATE_DISABLE)
			A.disabled = !mend
	..()

/datum/wires/clothelate/on_pulse(wire)
	if(is_cut(wire))
		return
	var/obj/machinery/clothelate/A = holder
	switch(wire)
		if(WIRE_CLOTHELATE_HACK)
			A.adjust_hacked(!A.hacked)
			addtimer(CALLBACK(A, /obj/machinery/clothelate/.proc/check_hacked_callback), 5 SECONDS)

		if(WIRE_ELECTRIFY)
			A.shocked = !A.shocked
			addtimer(CALLBACK(A, /obj/machinery/clothelate/.proc/check_electrified_callback), 5 SECONDS)

		if(WIRE_CLOTHELATE_DISABLE)
			A.disabled = !A.disabled
			addtimer(CALLBACK(A, /obj/machinery/clothelate/.proc/check_disabled_callback), 5 SECONDS)
