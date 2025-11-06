extends PlayerState

var rng_lurk_timer = RandomNumberGenerator.new()

func enter(previous_state_path: String, data := {}) -> void:
	Playerinfo.CurrentState = "CASTING"
	player.animation_player.play("rod_cast")
	#print("state : FISHING (Casting)")

func allow_catch():
		Playerinfo.can_catch = true
		player.enable_button(player.player_interact)
		var lurk_timer_time = Playerinfo.get_fish_lurk_timer()
		player.fish_lurk_timer.start(lurk_timer_time)
		player.fish_lurk_timer_preventive.start(lurk_timer_time - 0.15)
		Playerinfo.CurrentState = "FISHING"
		#print("state : FISHING")

func physics_update(delta: float) -> void:
	pass

func _on_fish_lurk_timer_timeout() -> void:
	finished.emit(DETECTING)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "rod_cast":
		player.animation_player.play("idle_fishing")
		allow_catch()


func _on_player_interact_pressed() -> void:
	if Playerinfo.CurrentState == "FISHING" :
		Playerinfo.can_catch = false
		player.fish_lurk_timer.stop()
		finished.emit(IDLE)
	return


func _on_fish_lurk_timer_preventive_timeout() -> void:
	player.disable_button(player.player_interact)
