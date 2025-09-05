extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.enable_sprite(player.sprite_surprise)
	player.fish_catch_timer.start(Playerinfo.queued_fish["catch_time"])

func physics_update(delta: float) -> void:
	pass


func _on_fish_catch_timer_timeout() -> void:
	player.disable_sprite(player.sprite_surprise)
	finished.emit(FAILCATCH)
