extends Node3D

@onready var lake_ticket_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/GridTickets/LakesideTicket/MarginContainer/HBoxContainer/VBoxContainer/LakeTicketBtn
@onready var bait_up_1_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/GridUpgrade/BaitUp1/MarginContainer/HBoxContainer/VBoxContainer/BaitUp1Btn
@onready var bait_up_2_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/GridUpgrade/BaitUp2/MarginContainer/HBoxContainer/VBoxContainer/BaitUp2Btn
@onready var bait_up_3_btn: Button = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/VBoxContainer/GridUpgrade/BaitUp3/MarginContainer/HBoxContainer/VBoxContainer/BaitUp3Btn

@onready var money_count: Label = $CanvasLayer/ShopScreen/bgPanel/MarginsPanel/MarginContainer/VBoxContainer/MoneyCount

@export var bg_curio_music : AudioStreamWAV

# TODO : make a better system than that. Until then, this is in order : BAIT UPGRADE 1, LAKE TICKET, BAIT UPGRADE 2, BAIT UPGRADE 3
var dev_prices = [300,3000,3000,10000]

func _ready() -> void:
	SoundManager.play_music(bg_curio_music)
	update_money()
	check_all_items_availbability()
	print(Playerinfo.rod_bait_value)

func lock_button(target_button):
	target_button.disabled = true

func update_money():
	money_count.text = str(Playerinfo.money)

#TODO : Change this yandere dev type shit asap. This is misarable. Actually putting me to tears of sadness. This shit outta explode.
func check_all_items_availbability():
	var btn_array = [bait_up_1_btn, lake_ticket_btn, bait_up_2_btn, bait_up_3_btn]
	var ownership_array = [Playerinfo.bait_upgrade_ownership_1, Playerinfo.ticket_ownership_1, Playerinfo.bait_upgrade_ownership_2, Playerinfo.bait_upgrade_ownership_3]
	var i = 0
	for item in dev_prices:
		if (Playerinfo.money < dev_prices[i]) or (ownership_array[i] == true):
			lock_button(btn_array[i])
		i += 1


func _on_lake_ticket_btn_pressed() -> void:
	Playerinfo.buy_ticket_1()
	Playerinfo.decrease_money(dev_prices[1])
	update_money()
	check_all_items_availbability()

func _on_bait_up_1_btn_pressed() -> void:
	Playerinfo.buy_bait_upgrade_1()
	Playerinfo.decrease_money(dev_prices[0])
	update_money()
	check_all_items_availbability()

func _on_bait_up_2_btn_pressed() -> void:
	Playerinfo.buy_bait_upgrade_2()
	Playerinfo.decrease_money(dev_prices[2])
	update_money()
	check_all_items_availbability()

func _on_bait_up_3_btn_pressed() -> void:
	Playerinfo.buy_bait_upgrade_3()
	Playerinfo.decrease_money(dev_prices[3])
	update_money()
	check_all_items_availbability()

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
