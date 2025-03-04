/mob/living/silicon/ai/update_stat(reason = "none given")
	if(status_flags & GODMODE)
		return
	if(stat != DEAD)
		if(health <= HEALTH_THRESHOLD_DEAD && check_death_method())
			death()
			create_debug_log("died of damage, trigger reason: [reason]")
			return
		else if(IsSleeping()) //Required for adminfreezing
			KnockOut()
			create_debug_log("fell unconscious, trigger reason: [reason]")
		else if(stat == UNCONSCIOUS)
			WakeUp()
			create_debug_log("woke up, trigger reason: [reason]")
	diag_hud_set_status()

/mob/living/silicon/ai/has_vision(information_only = FALSE)
	return ..() && !lacks_power()
