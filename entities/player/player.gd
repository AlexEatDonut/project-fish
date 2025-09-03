class_name Player
extends CharacterBody3D

var QueuedFish = []

signal CastingRod
signal RodCasted

@onready var sub_viewport: SubViewport = $CamPivot/CamLocation/BaseCamera/SubViewportContainer/SubViewport
@onready var cam_pivot: Node3D = $CamPivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer


@onready var state_machine: StateMachine = $StateMachine

@onready var fishing_hud: Control = $CanvasLayer/FishingHud

func resize():
	sub_viewport.size = DisplayServer.window_get_size()

func _ready() -> void:
	fishing_hud.StartFishing.connect(start_fishing)
	resize()
	match Playerinfo.playerLocation:
		"DEVMAP":
			pass
		"RIVER":
			pass

func _process(delta: float) -> void:
	resize()
	

func start_fishing():
	print("start fishing, gal")
	emit_signal("CastingRod")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	if anim_name == "rod_cast":
		animation_player.play("idle_fishing")
		emit_signal("RodCasted")
