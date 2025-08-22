extends Control

signal StartFishing

@onready var start_fishing: Button = $PlayerInteract/StartFishing

@export var audio : AudioStreamWAV

@onready var menu_button: MenuButton = $ButtonsMarginContainer/MenuButton
@onready var menu_button_travel: MenuButton = $ButtonsMarginContainer/GridContainer/MenuButtonTravel

#region Debug menu : Queue of the next fish
@onready var queuedfish_name: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_name
@onready var queuedfish_weight: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_weight
@onready var queuedfish_value: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_value
@onready var queuedfish_sprite: TextureRect = $DebugQueuePanel/MarginContainer/VBoxContainer/MarginContainer/Panel/queuedfish_sprite
#endregion

func _ready() -> void:
	var travel_menu_popup = menu_button_travel.get_popup()
	travel_menu_popup.id_pressed.connect(travel_menu)
	debug_queuedfish_info("none", "", "")

func disable_button():
	start_fishing.disabled = true
func enable_button():
	start_fishing.disabled = false

func _on_start_fishing_pressed() -> void:
	SoundManager.play_sound(audio)
	StartFishing.emit()
	FishLibrary.findFishByBiome(Playerinfo.playerLocationNumber)
	disable_button()

func travel_menu(id):
	print(id)
	if id == Playerinfo.playerLocationNumber:
		print("You are already there !")
		return
	match(id):
		0:
			get_tree().change_scene_to_file("res://maps/devmap_1.tscn")
		1:
			get_tree().change_scene_to_file("res://maps/devmap_2.tscn")
	
	
func debug_queuedfish_info(newname : String, newweight: String,newvalue: String, newsprite = null):
	queuedfish_name.text = newname
	queuedfish_weight.text = newweight
	queuedfish_value.text = newvalue
	if newsprite == null :
		queuedfish_sprite.texture = null
	else :
		queuedfish_sprite.texture = newsprite
