extends Control

@onready var player: Player = $"../.."


@onready var player_interact: Button = $PlayerInteract/PlayerInteract

@onready var bait_rod_menu: PanelContainer = $"ButtonsMarginContainer/Bait&RodCorner/BaitRodMenu"


@onready var menu_button: Button = $ButtonsMarginContainer/MenuButton
@onready var menu_button_travel: MenuButton = $ButtonsMarginContainer/GridContainer/MenuButtonTravel



#region Debug menu : Queue of the next fish

@onready var queuedfish_name: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_name
@onready var queuedfish_weight: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_weight
@onready var queuedfish_value: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_value
@onready var queuedfish_sprite: TextureRect = $DebugQueuePanel/MarginContainer/VBoxContainer/MarginContainer/Panel/queuedfish_sprite
@onready var queuedfish_rarity: Label = $DebugQueuePanel/MarginContainer/VBoxContainer/queuedfish_rarity


#endregion



func _ready() -> void:
	var travel_menu_popup = menu_button_travel.get_popup()
	travel_menu_popup.id_pressed.connect(travel_menu)


func disable_button(button):
	button.disabled = true
func enable_button(button):
	button.disabled = false

func _on_player_interact_pressed() -> void:
	#disable_button(player_interact)
	pass

func travel_menu(id):
	print(id)
	if id == Playerinfo.playerLocationNumber:
		print("You are already there !")
		return
	match(id):
		0:
			get_tree().change_scene_to_file("res://maps/devmap_1.tscn")
		1:
			get_tree().change_scene_to_file("res://maps/fishingspot_river.tscn")
		2:
			if Playerinfo.is_lake_unlocked() == true:
				get_tree().change_scene_to_file("res://maps/fishingspot_lake.tscn")
			else:
				print("Buy the ticket first !")
