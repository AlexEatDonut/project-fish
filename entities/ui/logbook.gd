extends Control

@onready var grid_fishes: GridContainer = $MarginContainer/VBoxContainer/LogbookContainer/TabContainer/Fishes/MarginContainer/ScrollContainer/MarginContainer/GridFishes
@onready var grid_rods: GridContainer = $MarginContainer/VBoxContainer/LogbookContainer/TabContainer/FishingRods/MarginContainer/ScrollContainer/MarginContainer/GridRods
@onready var grid_baits: GridContainer = $MarginContainer/VBoxContainer/LogbookContainer/TabContainer/Baits/MarginContainer/ScrollContainer/MarginContainer/GridBaits
@onready var grid_misc: GridContainer = $MarginContainer/VBoxContainer/LogbookContainer/TabContainer/Misc/MarginContainer/ScrollContainer/MarginContainer/GridMisc


@onready var item_panel_name: PanelContainer = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/ItemPanel1
@onready var label_name: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/ItemPanel1/MarginContainer/VBoxContainer/LabelName
@onready var label_type: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/ItemPanel1/MarginContainer/VBoxContainer/HBoxContainer/LabelType

@onready var item_panel_description: PanelContainer = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/ItemPanel2
@onready var label_notes: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/ItemPanel2/MarginContainer/VBoxContainer/LabelNotes

@onready var rods_panel_2: PanelContainer = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel2
@onready var label_strengths: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel2/MarginContainer/VBoxContainer/LabelStrengths
@onready var label_weaknesses: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel2/MarginContainer/VBoxContainer/LabelWeaknesses


@onready var rods_panel_1: PanelContainer = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1
@onready var label_base_durability: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1/MarginContainer/VBoxContainer/RodBaseDurability/LabelBaseDurability
@onready var label_base_repair_cost: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1/MarginContainer/VBoxContainer/RodBaseRepairCost/LabelBaseRepairCost
@onready var label_durability_repair_mult: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1/MarginContainer/VBoxContainer/RodDurabilityRepairMult/LabelDurabilityRepairMult
@onready var label_lurk_time_mult: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1/MarginContainer/VBoxContainer/RodLurkTimeMult/LabelLurkTimeMult
@onready var label_catch_window_mult: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/RodsPanel1/MarginContainer/VBoxContainer/RodCatchWindowMult/LabelCatchWindowMult

@onready var fishes_panel_1: PanelContainer = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/FishesPanel1
@onready var label_fish_env: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/FishesPanel1/MarginContainer/VBoxContainer/FishEnv/LabelFishEnv
@onready var label_fish_rarity: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/FishesPanel1/MarginContainer/VBoxContainer/FishRarity/LabelFishRarity
@onready var label_fish_weight: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/FishesPanel1/MarginContainer/VBoxContainer/FishWeight/LabelFishWeight
@onready var label_fish_value: Label = $MarginContainer/VBoxContainer/LogbookContainer/ItemInfoBox/MarginContainer/VBoxContainer/FishesPanel1/MarginContainer/VBoxContainer/FishValue/LabelFishValue


@export_file("*.tscn") var main_menu_scene_path : String

@export var log_shop_item : PackedScene
@export var log_fish_item : PackedScene

var log_shop_item_id : int = 0
var log_fish_item_id : int = 0

func get_main_menu_scene_path() -> String:
	if main_menu_scene_path.is_empty():
		return AppConfig.main_menu_scene_path
	return main_menu_scene_path



func _ready() -> void:
	setup_logbook()
	

#func _process(delta: float) -> void:
	#pass

func setup_logbook() -> void:
	for data in Gamedata.shop_items:
		var temp = log_shop_item.instantiate()
		temp.log_item_pressed.connect(on_item_pressed)
		#temp.log_item_hovered.connect(on_item_hovered)
		match temp.get_category(data):
			"bait":
				grid_baits.add_child(temp)
			"rod":
				grid_rods.add_child(temp)
			"player":
				print("Item is a player upgrade, but no player upgrade tab is available.")
			"misc":
				grid_misc.add_child(temp)
			"":
				print("Item was unable to find corresponding category")
		#grid.add_child(temp)
		temp.setup(data, log_shop_item_id)
		Gamedata.give_item_icon(temp.item_icon, temp.get_icon_id(data))
		log_shop_item_id += 1
	
	for data in Gamedata.fish_dict:
		var temp = log_fish_item.instantiate()
		temp.log_fish_pressed.connect(on_fish_pressed)
		#temp.log_fish_hovered.connect(on_fish_hovered)
		grid_fishes.add_child(temp)
		temp.setup(data, log_fish_item_id)
		Gamedata.give_fish_sprite(temp.item_icon, temp.get_icon_id(data))
		log_fish_item_id += 1


