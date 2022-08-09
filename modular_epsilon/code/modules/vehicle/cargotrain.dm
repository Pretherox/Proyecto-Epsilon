/*Cargotruck, creado por Vonny. Desprecio este frankenstein de codigo*/

/obj/vehicle/cargotrain
	name = "Cargo truck"
	desc = "It's a cargo truck..."
	icon = 'modular_epsilon/icons/obj/vehicles/vehicles.dmi'
	icon_state = "CocheCargo1"
	anchored = FALSE
	max_integrity = 150
	armor = list(MELEE = 20, BULLET = 5, LASER = 10, ENERGY = 0, BOMB = 30, BIO = 0, RAD = 0, FIRE = 60, ACID = 60)
	key_type = /obj/item/key/cargo
	integrity_failure = 50
	generic_pixel_x = 0
	generic_pixel_y = 4
	vehicle_move_delay = 0.7
	var/mob/living/carbon/human/occupant = null
	var/obj/structure/cargo_trolley/trolley = null
	var/loaddir = 0
	var/cargotrolleyhooked = FALSE //Chequea si esta conectado el Cargo_trolley

/obj/vehicle/cargotrain/examine(mob/user)
	. = ..()
	if(occupant)
		. += "<span class='notice'>[occupant] seems to be driving it.</span>"

/obj/item/key/cargo
	name = "Cargo truck key"
	desc = "It's a cargo truck key!"
	icon = 'modular_epsilon/icons/obj/vehicles/vehicles.dmi'
	icon_state = "keycargo"

/obj/vehicle/cargotrain/Destroy()
	for(var/mob/M in contents)
		M.forceMove(get_turf(src))
	return ..()

/obj/vehicle/cargotrain/handle_vehicle_layer()
	return

/obj/vehicle/cargotrain/handle_vehicle_offsets()
	return

/obj/vehicle/cargotrain/proc/permitted_check(atom/movable/O, mob/user)
	if(O.loc == user) //no you can't pull things out of your ass
		return
	if(user.incapacitated()) //are you cuffed, dying, lying, stunned or other
		return
	if(get_dist(user, src) > 1 || get_dist(user, O) > 1 || user.contents.Find(src)) // is the mob anchored, too far away from you, or are you too far away from the source
		return
	if(!ismob(O)) //humans only
		return
	if(istype(O, /mob/living/simple_animal) || istype(O, /mob/living/silicon)) //animals and robots dont fit
		return
	if(!ishuman(user) && !isrobot(user)) //No ghosts or mice putting people into the sleeper
		return
	if(!user.loc) // just in case someone manages to get a closet into the blue light dimension, as unlikely as that seems
		return
	if(!istype(user.loc, /turf) || !istype(O.loc, /turf)) // are you in a container/closet/pod/etc?
		return
	if(occupant)
		to_chat(user, "<span class='boldnotice'>The cargo truck is already occupied!</span>")
		return
	var/mob/living/L = O
	if(!istype(L) || L.buckled)
		return
	if(L.abiotic())
		to_chat(user, "<span class='boldnotice'>You need both hands to drive the cargo truck</span>")
		return
	if(L.has_buckled_mobs()) //mob attached to us
		to_chat(user, "<span class='warning'>[L] will not fit into [src] because [L.p_they()] [L.p_have()] a slime latched onto [L.p_their()] head.</span>")
		return
	return TRUE

/obj/vehicle/cargotrain/MouseDrop_T(atom/movable/O, mob/user)
	if(!permitted_check(O, user))
		return
	var/mob/living/L = O
	if(!inserted_key)
		to_chat(usr, "It's locked! You need the key.")
		return
	if(key_type && !is_key(inserted_key))
		return
	if(L == user)
		visible_message("[user] starts climbing into the cargo truck.")
	else
		visible_message("[user] starts putting [L.name] into the cargo truck.")
	if(do_after(user, 20, target = L))
		if(!permitted_check(O, user))
			return
		if(!L)
			return
		L.forceMove(src)
		occupant = L
		update_icon(UPDATE_ICON_STATE)
		to_chat(L, "<span class='boldnotice'>You climb into the truck.</span>")
		add_fingerprint(user)
		if(user.pulling == L)
			user.stop_pulling()
		return
	return

