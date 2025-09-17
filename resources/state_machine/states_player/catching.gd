extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("state : CATCHING")
	player.animation_player.play("idle")
	Playerinfo.CurrentState = "CATCHING_BUT_I_NEED_TO_MAKE_IT_DIFFERENT_SO_THAT_ITS_NOT_BUGGED"
	player.enable_ui_element(player.fc_panel)
	Playerinfo.increase_money(Playerinfo.queued_fish["value"])
	player.update_money()
	Playerinfo.decrease_rod_durability(snapped(Playerinfo.queued_fish["rod_damage"] * 0.66, 1))
	player.update_roddurability()
	await get_tree().create_timer(0.2).timeout
	Playerinfo.CurrentState = "CATCHING"



func physics_update(delta: float) -> void:
	pass


func _on_player_interact_pressed() -> void:
		if Playerinfo.CurrentState == "CATCHING" :
			player.disable_ui_element(player.fc_panel)
			finished.emit(IDLE)
