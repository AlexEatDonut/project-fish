extends Control

@onready var header_back_btn: Button = $MarginContainer/VBoxContainer/LogbookHeader/MarginContainer/HeaderBackBtn

@onready var item_panel_name: PanelContainer = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/ItemPanel1
@onready var label_type: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/ItemPanel1/MarginContainer/VBoxContainer/HBoxContainer/LabelType

@onready var item_panel_description: PanelContainer = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/ItemPanel2
@onready var label_notes: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/ItemPanel2/MarginContainer/VBoxContainer/LabelNotes

@onready var rods_item_data_panel: PanelContainer = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsItemDataPanel
@onready var label_strengths: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsItemDataPanel/MarginContainer/VBoxContainer/LabelStrengths
@onready var label_weaknesses: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsItemDataPanel/MarginContainer/VBoxContainer/LabelWeaknesses


@onready var rods_panel_1: PanelContainer = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1
@onready var label_base_durability: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1/MarginContainer/VBoxContainer/RodBaseDurability/LabelBaseDurability
@onready var label_base_repair_cost: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1/MarginContainer/VBoxContainer/RodBaseRepairCost/LabelBaseRepairCost
@onready var label_durability_repair_mult: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1/MarginContainer/VBoxContainer/RodDurabilityRepairMult/LabelDurabilityRepairMult
@onready var label_lurk_time_mult: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1/MarginContainer/VBoxContainer/RodLurkTimeMult/LabelLurkTimeMult
@onready var label_catch_window_mult: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1/MarginContainer/VBoxContainer/RodCatchWindowMult/LabelCatchWindowMult

@onready var rods_panel_2: PanelContainer = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel2
@onready var texture_fish_weight_1: TextureRect = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel2/MarginContainer/VBoxContainer/HBoxContainer/FishWeight1/TextureFishWeight1
@onready var texture_fish_weight_2: TextureRect = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel2/MarginContainer/VBoxContainer/HBoxContainer/FishWeight2/TextureFishWeight2
@onready var texture_fish_weight_3: TextureRect = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel2/MarginContainer/VBoxContainer/HBoxContainer/FishWeight3/TextureFishWeight3
@onready var texture_fish_weight_4: TextureRect = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel2/MarginContainer/VBoxContainer/HBoxContainer/FishWeight4/TextureFishWeight4
@onready var texture_fish_weight_5: TextureRect = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel2/MarginContainer/VBoxContainer/HBoxContainer/FishWeight5/TextureFishWeight5

@onready var fishing_rods = Playerinfo.fishing_rods

@export_file("*.tscn") var main_menu_scene_path : String

func get_main_menu_scene_path() -> String:
	if main_menu_scene_path.is_empty():
		return AppConfig.main_menu_scene_path
	return main_menu_scene_path



func _ready() -> void:
	print("hello world")

func _process(delta: float) -> void:
	pass

func _load_scene(scene_path: String) -> void:
	get_tree().paused = false
	SceneLoader.load_scene(scene_path)

func _on_header_back_btn_pressed() -> void:
	_load_scene(get_main_menu_scene_path())


func _on_header_game_btn_pressed() -> void:
	var map_id = Playerinfo.playerLocationNumber
	match(map_id):
		0:
			_load_scene("res://maps/devmap_1.tscn")
		1:
			_load_scene("res://maps/fishingspot_river.tscn")
		2:
			_load_scene("res://maps/fishingspot_lake.tscn")
		_:
			_load_scene("res://maps/fishingspot_river.tscn")
