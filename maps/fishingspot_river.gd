extends Node3D

@export var ambience1 : AudioStreamWAV

func _ready() -> void:
	Playerinfo.playerLocation = Playerinfo.locations.keys()[1]
	Playerinfo.playerLocationNumber = Playerinfo.locations.RIVER
	#print(var_to_str(Playerinfo.playerLocation))
	await get_tree().create_timer(0.05).timeout
	SoundManager.play_ambient_sound(ambience1)
func _exit_tree() -> void:
	SoundManager.ambient_sounds.stop_all()
