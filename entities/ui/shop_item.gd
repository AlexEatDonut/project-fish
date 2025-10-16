extends PanelContainer

signal item_buy_pressed(id)
signal item_hovered(id)


@onready var item_icon: TextureRect = $MarginContainer/VBoxContainer/MaxSizeContainer/PanelContainer2/MarginContainer/TextureRect

@onready var item_name_label: Label = $MarginContainer/VBoxContainer/MaxSizeContainer2/PanelContainer/MarginContainer/VBoxContainer/ItemNameLabel

@onready var item_price_label: Label = $MarginContainer/BlurPanel/CenterContainer/ItemPriceLabel
@onready var blur_panel: PanelContainer = $MarginContainer/BlurPanel

@onready var shop_item_btn: Button = $ShopItemBtn

var item_cost : float = 0
var item_requirement : int = 0

var upgrade_has_tiers = false
var upgrade_tier = 0

var id : int

func setup(data: Dictionary, p_id : int) -> void:
	upgrade_has_tiers = data["tiered_upgrade"]
	#item_icon.texture = load(data.get("icon_path"))
	#item_icon.texture = load(data.get("res://materials/ui/menu_buttons/bait-icon.svg"))
	item_name_label.text = data["item_name"]
	item_price_label.text = str(data["item_cost"])
	item_cost = data["item_cost"]
	item_requirement = int(data["requirements"])
	print(int(data["requirements"]))
	id = p_id

func _process(delta: float) -> void:
	is_item_buyable()

func is_item_buyable():
	match [check_item_cost(),check_item_requirements(item_requirement),check_item_not_owned(int(id))]:
		[true,true,true]:
			shop_item_btn.disabled = false
		_:
			shop_item_btn.disabled = true

func check_item_cost():
	match [item_cost > 0,item_cost <= Playerinfo.money]:
		[true,true]:
			return(true)
		_:
			return(false)

func check_item_requirements(requierement : int):
	if upgrade_has_tiers == true:
		if Playerinfo.owned_upgrades.has(requierement):
			return(true)
		else:
			return(false)
	else:
		return(true)


func check_item_not_owned(id : int):
	if Playerinfo.owned_upgrades.has(id):
		return(false)
	else:
		return(true)

func show_cost()->void:
	blur_panel.visible = true

func hide_cost()->void:
	blur_panel.visible = false

func get_category(data: Dictionary):
	return(data["category"])

func get_icon_id(data: Dictionary):
	return(data["icon_id"])
	
func _on_shop_item_btn_pressed() -> void:
	emit_signal("item_buy_pressed", id)


func _on_shop_item_btn_mouse_entered() -> void:
	emit_signal("item_hovered", id)
	show_cost()

func _on_shop_item_btn_mouse_exited() -> void:
	hide_cost()
