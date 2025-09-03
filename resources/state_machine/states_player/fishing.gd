extends PlayerState

func _ready() -> void:
	#player.RodCasted.connect(allow_catch)
	pass
func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("rod_cast")
	print("now in fishing state")

func allow_catch():
		print("can now catch")
		Playerinfo.can_catch = true

func physics_update(delta: float) -> void:
	pass
