extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	SoundManager.play_sound(player.detect_audio)
	player.enable_sprite(player.sprite_surprise)
	player.enable_button(player.player_interact)
	player.fish_catch_timer.start(Playerinfo.queued_fish["catch_time"])
	Playerinfo.CurrentState = "DETECTING"
	Playerinfo.can_catch = false
	#print("state : DETECTING")

func physics_update(delta: float) -> void:
	pass


func _on_fish_catch_timer_timeout() -> void:
	player.disable_sprite(player.sprite_surprise)
	finished.emit(FAILCATCH)


func _on_player_interact_pressed() -> void:
	if Playerinfo.CurrentState == "DETECTING" :
		player.fish_catch_timer.stop()
		player.disable_sprite(player.sprite_surprise)
		finished.emit(CATCHING)
