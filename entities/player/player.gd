class_name Player
extends CharacterBody3D

var QueuedFish = []

@export var cast_audio : AudioStreamWAV

signal CastingRod
signal RodCasted

@onready var sub_viewport: SubViewport = $CamPivot/CamLocation/BaseCamera/SubViewportContainer/SubViewport
@onready var cam_pivot: Node3D = $CamPivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#region Debug labels
@onready var queuedfish_name: Label = $CanvasLayer/FishingHud/DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_name
@onready var queuedfish_sprite: TextureRect = $CanvasLayer/FishingHud/DebugQueuePanel/MarginContainer/VBoxContainer/MarginContainer/Panel/queuedfish_sprite
@onready var queuedfish_weight: Label = $CanvasLayer/FishingHud/DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_weight
@onready var queuedfish_value: Label = $CanvasLayer/FishingHud/DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_value
@onready var queuedfish_rarity: Label = $CanvasLayer/FishingHud/DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_rarity
#endregion

#region buttons
@onready var player_interact: Button = $CanvasLayer/FishingHud/PlayerInteract/PlayerInteract

#endregion


#region timers for fishing logic
@onready var fish_lurk_timer: Timer = $FishLurkTimer
@onready var fish_catch_timer: Timer = $FishCatchTimer
#endregion

#region sprites
@onready var sprite_surprise: Sprite3D = $Sprites/SurpriseSprite
@onready var sprite_saddened: Sprite3D = $Sprites/SaddenedSprite

#endregion

@onready var state_machine: StateMachine = $StateMachine

@onready var fishing_hud: Control = $CanvasLayer/FishingHud

func resize():
	sub_viewport.size = DisplayServer.window_get_size()

func _ready() -> void:
	fishing_hud.StartFishing.connect(start_fishing)
	debug_change_data("none", "", "", "")
	resize()
	match Playerinfo.playerLocation:
		"DEVMAP":
			pass
		"RIVER":
			pass

func _process(delta: float) -> void:
	resize()
	

func enable_sprite(sprite):
	sprite.visible = true
func disable_sprite(sprite):
	sprite.visible = false

func disable_button(button):
	button.disabled = true
func enable_button(button):
	button.disabled = false

func start_fishing():
	print("start fishing, gal")
	emit_signal("CastingRod")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#print(anim_name)
	#if anim_name == "rod_cast":
		#animation_player.play("idle_fishing")
		#emit_signal("RodCasted")
	pass

func debug_change_data(newname : String, newweight: String,newvalue: String, newrarity : String, newsprite = 1):
	queuedfish_name.text = newname
	queuedfish_weight.text = newweight
	queuedfish_value.text = newvalue
	queuedfish_rarity.text = newrarity
	#queuedfish_name.text = 
	#queuedfish_value.text = str(queuedfish_fulldata["value"])
	#queuedfish_weight.text = str(queuedfish_fulldata["weight"])
	#queuedfish_rarity.text = queuedfish_fulldata["fishType"]
	#print(queuedfish_fulldata["sprite"])
	match newsprite:
		1.0:
			queuedfish_sprite.texture = FishFinder.devsprite1
		2.0:
			queuedfish_sprite.texture = FishFinder.devsprite2
		_:
			queuedfish_sprite.texture = FishFinder.devsprite1


func _on_stop_fishing_pressed() -> void:
	pass # Replace with function body.
