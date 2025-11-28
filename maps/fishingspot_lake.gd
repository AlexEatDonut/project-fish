extends Node3D

@export var ambience1 : AudioStreamWAV

func _ready() -> void:
	Playerinfo.playerLocation = Playerinfo.locations.keys()[2]
	Playerinfo.playerLocationNumber = Playerinfo.locations.LAKE
	#print(var_to_str(Playerinfo.playerLocation))
	SoundManager.play_ambient_sound(ambience1)

func _exit_tree() -> void:
	SoundManager.ambient_sounds.stop_all(0.25)
