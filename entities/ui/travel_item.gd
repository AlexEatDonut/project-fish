extends PanelContainer

signal travel_destination_pressed(id)
signal item_hovered(id)


@onready var location_icon: TextureRect = $MarginContainer/VBoxContainer/MaxSizeContainer/PanelContainer2/TextureRect

var location_thumbs = ["res://materials/ui/travel_locations/location_river_thumb.png","res://materials/ui/travel_locations/location_lake_thumb.png"]

@onready var location_name_label: Label = $MarginContainer/VBoxContainer/MaxSizeContainer2/PanelContainer/MarginContainer/VBoxContainer/LocationNameLabel

@onready var travel_item_btn: Button = $TravelItemBtn

@onready var blur_panel: PanelContainer = $MarginContainer/BlurPanel
@onready var here_label: Label = $MarginContainer/BlurPanel/CenterContainer/HereLabel
@onready var locked_label: Label = $MarginContainer/BlurPanel/CenterContainer/LockedLabel


var location_item_id : int
var location_name : String

var upgrade_tier = 0

var is_locked : bool = false

var id : int

func setup(data: Dictionary, p_id : int) -> void:
	#item_icon.texture = load(data.get("icon_path"))
	#item_icon.texture = load(data.get("res://materials/ui/menu_buttons/bait-icon.svg"))
	location_name_label.text = data["location_name"]
	location_item_id = int(data["item_id"])
	location_name = data["location_name"]
	id = p_id
	change_icon(data["location_id"])
	
	check_item_equipped(data["location_name"])
	check_item_owned(data["location_id"])
	blur_reset()

func _process(delta: float) -> void:
	is_item_clickable(location_item_id, location_name )

func is_item_clickable(locationitemid : int, locationname : String):
	match check_item_owned(locationitemid):
		true:
			pass
		false :
			blur_locked_enable()
	match check_item_equipped(locationname):
		true:
			blur_youarehere_enable()
		false:
			pass

func change_icon(locationid : int):
	var correct_array_id = locationid - 1
	location_icon.texture = load(location_thumbs[correct_array_id])

func check_item_owned(locationid : int):
	#if the player owns the targetted object, it is owned and therefore is true
	if Playerinfo.owned_upgrades.has(locationid) or locationid == 200:
		return(true)
	else:
		return(false)

func check_item_equipped(locationname):
	if Playerinfo.playerLocation == locationname:
		return(true)
	else:
		return(false)

func blur_youarehere_enable() -> void :
	blur_panel.visible = true
	here_label.visible = true
	travel_item_btn.disabled = true
	is_locked = true

func blur_locked_enable() -> void :
	blur_panel.visible = true
	locked_label.visible = true
	travel_item_btn.disabled = true
	is_locked = true

func blur_reset() -> void:
	blur_panel.visible = false
	here_label.visible = false
	locked_label.visible = false
	travel_item_btn.disabled = false
	is_locked = false



func _on_travel_item_btn_pressed() -> void:
	emit_signal("travel_destination_pressed", id)
