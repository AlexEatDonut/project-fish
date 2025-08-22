extends Node3D

func _ready() -> void:
	Playerinfo.playerLocation = Playerinfo.locations.keys()[2]
	Playerinfo.playerLocationNumber = Playerinfo.locations.RIVER
	print(var_to_str(Playerinfo.playerLocation))
