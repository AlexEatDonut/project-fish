extends PlayerState

var queuedfish_fulldata

func enter(previous_state_path: String, data := {}) -> void:
	player.enable_button(player.player_interact)

func physics_update(delta: float) -> void:
	pass

func _on_player_interact_pressed() -> void:
	SoundManager.play_sound(player.cast_audio)
	queuedfish_fulldata = FishFinder.pick_random_array(FishFinder.get_fishes_by_sorting(Playerinfo.playerLocation, true))
	print(queuedfish_fulldata)
	player.debug_change_data(queuedfish_fulldata["name"], str(queuedfish_fulldata["weight"]),str(queuedfish_fulldata["value"]), str(queuedfish_fulldata["fishType"]), queuedfish_fulldata["sprite"])
	Playerinfo.queued_fish = queuedfish_fulldata
	finished.emit(FISHING)
