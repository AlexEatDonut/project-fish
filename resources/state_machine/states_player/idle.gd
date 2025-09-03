extends PlayerState

func _ready() -> void:
	#player.CastingRod.connect(started_fishing)
	print(player)
func enter(previous_state_path: String, data := {}) -> void:
	print("idle")

func started_fishing():
	finished.emit(FISHING)

func physics_update(delta: float) -> void:
	pass