func on_item_pressed(id : String) -> void:
	show_base_panels()
	hide_fishes_panels()
	if Gamedata.shop_items[id]["category"] == "rod":
		show_item_data_rods(id)
	else:
		show_base_panels()
		hide_rods_panels()
		label_name.text = Gamedata.shop_items[id]["item_name"]
		label_type.text = Gamedata.shop_items[id]["category"]
		label_notes.text = Gamedata.shop_items[id]["item_description"]

#func on_item_hovered(id : String):
	#pass
func show_item_data_rods(id : String):
	show_base_panels()
	show_rods_panels()
	
	label_name.text = Gamedata.fishing_rods[id]["item_name"]
	label_notes.text = Gamedata.fishing_rods[id]["item_description"]
	
	label_type.text = "Fishing Rod"
	
	label_strengths.text = Gamedata.fishing_rods[id]["strength_desc"]
	label_weaknesses.text = Gamedata.fishing_rods[id]["weakness-desc"]
	
	label_base_durability.text = str(Gamedata.fishing_rods[id]["base_durability"])
	label_base_repair_cost.text = str(Gamedata.fishing_rods[id]["baseline_repair_cost"])
	label_durability_repair_mult.text = str(Gamedata.fishing_rods[id]["durability_repair_multiplier"])
	label_lurk_time_mult.text = str(Gamedata.fishing_rods[id]["lurk_time_multiplier"])
	label_catch_window_mult.text = str(Gamedata.fishing_rods[id]["catch_window_multiplier"])



func on_fish_pressed(id : String) -> void:
	show_base_panels()
	hide_rods_panels()
	show_fishes_panels()
	label_type.text = "Fish"
	label_name.text = Gamedata.fish_dict[id]["name"]
	label_notes.text = Gamedata.fish_dict[id]["description"]
	label_fish_env.text = Gamedata.fish_dict[id]["fish_env"]
	label_fish_rarity.text = Gamedata.fish_dict[id]["fish_type"]
	label_fish_value.text = str(Gamedata.fish_dict[id]["value"])
	label_fish_weight.text = str(Gamedata.fish_dict[id]["weight"])
	
#func on_fish_hovered(id : String):
	#pass

func hide_all_panels()-> void:
	item_panel_name.visible = false
	item_panel_description.visible = false
	fishes_panel_1.visible = false
	rods_panel_2.visible = false
	rods_panel_1.visible = false

func show_base_panels()-> void:
	item_panel_name.visible = true
	item_panel_description.visible = true

func show_rods_panels()-> void:
	rods_panel_2.visible = true
	rods_panel_1.visible = true

func show_fishes_panels()-> void:
	fishes_panel_1.visible = true

func hide_rods_panels()-> void:
	rods_panel_2.visible = false
	rods_panel_1.visible = false

func hide_fishes_panels()-> void:
	fishes_panel_1.visible = false

func _load_scene(scene_path: String) -> void:
	get_tree().paused = false
	SceneLoader.load_scene(scene_path)

func _on_header_back_btn_pressed() -> void:
	_load_scene(get_main_menu_scene_path())


func _on_header_game_btn_pressed() -> void:
	var map_id = Playerinfo.playerLocationNumber
	match(map_id):
		0:
			#_load_scene("res://maps/devmap_1.tscn")
			_load_scene("res://maps/fishingspot_river.tscn")
		1:
			_load_scene("res://maps/fishingspot_river.tscn")
		2:
			_load_scene("res://maps/fishingspot_lake.tscn")
		_:
			_load_scene("res://maps/fishingspot_river.tscn")
