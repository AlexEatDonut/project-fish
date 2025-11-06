extends PanelContainer

signal travel_destination_pressed(id)
signal item_hovered(id)


@onready var location_icon: TextureRect = $MarginContainer/VBoxContainer/MaxSizeContainer/PanelContainer2/TextureRect

@onready var location_name_label: Label = $MarginContainer/VBoxContainer/MaxSizeContainer2/PanelContainer/MarginContainer/VBoxContainer/LocationNameLabel

@onready var travel_item_btn: Button = $TravelItemBtn

var location_id : int

var upgrade_tier = 0

var id : int

func setup(data: Dictionary, p_id : int) -> void:
	#item_icon.texture = load(data.get("icon_path"))
	#item_icon.texture = load(data.get("res://materials/ui/menu_buttons/bait-icon.svg"))
	location_name_label.text = data["location_name"]
	location_id = int(data["location_id"])
	id = p_id

func _process(delta: float) -> void:
	is_item_clickable()

func is_item_clickable():
	match check_item_not_owned(location_id):
		true:
			travel_item_btn.disabled = false
		false :
			travel_item_btn.disabled = true

func check_item_not_owned(locationid : int):
	#if the player DOESN'T own the targetted object, it is not owned and therefore is true
	if !Playerinfo.owned_upgrades.has(locationid):
		return(true)
	else:
		return(false)

func _on_travel_item_btn_pressed() -> void:
	emit_signal("travel_destination_pressed", id)
