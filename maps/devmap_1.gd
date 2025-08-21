extends Node3D

func _ready() -> void:
	Playerinfo.playerLocation = Playerinfo.locations.keys()[0]
	Playerinfo.playerLocationNumber = Playerinfo.locations.DEVMAP
	print(var_to_str(Playerinfo.playerLocation))
