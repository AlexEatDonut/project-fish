extends PlayerState

var rng_lurk_timer = RandomNumberGenerator.new()

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("rod_cast")
	print("now in fishing state")

func allow_catch():
		print("can now catch")
		Playerinfo.can_catch = true
		var lurk_timer_time = rng_lurk_timer.randf_range(snappedf(Playerinfo.queued_fish["lurk_time"][0], Playerinfo.queued_fish["lurk_time"][1]),0.01)
		player.fish_lurk_timer.start()

func physics_update(delta: float) -> void:
	pass


func _on_fish_lurk_timer_timeout() -> void:
	finished.emit(DETECTING)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "rod_cast":
		player.animation_player.play("idle_fishing")
		allow_catch()
