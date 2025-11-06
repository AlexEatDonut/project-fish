extends PanelContainer

signal rod_item_pressed(id)
signal item_hovered(id)


@onready var rod_icon: TextureRect = $MarginContainer/VBoxContainer/MaxSizeContainer/PanelContainer2/TextureRect

@onready var rod_name_label: Label = $MarginContainer/VBoxContainer/MaxSizeContainer2/PanelContainer/MarginContainer/VBoxContainer/RodNameLabel

@onready var rod_item_btn: Button = $RodItemBtn



var rod_id : int

var upgrade_tier = 0

var id : int

func setup(data: Dictionary, p_id : int) -> void:
	#item_icon.texture = load(data.get("icon_path"))
	#item_icon.texture = load(data.get("res://materials/ui/menu_buttons/bait-icon.svg"))
	rod_name_label.text = data["rod_name"]
	rod_id = int(data["rod_id"])
	id = p_id

func _process(delta: float) -> void:
	is_item_clickable()

func is_item_clickable():
	match check_item_not_owned(rod_id):
		true:
			rod_item_btn.disabled = false
		false :
			rod_item_btn.disabled = true

func check_item_not_owned(rodid : int):
	#if the player DOESN'T own the targetted object, it is not owned and therefore is true
	if !Playerinfo.owned_upgrades.has(rodid):
		return(true)
	else:
		return(false)

func _on_rod_item_btn_pressed() -> void:
	emit_signal("rod_item_pressed", id)