/obj/vehicle/cargotrain/verb/move_inside()
	if(usr.stat != 0 || !(ishuman(usr)))
		return
	if(occupant)
		to_chat(usr, "<span class='boldnotice'>The cargo truck is already occupied!</span>")
		return
	if(usr.incapacitated() || usr.buckled) //are you cuffed, dying, lying, stunned or other
		return
	if(usr.has_buckled_mobs()) //mob attached to us
		to_chat(usr, "<span class='warning'>[usr] will not fit into [src] because [usr.p_they()] [usr.p_have()] a slime latched onto [usr.p_their()] head.</span>")
		return
	visible_message("[usr] starts climbing into the cargo truck.")
	if(do_after(usr, 20, target = usr))
		if(occupant)
			to_chat(usr, "<span class='boldnotice'>The cargo truck is already occupied!</span>")
			return
		usr.stop_pulling()
		usr.forceMove(src)
		occupant = usr
		update_icon(UPDATE_ICON_STATE)
		anchored = TRUE

		for(var/obj/O in src)
			qdel(O)
		add_fingerprint(usr)
		return
	return

/obj/vehicle/cargotrain/proc/go_out()
	if(!occupant)
		return
	occupant.forceMove(loc)
	occupant = null
	if(cargotrolleyhooked == FALSE)
		anchored = FALSE

/obj/vehicle/cargotrain/Move(newloc, Dir)
	var/oldloc = loc
	if(trolley && !Adjacent(trolley))
		trolley = null
	. = ..()
	if(trolley && get_dist(oldloc, loc) <= 2)
		trolley.Move(oldloc, get_dir(trolley, oldloc), (last_move_diagonal? 2 : 1) * (vehicle_move_delay + GLOB.configuration.movement.human_delay))
		trolley.dir = Dir

/obj/vehicle/cargotrain/relaymove(mob/user, direction)
	if(Adjacent(trolley) && cargotrolleyhooked == TRUE)
		trolley.density = FALSE
		. = ..()
		sleep(1)
		trolley.density = TRUE
		return
	. = ..()

/obj/vehicle/cargotrain/Bump(atom/movable/M)
	. = ..()
	if(istype(M, /obj/machinery/door) && occupant)
		M.Bumped(occupant)

/obj/vehicle/cargotrain/attack_hand(mob/user as mob)
	if(..())
		return
	if(!inserted_key)
		to_chat(usr, "You can't access the cargo truck controls without the key.")
		return
	ui_interact(user)

/obj/vehicle/cargotrain/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = TRUE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "Cargotrain", name, 400, 150, master_ui, state)
		ui.open()

/obj/vehicle/cargotrain/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("unhook")
			if(trolley)
				to_chat(usr, "You deattach the trolley to the cargotrain.")
				cargotrolleyhooked = FALSE
				trolley.hooked = FALSE
				anchored = FALSE
				trolley.anchored = FALSE
				trolley = null
			else
				to_chat(usr, "There's no trolley attached.")
		if("go_out")
			go_out()
		if("eject1")
			trolley.unload(1)
		if("eject2")
			trolley.unload(2)
		if("eject3")
			trolley.unload(3)
		if("eject4")
			trolley.unload(4)

/obj/vehicle/cargotrain/ui_data(mob/user)
	var/list/data = list()
	if(trolley && !QDELETED(trolley))
		data["crg"] = list("load1" = null, "load2" = null, "load3" = null, "load4" = null)
		if(trolley.load1 && !QDELETED(trolley.load1))
			data["crg"]["load1"] = list("load1name" = trolley.load1.name)
		if(trolley.load2 && !QDELETED(trolley.load2))
			data["crg"]["load2"] = list("load2name" = trolley.load2.name)
		if(trolley.load3 && !QDELETED(trolley.load3))
			data["crg"]["load3"] = list("load3name" = trolley.load3.name)
		if(trolley.load4 && !QDELETED(trolley.load4))
			data["crg"]["load4"] = list("load4name" = trolley.load4.name)
	return data

/obj/structure/cargo_trolley
	name = "cargo train trolley"
	icon = 'modular_epsilon/icons/obj/vehicles/vehicles.dmi'
	icon_state = "Remolque1"
	anchored = FALSE
	density = TRUE
	max_integrity = 200
	armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 0, BOMB = 30, BIO = 0, RAD = 0, FIRE = 60, ACID = 60)
	var/cargohold = 0   //cuantas cajas tiene cargadas
	var/obj/vehicle/cargotrain/crg = null
	var/atom/movable/load1 = null
	var/atom/movable/load2 = null
	var/atom/movable/load3 = null
	var/atom/movable/load4 = null
	var/hooked = FALSE

