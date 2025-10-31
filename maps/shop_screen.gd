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
## FRESHWATER FISHES - COMMON
@export var spr_bait_generic = Texture2D
#111
@export var spr_ticket_generic = Texture2D
#211


#endregion


# TODO : make a better system than that. Until then, this is in order : BAIT UPGRADE 1, LAKE TICKET, BAIT UPGRADE 2, BAIT UPGRADE 3
var dev_prices = [300,3000,3000,10000]

var shop_data : Array = [
	{
		"item_id":101,
		"icon_id": 111,
		"item_name":"Rare Bait",
		"item_description":"A unique blend of spices bundled into one bait. Allows you to catch rare fishes",
		"item_cost": 300,
		"category":"bait",
		"requirements" : 0
	},
	{
		"item_id" : 102,
		"icon_id": 111,
		"item_name":"Unusual Bait",
		"item_description":"A weird odor comes from this bait, it's unpleasant yet appealing at the same time. Allows you to catch unusual fishes.",
		"item_cost": 1700,
		"category":"bait",
		"requirements" : 101
	},
	{
		"item_id": 103,
		"icon_id": 111,
		"item_name":"Legendary Bait",
		"item_description":"An odorless bait that leaves you wandering if you got scammed. It looks mundane, but you cannot decifer what is in there. Allows you to catch legendary fishes.",
		"item_cost": 6400,
		"category":"bait",
		"requirements" : 102
	},
	{
		"item_id": 201,
		"icon_id": 211,
		"item_name":"Ticket : Lakeside",
		"item_description":"A reusable traveling ticket to the lakeside. Allows access to the lakeside from the Travel menu",
		"item_cost": 3000,
		"category":"misc",
		"requirements" : 0
	},
	{
		"item_id": 202,
		"icon_id": 211,
		"item_name":"Ticket : Port",
		"item_description":"A reusable traveling ticket to the lakeside. Allows access to the lakeside from the Travel menu. NONFUNCTIONAL YET. ONLY FOR TESTING PURPOSES",
		"item_cost": 6000,
		"category":"misc",
		"requirements" : 0
	},
	{
		"item_id": 300,
		"icon_id": 211,
		"item_name":"Wooden Rod",
		"item_description":"Your default rod ! Not very good, but can still get work done.",
		"item_cost": 0,
		"category":"rod",
		"requirements" : -1,
	},
	{
		"item_id": 301,
		"icon_id": 211,
		"item_name":"Fishin' Fun branded rod",
		"item_description":"Your run of the mill store rod. Better than a stick of wood, that's for sure.",
		"item_cost": 48,
		"category":"rod",
		"requirements" : 0,
	},
	{
		"item_id": 302,
		"icon_id": 211,
		"item_name":"'Pro' fisher branded rod",
		"item_description":"A pricier rod equipped with a bait enhancer.",
		"item_cost": 64,
		"category":"rod",
		"requirements" : 0,
	},
	{
		"item_id": 303,
		"icon_id": 211,
		"item_name":"Enticing rod",
		"item_description":"A rod that makes fish want to stay in its bait.",
		"item_cost": 128,
		"category":"rod",
		"requirements" : 0,
	}
]

var shop_item_id : int = 0

func give_item_icon(SpriteRect, spritenumber)->void :
	match spritenumber:
		## BAITS
		111:
			SpriteRect.texture = spr_bait_generic
		## TICKETS 
		211:
			SpriteRect.texture = spr_ticket_generic
		_:
			SpriteRect.texture = null


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
	#SoundManager.play_ui_sound(sfx_money_change)

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
				grid_rods.add_child(temp)
			"player":
				print("Item is a player upgrade, but no player upgrade tab is available.")
			"misc":
				grid_misc.add_child(temp)
		#grid.add_child(temp)
		temp.setup(data, shop_item_id)
		give_item_icon(temp.item_icon, temp.get_icon_id(data) )
		shop_item_id += 1

func on_item_buy_pressed(id : int) -> void:
	print(shop_data[id]["item_name"])
	Playerinfo.decrease_money(shop_data[id]["item_cost"])
	update_money()
	Playerinfo.buy_upgrade(int(shop_data[id]["item_id"]))
	SoundManager.play_ui_sound(sfx_item_bought)

func on_item_hovered(id : int):
	SoundManager.play_ui_sound(sfx_item_hover)
	#hovered_item_texture.texture = shop_data[id]["icon_id"]
	hovered_item_name.text = shop_data[id]["item_name"]
	hovered_item_desc.text = shop_data[id]["item_description"]
	hovered_item_price.text = str(shop_data[id]["item_cost"])
	
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
	SoundManager.stop_music(1)
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


func _on_tab_container_tab_changed(tab: int) -> void:
	SoundManager.play_ui_sound(sfx_change_category)
