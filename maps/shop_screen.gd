extends Node3D

#@onready var lake_ticket_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Misc/PanelContainer/MarginContainer/GridTickets/LakesideTicket/MarginContainer/HBoxContainer/VBoxContainer/LakeTicketBtn
#@onready var bait_up_1_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Baits/PanelContainer/MarginContainer/GridBaits/BaitUp1/MarginContainer/HBoxContainer/VBoxContainer/BaitUp1Btn
#@onready var bait_up_2_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Baits/PanelContainer/MarginContainer/GridBaits/BaitUp2/MarginContainer/HBoxContainer/VBoxContainer/BaitUp2Btn
#@onready var bait_up_3_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Baits/PanelContainer/MarginContainer/GridBaits/BaitUp3/MarginContainer/HBoxContainer/VBoxContainer/BaitUp3Btn

@onready var money_count: Label = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/PanelContainer/MoneyContainer/VBoxContainer/MoneyCount

@onready var grid_baits: GridContainer = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Baits/PanelContainer/MarginContainer/GridBaits
@onready var grid_misc: GridContainer = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/TabContainer/Misc/PanelContainer/MarginContainer/GridMisc


@export var shop_item : PackedScene

@export var bg_curio_music : AudioStreamWAV

#region Hovered item nodes
@onready var hovered_item_texture: TextureRect = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/HoverPreview/MarginContainer/PanelContainer/VBoxContainer/HoveredItemTexture
@onready var hovered_item_name: Label = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/HoverPreview/MarginContainer/PanelContainer/VBoxContainer/HoveredItemName
@onready var hovered_item_desc: Label = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/HoverPreview/MarginContainer/PanelContainer/VBoxContainer/HoveredItemDesc
@onready var hovered_item_price: Label = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/HBoxContainer/HoverPreview/MarginContainer/PanelContainer/VBoxContainer/HBoxContainer/HoveredItemPrice


#endregion


# TODO : make a better system than that. Until then, this is in order : BAIT UPGRADE 1, LAKE TICKET, BAIT UPGRADE 2, BAIT UPGRADE 3
var dev_prices = [300,3000,3000,10000]

var shop_data : Array = [
	{
		"icon_path": "res://materials/ui/menu_buttons/bait-icon.svg",
		"item_name":"Test : Bait Upgrade 1",
		"item_description":"Bait Upgrade 1 :This is a test description for the hover function. Info about the bait upgrade would be here.",
		"item_cost":"100 G",
		"category":"bait"
	},
	{
		"icon_path": "res://materials/ui/menu_buttons/bait-icon.svg",
		"item_name":"Test : Bait Upgrade 2",
		"item_description":"Bait Upgrade 2 : This is a test description for the hover function. Info about the bait upgrade would be here.",
		"item_cost":"100 G",
		"category":"bait"
	},
	{
		"icon_path": "res://materials/ui/menu_buttons/bait-icon.svg",
		"item_name":"Test : Bait Upgrade 3",
		"item_description":"Bait Upgrade 3 :This is a test description for the hover function. Info about the bait upgrade would be here.",
		"item_cost":"100 G",
		"category":"bait"
	},
	{
		"icon_path": "res://materials/ui/menu_buttons/bait-icon.svg",
		"item_name":"Test : Bait Upgrade 4",
		"item_description":"Bait Upgrade 4 : This is a test description for the hover function. Info about the bait upgrade would be here.",
		"item_cost":"100 G",
		"category":"bait"
	},
	{
		"icon_path": "res://materials/ui/menu_buttons/bait-icon.svg",
		"item_name":"Test : Bait Upgrade 5",
		"item_description":"Bait Upgrade 5 : This is a test description for the hover function. Info about the bait upgrade would be here.",
		"item_cost":"100 G",
		"category":"bait"
	},
	{
		"icon_path": "res://materials/ui/menu_buttons/ticket-fill.svg",
		"item_name":"Test : Ticket",
		"item_description":"This is a test description for the hover function. Information about the ticket would be here.",
		"item_cost":"300 G",
		"category":"misc"
	}
]

var shop_item_id : int = 0

func _ready() -> void:
	setup_shop()
	SoundManager.play_music(bg_curio_music)
	update_money()
	#check_all_items_availbability()
	print(Playerinfo.rod_bait_value)

func lock_button(target_button):
	target_button.disabled = true

func update_money():
	money_count.text = str(Playerinfo.money)

#TODO : Change this yandere dev type shit asap. This is misarable. Actually putting me to tears of sadness. This shit outta explode.
#func check_all_items_availbability():
	#var btn_array = [bait_up_1_btn, lake_ticket_btn, bait_up_2_btn, bait_up_3_btn]
	#var ownership_array = [Playerinfo.bait_upgrade_ownership_1, Playerinfo.ticket_ownership_1, Playerinfo.bait_upgrade_ownership_2, Playerinfo.bait_upgrade_ownership_3]
	#var i = 0
	#for item in dev_prices:
		#if (Playerinfo.money < dev_prices[i]) or (ownership_array[i] == true):
			#lock_button(btn_array[i])
		#i += 1

func setup_shop() -> void:
	for data in shop_data:
		var temp = shop_item.instantiate()
		temp.item_buy_pressed.connect(on_item_buy_pressed)
		temp.item_hovered.connect(on_item_hovered)
		match temp.get_category(data):
			"bait":
				grid_baits.add_child(temp)
			"rod":
				print("Item is a rod, but no rod tab is available.")
			"player":
				print("Item is a player upgrade, but no player upgrade tab is available.")
			"misc":
				grid_misc.add_child(temp)
		#grid.add_child(temp)
		temp.setup(data, shop_item_id)
		shop_item_id += 1

func on_item_buy_pressed(id : int) -> void:
	#print(shop_data[id].get("item_name_label")+ " bought.")
	print(shop_data[id]["item_name"])

func on_item_hovered(id : int):
	#hovered_item_texture.texture = shop_data[id]["icon_path"]
	hovered_item_name.text = shop_data[id]["item_name"]
	hovered_item_desc.text = shop_data[id]["item_description"]
	hovered_item_price.text = shop_data[id]["item_cost"]
	
#func _on_lake_ticket_btn_pressed() -> void:
	#Playerinfo.buy_ticket_1()
	#Playerinfo.decrease_money(dev_prices[1])
	#update_money()
	#check_all_items_availbability()
#
#func _on_bait_up_1_btn_pressed() -> void:
	#Playerinfo.buy_bait_upgrade_1()
	#Playerinfo.decrease_money(dev_prices[0])
	#update_money()
	#check_all_items_availbability()
#
#func _on_bait_up_2_btn_pressed() -> void:
	#Playerinfo.buy_bait_upgrade_2()
	#Playerinfo.decrease_money(dev_prices[2])
	#update_money()
	#check_all_items_availbability()
#
#func _on_bait_up_3_btn_pressed() -> void:
	#Playerinfo.buy_bait_upgrade_3()
	#Playerinfo.decrease_money(dev_prices[3])
	#update_money()
	#check_all_items_availbability()

func _on_return_btn_pressed() -> void:
	SoundManager.stop_music(1  )
	var map_id = Playerinfo.playerLocationNumber
	print(map_id)
	match(map_id):
		0:
			get_tree().change_scene_to_file("res://maps/devmap_1.tscn")
		1:
			get_tree().change_scene_to_file("res://maps/fishingspot_river.tscn")
		2:
			get_tree().change_scene_to_file("res://maps/fishingspot_lake.tscn")
		_:
			get_tree().change_scene_to_file("res://maps/fishingspot_river.tscn")
