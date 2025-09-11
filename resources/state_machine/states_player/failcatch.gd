extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("failed to catch fish :(")
	player.disable_button(player.player_interact)
	Playerinfo.CurrentState = "FAILCATCHING"
	player.animation_player.play("idle")
	player.enable_sprite(player.sprite_saddened)
	await get_tree().create_timer(2.0).timeout
	player.enable_button(player.player_interact)
	player.disable_sprite(player.sprite_saddened)
	finished.emit(IDLE)


func physics_update(delta: float) -> void:
	pass
