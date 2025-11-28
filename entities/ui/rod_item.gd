extends PanelContainer

signal rod_item_pressed(id)
signal item_hovered(id)


@onready var rod_icon: TextureRect = $MarginContainer/VBoxContainer/MaxSizeContainer/PanelContainer2/TextureRect

@onready var rod_name_label: Label = $MarginContainer/VBoxContainer/MaxSizeContainer2/PanelContainer/MarginContainer/VBoxContainer/RodNameLabel

@onready var rod_item_btn: Button = $RodItemBtn

@onready var blur_panel: PanelContainer = $MarginContainer/BlurPanel
@onready var equipped_label: Label = $MarginContainer/BlurPanel/CenterContainer/EquippedLabel
@onready var not_owned_label: Label = $MarginContainer/BlurPanel/CenterContainer/NotOwnedLabel

var is_owned : bool = false

var is_equipped : bool = false


var rod_id : int
var rod_item_id : int

var upgrade_tier = 0

var id : int

func setup(data: Dictionary, p_id : int) -> void:
	#item_icon.texture = load(data.get("icon_path"))
	#item_icon.texture = load(data.get("res://materials/ui/menu_buttons/bait-icon.svg"))
	rod_name_label.text = data["rod_name"]
	rod_id = int(data["rod_id"])
	rod_item_id = int(data["item_id"])
	#print(rod_item_id)
	id = p_id
	is_owned = check_item_owned(rod_item_id)
	is_equipped = check_item_equipped(rod_item_id)
	set_item_equipped()
	is_item_equipable()


func _process(delta: float) -> void:
	set_item_equipped()
	is_item_owned()
	is_item_equipable()

func is_item_owned():
	match check_item_owned(rod_item_id):
		true:
			rod_item_btn.disabled = false
		false :
			rod_item_btn.disabled = true
			blur_panel.visible = true
			not_owned_label.visible = true

func is_item_equipable():
	if Playerinfo.can_switch_rod == true:
		rod_item_btn.disabled = false
	else :
		rod_item_btn.disabled = true

func set_item_equipped():
	match check_item_equipped(rod_item_id):
		true:
			blur_panel.visible = true
			equipped_label.visible = true
		false:
			blur_panel.visible = false
			equipped_label.visible = false

func check_item_owned(rodid : int):
	#if the player owns the targetted object, it is true
	if Playerinfo.owned_upgrades.has(rodid) or rodid == 300:
		return(true)
	else:
		return(false)

func check_item_equipped(rodid : int):
	if Playerinfo.equipped_rod == rodid:
		return(true)
	else:
		return(false)

func _on_rod_item_btn_pressed() -> void:
	emit_signal("rod_item_pressed", id)

func _on_rod_item_btn_mouse_entered() -> void:
	if is_owned == true and !is_equipped:
		blur_panel.visible = true


func _on_rod_item_btn_mouse_exited() -> void:
	if is_owned and !is_equipped:
		blur_panel.visible = false