/obj/structure/cargo_trolley/Destroy()
	for(var/obj/structure/closet/crate/C in contents)
		C.forceMove(get_turf(src))
	return ..()

/obj/structure/cargo_trolley/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Drag [src]'s sprite over the cargo truck to (de)attach it.</span>"

/obj/structure/cargo_trolley/crowbar_act(mob/living/user, obj/item/I)
	if(cargohold > 0)
		unload(1)
		unload(2)
		unload(3)
		unload(4)

/obj/structure/cargo_trolley/MouseDrop(obj/over_object as obj)
	..()
	if(istype(over_object, /obj/vehicle/cargotrain))
		crg = over_object
		if(!crg.trolley)
			crg.trolley = src
			to_chat(usr, "You attach the trolley to the cargo truck.")
			crg.cargotrolleyhooked = TRUE
			hooked = TRUE
			anchored = TRUE
			crg.anchored = TRUE
		else
			to_chat(usr, "There's a trolley attached already!")

/obj/structure/cargo_trolley/MouseDrop_T(atom/movable/AM, mob/user)

	if(user.incapacitated() || HAS_TRAIT(user, TRAIT_HANDS_BLOCKED) || get_dist(user, src) > 1)
		return
	if(hooked == FALSE) //Si no esta hooked a un cargo train, no carga.
		to_chat(usr, "You can't load crates if it's not attached to a cargo truck.")
		return
	if(!istype(AM))
		return
	if(crg.occupant == user)
		to_chat(usr, "You can't load the cargo truck while driving it.")
		return
	load(AM)
	SStgui.update_uis(src)
	if(cargohold == 1)
		icon_state = "Remolque2"
	if(cargohold == 4)
		icon_state = "Remolque3"
	update_icon()

// called to load a crate
/obj/structure/cargo_trolley/proc/load(atom/movable/AM)
	if(cargohold == 4 || AM.anchored || get_dist(src, AM) > 1)
		return

	//I'm sure someone will come along and ask why this is here... well people were dragging screen items onto the truck, and that was not cool.
	//So this is a simple fix that only allows a selection of item types to be considered. Further narrowing-down is below.
	if(!istype(AM, /obj/item) && !istype(AM, /obj/machinery) && !istype(AM, /obj/structure) && !ismob(AM))
		return
	if(!isturf(AM.loc)) //To prevent the loading from stuff from someone's inventory or screen icons.
		return

	var/obj/structure/closet/crate/CRATE
	if(istype(AM,/obj/structure/closet/crate))
		CRATE = AM
	else
		return	// if not hacked, only allow crates to be loaded

	if(CRATE) // if it's a crate, close before loading
		CRATE.close()

	if(isobj(AM))
		var/obj/O = AM
		if(O.has_buckled_mobs() || (locate(/mob) in AM)) //can't load non crates objects with mobs buckled to it or inside it.
			return

	if(isliving(AM))
		return

	if(!load1)
		load1 = AM
		cargohold += 1
		AM.forceMove(src)
		return

	if(!load2)
		load2 = AM
		cargohold += 1
		AM.forceMove(src)
		return

	if(!load3)
		load3 = AM
		cargohold += 1
		AM.forceMove(src)
		return

	if(!load4)
		load4 = AM
		cargohold += 1
		AM.forceMove(src)
		return

/obj/structure/cargo_trolley/proc/unload(which) //La variable selecciona cual load descargas
	if(!load1 && !load2 && !load3 && !load4)
		return
	if(which == 1)
		load1.forceMove(loc)
		load1 = null
		cargohold -= 1
	if(which == 2)
		load2.forceMove(loc)
		load2 = null
		cargohold -= 1
	if(which == 3)
		load3.forceMove(loc)
		load3 = null
		cargohold -= 1
	if(which == 4)
		load4.forceMove(loc)
		load4 = null
		cargohold -= 1
	if(cargohold == 0)
		icon_state = "Remolque1"
	if(cargohold == 1)
		icon_state = "Remolque2"
	if(cargohold == 4)
		icon_state = "Remolque3"
	if(cargohold < 0)
		cargohold = 0
	update_icon()
	SStgui.update_uis(src)
