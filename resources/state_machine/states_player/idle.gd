extends PlayerState

var queuedfish_fulldata

func enter(previous_state_path: String, data := {}) -> void:
	player.enable_button(player.player_interact)
	player.caughtfish_rarity.remove_theme_color_override("font_color")
	player.animation_player.play("idle")
	Playerinfo.CurrentState = "IDLE"
	#print("state : IDLE")

func physics_update(delta: float) -> void:
	pass

func _on_player_interact_pressed() -> void:
	if Playerinfo.CurrentState == "IDLE" :
		if Playerinfo.rod_durability > 0:
			player.disable_button(player.player_interact)
			SoundManager.play_sound(player.cast_audio)
			queuedfish_fulldata = FishFinder.pick_random_array(FishFinder.get_fishes_by_sorting(Playerinfo.playerLocation, true))
			player.update_fish_caught_celebration_hud(queuedfish_fulldata["name"], str(queuedfish_fulldata["weight"]),str(queuedfish_fulldata["value"]), str(queuedfish_fulldata["fishType"]), queuedfish_fulldata["sprite"])
			Playerinfo.queued_fish = queuedfish_fulldata
			if Playerinfo.debug_mode == true : 
				player.debug_change_data(queuedfish_fulldata["name"], str(queuedfish_fulldata["weight"]),str(queuedfish_fulldata["value"]), str(queuedfish_fulldata["fishType"]), queuedfish_fulldata["sprite"])
			finished.emit(FISHING)
		else:
			print("you can't fish with a rod like that !")
