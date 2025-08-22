class_name Player
extends CharacterBody3D

var QueuedFish = []

@onready var state_machine: StateMachine = $StateMachine

@onready var fishing_hud: Control = $CanvasLayer/FishingHud

func _ready() -> void:
	fishing_hud.StartFishing.connect(start_fishing)
	match Playerinfo.playerLocation:
		"DEVMAP":
			pass
		"RIVER":
			pass

func start_fishing():
	print("start fishing, gal")
