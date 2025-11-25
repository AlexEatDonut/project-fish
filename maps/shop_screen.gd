extends Node3D

#@onready var lake_ticket_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Misc/PanelContainer/MarginContainer/GridTickets/LakesideTicket/MarginContainer/HBoxContainer/VBoxContainer/LakeTicketBtn
#@onready var bait_up_1_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Baits/PanelContainer/MarginContainer/GridBaits/BaitUp1/MarginContainer/HBoxContainer/VBoxContainer/BaitUp1Btn
#@onready var bait_up_2_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Baits/PanelContainer/MarginContainer/GridBaits/BaitUp2/MarginContainer/HBoxContainer/VBoxContainer/BaitUp2Btn
#@onready var bait_up_3_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Baits/PanelContainer/MarginContainer/GridBaits/BaitUp3/MarginContainer/HBoxContainer/VBoxContainer/BaitUp3Btn

@onready var money_count: Label = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/PanelContainer/MoneyContainer/VBoxContainer/MoneyCount

# TODO : figure out how to add some god damn scrolling
#@onready var grid_baits: GridContainer = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Baits/PanelContainer/MarginContainer/ScrollContainer/GridBaits

@onready var grid_baits: GridContainer = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Baits/PanelContainer/MarginContainer/GridBaits
@onready var grid_misc: GridContainer = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Misc/PanelContainer/MarginContainer/GridMisc
@onready var grid_rods: GridContainer = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Rod/PanelContainer/MarginContainer/GridRods


@export var shop_item : PackedScene

@export var bg_curio_music : AudioStreamWAV
@export var sfx_item_bought : AudioStreamWAV
@export var sfx_item_hover : AudioStreamWAV
@export var sfx_money_change: AudioStreamWAV
@export var sfx_change_category: AudioStreamWAV

#region Hovered item nodes
@onready var hovered_item_texture: TextureRect = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/HoverPreview/MarginContainer/PanelContainer/VBoxContainer/HoveredItemTexture
@onready var hovered_item_name: Label = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/HoverPreview/MarginContainer/PanelContainer/VBoxContainer/HoveredItemName
@onready var hovered_item_desc: Label = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/HoverPreview/MarginContainer/PanelContainer/VBoxContainer/HoveredItemDesc
@onready var hovered_item_price: Label = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/HoverPreview/MarginContainer/PanelContainer/VBoxContainer/HBoxContainer/HoveredItemPrice

#endregion

#region list of all icons used in shop
#111
@export var spr_bait_generic = Texture2D
#211
@export var spr_ticket_generic = Texture2D
#311
@export var spr_rods_generic = Texture2D


#endregion


var shop_item_id : int = 0

func give_item_icon(SpriteRect, spritenumber)->void :
	match spritenumber:
		## BAITS
		111:
			SpriteRect.texture = spr_bait_generic
		## TICKETS 
		211:
			SpriteRect.texture = spr_ticket_generic
		##Rods
		311:
			SpriteRect.texture = spr_rods_generic
		_:
			SpriteRect.texture = null


func _ready() -> void:
	setup_shop()
	SoundManager.play_music(bg_curio_music)
	update_money()
	#check_all_items_availbability()

func lock_button(target_button):
	target_button.disabled = true

func update_money():
	money_count.text = str(Playerinfo.money)

func money_sfx():
	SoundManager.play_ui_sound(sfx_money_change)

func setup_shop() -> void:
	for data in Playerinfo.shop_items:
		var temp = shop_item.instantiate()
		temp.item_buy_pressed.connect(on_item_buy_pressed)
		temp.item_hovered.connect(on_item_hovered)
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
		temp.setup(data, shop_item_id)
		give_item_icon(temp.item_icon, temp.get_icon_id(data))
		shop_item_id += 1

func on_item_buy_pressed(id : String) -> void:
	print(id)
	Playerinfo.decrease_money(Playerinfo.shop_items[id]["item_cost"])
	update_money()
	money_sfx()
	Playerinfo.buy_upgrade(int(Playerinfo.shop_items[id]["item_id"]))
	SoundManager.play_ui_sound(sfx_item_bought)

func on_item_hovered(id : String):
	SoundManager.play_ui_sound(sfx_item_hover)
	#hovered_item_texture.texture = shop_data[id]["icon_id"]
	hovered_item_name.text = Playerinfo.shop_items[id]["item_name"]
	hovered_item_desc.text = Playerinfo.shop_items[id]["item_description"]
	hovered_item_price.text = str(Playerinfo.shop_items[id]["item_cost"])

func reset_item_overview():
	hovered_item_name.text = ""
	hovered_item_desc.text = ""
	hovered_item_price.text = ""


func _on_return_btn_pressed() -> void:
	SoundManager.stop_music(1)
	var map_id = Playerinfo.playerLocationNumber
	match(map_id):
		0:
			get_tree().change_scene_to_file("res://maps/devmap_1.tscn")
		1:
			get_tree().change_scene_to_file("res://maps/fishingspot_river.tscn")
		2:
			get_tree().change_scene_to_file("res://maps/fishingspot_lake.tscn")
		_:
			get_tree().change_scene_to_file("res://maps/fishingspot_river.tscn")


func _on_tab_container_tab_changed(tab: int) -> void:
	SoundManager.play_ui_sound(sfx_change_category)
	reset_item_overview()
