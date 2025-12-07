extends Node3D

@export var ambience2 : AudioStreamWAV

func _ready() -> void:
	Playerinfo.playerLocation = Playerinfo.locations.keys()[2]
	Playerinfo.playerLocationNumber = Playerinfo.locations.LAKE
	#print(var_to_str(Playerinfo.playerLocation))
	await get_tree().create_timer(0.05).timeout
	SoundManager.play_ambient_sound(ambience2)

func _exit_tree() -> void:
	SoundManager.ambient_sounds.stop_all()
